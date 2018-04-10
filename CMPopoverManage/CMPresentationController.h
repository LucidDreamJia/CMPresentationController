//
//  CMPresentationController.h
//  CMPresentationController
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 ZhuoYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMPresentationController : UIPresentationController

/** 设置显示的frame */
@property (nonatomic,assign) CGRect presentFrame;
/** 设置显示的中心店 */
@property (nonatomic,assign) CGPoint presentCenter;
/** 设置显示的size */
@property (nonatomic,assign) CGSize presentSize;

@end
