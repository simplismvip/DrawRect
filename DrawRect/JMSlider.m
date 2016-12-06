//
//  JMSlider.m
//  YaoYao
//
//  Created by JM Zhao on 2016/11/26.
//  Copyright © 2016年 JunMingZhaoPra. All rights reserved.
//

#import "JMSlider.h"
#import "UIView+Extension.h"
#define JMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JMColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define JMRandomColor JMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface JMSlider()
@property (nonatomic, weak) UISlider *slider;
@property (nonatomic, weak) UILabel *pageLabel;
@end

@implementation JMSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 左右轨的图片
        UIImage *stetchLeftTrack= [UIImage imageNamed:@"oring"];
        UIImage *stetchRightTrack = [UIImage imageNamed:@"line-2"];
        
        // 滑块图片
        UIImage *thumbImage = [UIImage imageNamed:@"greenDot"];
        UISlider *sliderA=[[UISlider alloc] init];
        sliderA.backgroundColor = [UIColor clearColor];
        sliderA.value=0.0f;
        sliderA.minimumValue=0.0f;
        
        [sliderA setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
        [sliderA setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
        [sliderA setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [sliderA setThumbImage:thumbImage forState:UIControlStateNormal];
        
        // 滑块拖动时的事件
        [sliderA addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [sliderA addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sliderA];
        self.slider = sliderA;
        
        UILabel *pageLabel = [[UILabel alloc] init];
        pageLabel.hidden = YES;
        pageLabel.textAlignment = NSTextAlignmentCenter;
        pageLabel.backgroundColor = JMColor(106, 116, 98);
        pageLabel.textColor = [UIColor whiteColor];
        [self addSubview:pageLabel];
        self.pageLabel = pageLabel;
    }
    return self;
}


- (void)sliderDragUp:(UISlider *)slider
{
    self.pageLabel.hidden = YES;
}

- (void)sliderValueChanged:(UISlider *)slider
{
    self.pageLabel.hidden = NO;
    self.pageLabel.center = CGPointMake(self.width*self.slider.value, 0);
    self.pageLabel.text = [NSString stringWithFormat:@"%.f", slider.value];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.slider.frame = CGRectMake(0, self.bounds.size.height*0.4, self.bounds.size.width, 10);
    self.pageLabel.frame = CGRectMake(0, CGRectGetMinY(self.slider.frame)-15, 20, 15);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
