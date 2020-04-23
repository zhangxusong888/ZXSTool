//
//  ZXSAreaCellModel.h
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/23.
//

#import <Foundation/Foundation.h>
#import "ZXSProvinceModel.h"
#import "ZXSCityModel.h"
#import "ZXSDistrictModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXSAreaCellModel : NSObject

// 省市区的名称
@property (copy, nonatomic) NSString *name;

// 省市区的编码
@property (copy, nonatomic, nullable) NSString *code;

// 是否选中
@property (assign, nonatomic) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
