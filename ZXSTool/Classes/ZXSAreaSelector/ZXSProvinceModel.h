//
//  ZXSProvinceModel.h
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/21.
//

#import <Foundation/Foundation.h>
#import "ZXSCityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXSProvinceModel : NSObject

// 名称
@property (copy, nonatomic) NSString *name;

// 编码
@property (copy, nonatomic) NSString *code;

// 所属的市
@property (copy, nonatomic) NSArray<ZXSCityModel *> *cityArray;

@end

NS_ASSUME_NONNULL_END
