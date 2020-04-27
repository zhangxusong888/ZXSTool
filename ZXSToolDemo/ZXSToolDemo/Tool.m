//
//  Tool.m
//  ZXSToolDemo
//
//  Created by zxs on 2020/4/27.
//  Copyright © 2020 kjt. All rights reserved.
//

#import "Tool.h"

@implementation Tool

// 从故事版读取Controller
+ (nullable UIViewController *)controllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    if (storyboard == nil) {
        return nil;
    }
    
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
    if (vc == nil) {
        return nil;
    }
    return vc;
}

@end
