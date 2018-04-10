//
//  CMPresentationAnimator.h
//  CMPresentationController
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 ZhuoYue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CMPresentationAnimatorTypeDefault,//默认
    CMPresentationAnimatorTypeScale,//缩放
    CMPresentationAnimatorTypeTranslation,//Y轴移动
} CMPresentationAnimatorType;

@interface CMPresentationAnimator : NSObject <UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

+ (instancetype)presentationAnimator;

/** 设置显示的frame */
@property (nonatomic,assign) CGRect presentFrame;

/** 居中的必须设置 */
// 设置显示的中心店
@property (nonatomic,assign) CGPoint presentCenter;
// 设置显示的size
@property (nonatomic,assign) CGSize presentSize;

/** 动画的Y偏移量 */
@property (nonatomic,assign) CGFloat translationY;

/** 动画类型 */
@property (nonatomic,assign) CMPresentationAnimatorType animationorType;

@end
