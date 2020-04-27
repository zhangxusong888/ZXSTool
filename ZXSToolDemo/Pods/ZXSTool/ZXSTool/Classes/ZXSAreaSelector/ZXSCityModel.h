//
//  ZXSCityModel.h
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/21.
//

#import <Foundation/Foundation.h>
#import "ZXSDistrictModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXSCityModel : NSObject

// 名称
@property (copy, nonatomic) NSString *name;

// 编码
@property (copy, nonatomic) NSString *code;

// 所属的区
@property (copy, nonatomic) NSArray<ZXSDistrictModel *> *districtArray;

@end

NS_ASSUME_NONNULL_END
