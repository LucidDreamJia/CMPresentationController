//
//  CMPresentationController.m
//  CMPresentationController
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 ZhuoYue. All rights reserved.
//

#import "CMPresentationController.h"
#import "CMPresentationAnimator.h"

@implementation CMPresentationController

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    
    //添加蒙版
    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    [self.containerView insertSubview:coverView atIndex:0];
    [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    
    //设置弹出View的尺寸
    if ([CMPresentationAnimator presentationAnimator].animationorType != CMPresentationAnimatorTypeCenter) {
        
        self.presentedView.transform = CGAffineTransformIdentity;
        
        self.presentedView.frame = self.presentFrame;
        
        
    } else {
        CGRect pframe = self.presentedView.frame;
        pframe.size.width = self.presentSize.width;
        pframe.size.height = self.presentSize.height;
        self.presentedView.frame = pframe;
        
        self.presentedView.center = self.presentCenter;
    }
    
    
}

- (void)tapClick {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
