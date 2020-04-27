//
//  ZXSTool.m
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/21.
//

#import "ZXSTool.h"

@implementation ZXSTool

// present方式显示地区选择页面
+ (void)launchAreaSelectorOnContorller:(UIViewController *)vc currentArea:(nullable ZXSAreaModel *)currentArea select:(nullable void(^)(ZXSAreaModel *selectArea))selectBlock
                    cancel:(nullable void(^)(void))cancelBlock {
    [ZXSAreaSelector launchOnContorller:vc currentArea:currentArea select:selectBlock cancel:cancelBlock];
}

@end
