//
//  ViewController.m
//  DrawRect
//
//  Created by JM Zhao on 2016/11/21.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "Draw.h"
#import "DrawSec.h"
#import "JMSlider.h"
#import "JMProgressView.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *columArray;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timertt;
@property (nonatomic, weak) JMProgressView *slider;
@property (nonatomic, assign) CGFloat pro;
@property (nonatomic, assign) NSInteger sec;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    JMProgressView *slider = [[JMProgressView alloc] initWithFrame:CGRectMake(50, 200, self.view.width-100, 38)];
//    [slider playAndPause:^(BOOL isPlay) {
//        
//        if (isPlay) {
//            
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scheduled) userInfo:nil repeats:YES];
//            self.timertt = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scheduledSec) userInfo:nil repeats:YES];
//            
//        }else{
//        
//            [self.timer invalidate];
//            self.timer = nil;
//            
//            [self.timertt invalidate];
//            self.timertt = nil;
//        }
//    }];
//    slider.layer.cornerRadius = 15;
//    slider.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:slider];
//    self.slider = slider;
    
    
    
//    DrawSec *d = [[DrawSec alloc] initWithFrame:self.view.bounds];
//    d.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:d];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _point = [[touches anyObject] locationInView:self.view];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint pointE = [[touches anyObject] locationInView:self.view];
    CGRect rect = CGRectMake(_point.x, _point.y, fabs(pointE.x-_point.x), fabs(pointE.y-_point.y));
    
    UITextField *text = [[UITextField alloc] initWithFrame:rect];
    
    
}


- (void)scheduled
{
    self.sec ++;
    self.slider.second = self.sec;
}

- (void)scheduledSec
{
    self.pro += 0.05;
    
    if (self.pro>1.0) {
        
        self.pro = 0.0;
    }
    
    self.slider.progress = _pro;
}


- (NSMutableArray *)columArray
{
    if (!_columArray) {
        
        self.columArray = [NSMutableArray array];
    }
    
    return _columArray;
}

- (void)didReceiveMemoryWarning {
    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    view.backgroundColor = [UIColor greenColor];
    //    view.center = self.view.center;
    //    [self.view addSubview:view];
    //
    //
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
