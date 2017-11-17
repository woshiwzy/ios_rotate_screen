//
//  ViewController.m
//  DemoScreen
//
//  Created by wangzy on 2017/11/17.
//  Copyright © 2017年 wangzy. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //     _currentOrient = [UIApplication  sharedApplication].statusBarOrientation;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"转一转" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeFrame:) forControlEvents:UIControlEventTouchUpInside];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    NSLayoutConstraint * centerX = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint * centerY = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    NSLayoutConstraint * width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    NSLayoutConstraint * height =[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    
    [NSLayoutConstraint activateConstraints:@[centerX,centerY,width,height]];
    centerY.active = YES;
    centerX.active = YES;
    width.active = YES;
    height.active = YES;
    
}
// 允许自动旋转
-(BOOL)shouldAutorotate{
    return YES;
}
// 横屏时是否将状态栏隐藏
-(BOOL)prefersStatusBarHidden{
    return NO;
}
-(void)changeFrame:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self forceOrientationLandscapeWith:self];
    }else{
        [self forceOrientationPortraitWith:self];
    }
}



// 横屏 home键在右边
-(void)forceOrientationLandscapeWith:(UIViewController *)VC{
    
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.isForceportrait=NO;
    appdelegate.isForceLandscape=YES;
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:VC.view.window];
    
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}
// 竖屏
- (void)forceOrientationPortraitWith:(UIViewController *)VC{

    AppDelegate *appdelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    appdelegate.isForceportrait=YES;
    appdelegate.isForceLandscape=NO;
    
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:VC.view.window];
    
    //强制翻转屏幕
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}



@end
