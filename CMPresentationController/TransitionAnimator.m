//
//  TransitionAnimator.m
//  CMPresentationController
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 ZhuoYue. All rights reserved.
//

#import "TransitionAnimator.h"
#import "CMPresentationController.h"

TransitionAnimator *animator;

@interface TransitionAnimator ()
/** 是否是弹出状态 */
@property (nonatomic,assign) BOOL isPresented;

@end

@implementation TransitionAnimator

+ (instancetype)transitionAnimator {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animator = [[TransitionAnimator alloc] init];
        animator.animationorType = TransitionAnimatorTypeDefault;
    });
    return animator;
}



#pragma mark - 自定义转场动画

//改变弹出View的尺寸
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    CMPresentationController *cmPresentation = [[CMPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    cmPresentation.presentFrame = self.presentFrame;
    cmPresentation.presentCenter = self.presentCenter;
    cmPresentation.presentSize = self.presentSize;
    return cmPresentation;
}

//弹出的时候会执行
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresented = YES;
    return self;
}

//消失的时候会执行
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresented = NO;
    return self;
}


#pragma mark - 弹出和消失动画代理的方法

//动画执行的时间
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

//执行弹出或者消失动画
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    _isPresented ? [self animationForPresentedView:transitionContext] : [self animationForDismissedView:transitionContext];
}

//弹出动画
- (void)animationForPresentedView:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:presentView];
    
    //动画类型
    if (animator.animationorType == TransitionAnimatorTypeDefault) {
        [transitionContext completeTransition:YES];
        
    } else if (animator.animationorType == TransitionAnimatorTypeTranslation) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            if (animator.translationY) {
                presentView.transform = CGAffineTransformMakeTranslation(0, self.translationY);
            }
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        //开始执行动画
        CGAffineTransform transform = CGAffineTransformIdentity;
    
        // 第一步：将view宽高缩至无限小（点）
        presentView.transform = CGAffineTransformScale(transform, CGFLOAT_MIN, CGFLOAT_MIN);
    
        [UIView animateWithDuration:0.3 animations:^{
            // 第二步： 以动画的形式将view慢慢放大至原始大小的1.2倍
            presentView.transform = CGAffineTransformScale(transform, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                // 第三步： 以动画的形式将view恢复至原始大小
                presentView.transform = transform;
    
                [transitionContext completeTransition:YES];
            }];
    
        }];
    }
    
}

//消失动画
- (void)animationForDismissedView:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    CGAffineTransform transform = CGAffineTransformIdentity;

    //动画类型
    if (animator.animationorType == TransitionAnimatorTypeDefault) {
        [dismissView removeFromSuperview];
        [transitionContext completeTransition:YES];
    } else if (animator.animationorType == TransitionAnimatorTypeTranslation) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            if (animator.translationY) {
                dismissView.transform = CGAffineTransformTranslate(transform,0, [UIScreen mainScreen].bounds.size.height);
            }
            
        } completion:^(BOOL finished) {
            [dismissView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            // 第一步： 以动画的形式将view慢慢放大至原始大小的1.2倍
            dismissView.transform = CGAffineTransformScale(transform, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                // 第二步： 以动画的形式将view缩小至原来的1/1000分之1倍
                dismissView.transform = CGAffineTransformScale(transform, 0.001, 0.001);
            } completion:^(BOOL finished) {
                // 第三步： 移除
                [dismissView removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
        }];
    }
    
}

@end
