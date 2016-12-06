//
//  DrawSec.m
//  DrawRect
//
//  Created by JM Zhao on 2016/11/23.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import "DrawSec.h"
#import "JMPainPath.h"
@interface DrawSec()

@property (nonatomic, assign) CGPoint startP;
@property (nonatomic, assign) CGPoint startE;

@property (nonatomic, strong) NSMutableArray *white;
@property (nonatomic, strong) NSMutableArray *black;

@property (nonatomic, strong) NSMutableArray *columArray;
@property (nonatomic, strong) NSMutableArray *rowArray;

@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, assign) BOOL is;

@end

@implementation DrawSec

- (NSMutableArray *)points
{
    if (!_points) {self.points = [NSMutableArray array];}
    return _points;
}

- (NSMutableArray *)rowArray
{
    if (!_rowArray) {
        
        self.rowArray = [NSMutableArray array];
        int j = 0;
        for (int i = 0; i < 50; i ++) {
            
            j += 20;
            [_rowArray addObject:[NSNumber numberWithInt:j]];
        }
    }
    return _rowArray;
}

- (NSMutableArray *)columArray
{
    if (!_columArray) {
        
        self.columArray = [NSMutableArray array];
        
        int j = 0;
        for (int i = 0; i < 25; i ++) {
            
            j += 20;
            [_columArray addObject:[NSNumber numberWithInt:j]];
        }
    }
    return _columArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.white = [NSMutableArray array];
        self.black = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    for (NSNumber *n in self.rowArray) {
        
        CGPoint start = CGPointMake(0, n.intValue);
        CGPoint end = CGPointMake(self.bounds.size.width, n.intValue);
        JMPainPath *bezier = [JMPainPath paintPathWithLineWidth:1 color:[UIColor grayColor] startPoint:start];
        [bezier addLineToPoint:end];
        [[UIColor grayColor] set];
        [bezier stroke];
    }
    
    for (NSNumber *n in self.columArray) {
        
        CGPoint start = CGPointMake(n.intValue, 0);
        CGPoint end = CGPointMake(n.intValue, self.bounds.size.height);
        JMPainPath *bezier = [JMPainPath paintPathWithLineWidth:1 color:[UIColor grayColor] startPoint:start];
        [bezier addLineToPoint:end];
        [[UIColor grayColor] set];
        [bezier stroke];
    }
    
    for (NSValue *value in self.points) {
        
        CGRect rect = value.CGRectValue;
        JMPainPath *bezier = [JMPainPath paintRectWithWidth:1 color:[UIColor redColor] CGRect:rect];
        [[UIColor redColor] set];
        [bezier fill];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    CGFloat x = [self neighborPoint:point.x from:_columArray];
    CGFloat y = [self neighborPoint:point.y from:_rowArray];
    [self getLocation:CGPointMake(x, y)];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    CGPoint xP = [self neighborPoints:point.x from:_columArray];
    CGPoint yP = [self neighborPoints:point.y from:_rowArray];
    CGRect rect = CGRectMake(xP.x, yP.x, xP.x-xP.y, yP.x-yP.y);
    NSValue *value = [NSValue valueWithCGRect:rect];
    [self.points addObject:value];
    [self setNeedsDisplay];
}

- (void)getLocation:(CGPoint)point
{
    UIImageView *view = [[UIImageView alloc] init];
    
    if (self.is) {
        view.image = [UIImage imageNamed:@"01"];
        [self.white addObject:view];
        view.tag = 1;
        _is = NO;
        
    }else {
        view.image = [UIImage imageNamed:@"02"];
        [self.black addObject:view];
        view.tag = 2;
        _is = YES;
    }
    
    view.frame = CGRectMake(0, 0, 15, 15);
    view.center = point;
    [self addSubview:view];
}

// 获取最近点
- (CGFloat)neighborPoint:(CGFloat)point from:(NSMutableArray *)armArray
{
    CGFloat start = point;
    CGFloat end = 0.0;
    CGFloat temp = [armArray.lastObject floatValue];
    for (int i = 0; i < armArray.count; i ++) {
        
        CGFloat current = [armArray[i] floatValue];
        CGFloat abs = fabs(start-current);
        
        if (temp>=abs) {
            
            temp = abs;
        }else{
            
            end = [armArray[i-1] floatValue];
            break;
        }
    }
    return end;
}

// 获取最近点两个点
- (CGPoint)neighborPoints:(CGFloat)point from:(NSMutableArray *)armArray
{
    CGFloat start = point;
    CGFloat temp = [armArray.lastObject floatValue];
    CGPoint points = CGPointMake(0, 0);
    for (int i = 0; i < armArray.count; i ++) {
        
        CGFloat current = [armArray[i] floatValue];
        CGFloat abs = fabs(start-current);
        
        if (temp>=abs) {
            temp = abs;
        }else{
            CGFloat end1 = [armArray[i] floatValue];
            CGFloat end0 = [armArray[i-1] floatValue];
            CGFloat end2 = [armArray[i-2] floatValue];
            if (fabs(end1-point)<fabs(end2-point)) {points = CGPointMake(end0, end2);
            }else{points = CGPointMake(end0, end1);}
            break;
        }
    }
    return points;
}

@end
