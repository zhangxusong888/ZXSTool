//
//  ZXSAreaSelector.h
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/21.
//

#import <Foundation/Foundation.h>
#import "ZXSAreaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXSAreaSelector : NSObject

// present方式显示地区选择
+ (void)launchOnContorller:(UIViewController *)vc currentArea:(nullable ZXSAreaModel *)currentArea select:(nullable void(^)(ZXSAreaModel *selectArea))selectBlock
                    cancel:(nullable void(^)(void))cancelBlock;

@end

NS_ASSUME_NONNULL_END
