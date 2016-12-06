//
//  JMProgressView.m
//  DrawRect
//
//  Created by JM Zhao on 2016/12/1.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import "JMProgressView.h"
#import "UIView+Extension.h"

@interface JMProgressView()
@property (nonatomic, weak) UIProgressView *progressV;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UILabel *time;
@property (nonatomic, copy) playAndPause playBlock;

@property (nonatomic, assign) BOOL isPlay;
@end

@implementation JMProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [button setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(playAndPauseBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        self.button = button;
        [self addSubview:button];
        
        UIProgressView *progressV = [[UIProgressView alloc] init];
        self.progressV = progressV;
        [self addSubview:progressV];
        
        UILabel *time = [[UILabel alloc] init];
        time.textColor = [UIColor blueColor];
        time.font = [UIFont systemFontOfSize:12];
        time.textAlignment = 1;
        self.time = time;
        [self addSubview:time];
    }
    
    return self;
}

- (void)playAndPauseBtn:(UIButton *)sender
{
    if (self.isPlay) {
        
        [sender setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateNormal)];
        
    }else{
    
        [sender setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateNormal)];
    }
    
    self.isPlay = !self.isPlay;
    
    if (self.playBlock) {
        
        self.playBlock(self.isPlay);
        
    }
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _progressV.progress = progress;
}

- (void)setSecond:(NSInteger)second
{
    _second = second;
    NSString *sec = [NSString stringWithFormat:@"%02ld", self.second];
    self.time.text = [NSString stringWithFormat:@"%@''",sec];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    self.button.frame = CGRectMake(margin, margin, self.height-margin*2, self.height-margin*2);
    self.progressV.frame = CGRectMake(CGRectGetMaxX(self.button.frame)+10, self.height/2, self.width-CGRectGetMaxX(self.button.frame)-54, 10);
    self.time.frame = CGRectMake(CGRectGetMaxX(self.progressV.frame), self.height/2-15, 44, 30);
};

- (void)playAndPause:(playAndPause)playBlock
{
    self.playBlock = playBlock;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
