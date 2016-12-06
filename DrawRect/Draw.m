//
//  Draw.m
//  DrawRect
//
//  Created by JM Zhao on 2016/11/21.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import "Draw.h"
#import "JMPainPath.h"

@interface Draw()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, assign) CGPoint startP;
@property (nonatomic, assign) BOOL isMove;
@end

@implementation Draw

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        pinch.delegate = self;
        [self addGestureRecognizer:pinch];
        
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
        rotation.delegate = self;
        [self addGestureRecognizer:rotation];
        
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
        tapgesture.delegate = self;
        tapgesture.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tapgesture];
    }
    return self;
}

#pragma 轻拍手势
- (void)handleTapGesture:(UITapGestureRecognizer *)tapgesture
{
    self.isMove = !self.isMove;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    self.transform = CGAffineTransformScale(self.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
    NSLog(@"捏合 = %@", NSStringFromCGRect(self.frame));
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    self.transform = CGAffineTransformRotate(self.transform, rotation.rotation);
    rotation.rotation = 0;
    NSLog(@"旋转 = %@", NSStringFromCGRect(self.frame));
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// 获取触摸点
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

#pragma mark -- 1> 确定起点
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    // 获取触摸点
    self.startP = [self pointWithTouches:touches];
}

#pragma mark -- 2> 确定路径
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    // 获取触摸点
    if (self.isMove) {
        
        UITouch *touch = [touches anyObject];
        CGPoint currentP = [touch locationInView:self];
        CGPoint preP = [touch previousLocationInView:self];
        CGFloat offsetX = currentP.x - preP.x;
        CGFloat offsetY = currentP.y - preP.y;
        self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
        
    }else{
        CGPoint pos = [self pointWithTouches:touches];
        CGRect rect = CGRectMake(_startP.x, _startP.y, fabs(pos.x-_startP.x), fabs(pos.y-_startP.y));
        
        JMPainPath *path = [JMPainPath paintEllipseWithWidth:3.0 color:[UIColor redColor] CGRect:rect];
        [self.paths addObject:path];
        [self setNeedsDisplay];
    }
}

#pragma mark -- 3> 确定终点
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取触摸点
    CGPoint pos = [self pointWithTouches:touches];
    CGRect rect = CGRectMake(_startP.x, _startP.y, fabs(pos.x-_startP.x), fabs(pos.y-_startP.y));
    
    JMPainPath *path = [JMPainPath paintEllipseWithWidth:3.0 color:[UIColor redColor] CGRect:rect];
    [self.points addObject:path];
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

// 把之前的全部清空 重新绘制
- (void)drawRect:(CGRect)rect
{
    for (JMPainPath *paths in self.points) {
        
        [paths.color set];
        [paths stroke];
    }
    
    JMPainPath *path = self.paths.lastObject;
    [path.color set];
    [path stroke];
}

- (NSMutableArray *)paths
{
    if (_paths == nil) {_paths = [NSMutableArray array];}
    return _paths;
}

- (NSMutableArray *)points
{
    if (!_points) {self.points = [NSMutableArray array];}
    return _points;
}

@end
