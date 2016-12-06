//
//  JMProgressView.h
//  DrawRect
//
//  Created by JM Zhao on 2016/12/1.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^playAndPause)(BOOL isPlay);

@interface JMProgressView : UIView

- (void)playAndPause:(playAndPause)playBlock;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) NSInteger second;
@end
