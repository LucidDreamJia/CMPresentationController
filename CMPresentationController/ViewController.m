//
//  ViewController.m
//  CMPresentationController
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 ZhuoYue. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "CMPresentationController.h"
#import "CMPresentationAnimator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)presentClick:(UIButton *)sender {
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.modalPresentationStyle = UIModalPresentationCustom;
    firstVC.transitioningDelegate = [CMPresentationAnimator presentationAnimator];
 
    [CMPresentationAnimator presentationAnimator].presentCenter= CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    [CMPresentationAnimator presentationAnimator].presentSize = CGSizeMake(200, 200);
    [CMPresentationAnimator presentationAnimator].animationorType = CMPresentationAnimatorTypeCenter;
    [CMPresentationAnimator presentationAnimator].translationY = - ([UIScreen mainScreen].bounds.size.height / 2);
    
    [self presentViewController:firstVC animated:YES completion:nil];
    
}


- (IBAction)bottomClick:(UIButton *)sender {
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.modalPresentationStyle = UIModalPresentationCustom;
    firstVC.transitioningDelegate = [CMPresentationAnimator presentationAnimator];
    
    [CMPresentationAnimator presentationAnimator].presentFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200);
    [CMPresentationAnimator presentationAnimator].translationY = - 200;
    [CMPresentationAnimator presentationAnimator].animationorType = CMPresentationAnimatorTypeTranslation;
    
    [self presentViewController:firstVC animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
