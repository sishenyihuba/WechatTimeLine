//
//  MyNaviViewController.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/3.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "MyNaviViewController.h"

@interface MyNaviViewController ()

@end

@implementation MyNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIApplication.shared.statusBarStyle = .lightContent
//    navigationBar.barTintColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
//    navigationBar.tintColor = UIColor.white
//    navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor colorWithRed: 132/255 green: 132/255 blue: 132/255 alpha:1.0];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

@end
