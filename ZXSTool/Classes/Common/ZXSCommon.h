//
//  ZXSCommon.h
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXSCommon : NSObject

// 读取json文件内容
+ (nullable id)jsonWithFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
