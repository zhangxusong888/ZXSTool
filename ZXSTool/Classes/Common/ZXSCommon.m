//
//  ZXSCommon.m
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/21.
//

#import "ZXSCommon.h"

@implementation ZXSCommon

// 读取json文件内容
+ (nullable id)jsonWithFileName:(NSString *)fileName {
    NSBundle *resourcBundle = [ZXSCommon resourceBundle];
    NSString *filePath = [resourcBundle pathForResource:fileName ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return jsonObject;
}

#pragma mark - private
// 获取资源bundle
// 打包之后，如果是动态库，是一个ZZTool.framwork;里面包含有一个ZZTool.bundle的资源集合
+ (NSBundle *)resourceBundle {
    NSBundle *exeBundle = [NSBundle bundleForClass:[self class]];
    NSString *resourceBundlePath = [exeBundle pathForResource:@"ZXSTool" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:resourceBundlePath];
    return resourceBundle;
}

@end
