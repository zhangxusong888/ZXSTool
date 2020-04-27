//
//  ZXSAreaModel.h
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXSAreaModel : NSObject

// 省名称
@property (copy, nonatomic) NSString *provinceName;

// 省编码
@property (copy, nonatomic) NSString *provinceCode;

// 市名称
@property (copy, nonatomic) NSString *cityName;

// 市编码
@property (copy, nonatomic) NSString *cityCode;

// 区名称
@property (copy, nonatomic) NSString *districtName;

// 区编码
@property (copy, nonatomic) NSString *districtCode;

@end

NS_ASSUME_NONNULL_END
