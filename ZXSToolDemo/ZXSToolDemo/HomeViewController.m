//
//  HomeViewController.m
//  ZXSToolDemo
//
//  Created by zxs on 2020/4/27.
//  Copyright © 2020 kjt. All rights reserved.
//

#import "HomeViewController.h"
#import "Tool.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"功能菜单";
}

// 展示省市区选择例子页面
- (IBAction)areaButtonTouched:(id)sender {
    UIViewController *areaVc = [Tool controllerWithStoryboardName:@"Area" identifier:@"AreaViewController"];
    [self.navigationController showViewController:areaVc sender:nil];
}

@end
