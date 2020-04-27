//
//  Tool.h
//  ZXSToolDemo
//
//  Created by zxs on 2020/4/27.
//  Copyright © 2020 kjt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tool : NSObject

// 从故事版读取Controller
+ (nullable UIViewController *)controllerWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
