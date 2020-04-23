//
//  ZXSAreaCellModel.m
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/23.
//

#import "ZXSAreaCellModel.h"

@implementation ZXSAreaCellModel

// 通过省对象创建实例
+ (instancetype)instanceWithProvinceModel:(ZXSProvinceModel *)province {
    ZXSAreaCellModel *cellModel = [[ZXSAreaCellModel alloc] init];
    cellModel.name = province.name;
    cellModel.code = province.code;
    cellModel.isSelect = NO;
    return cellModel;
}

// 通过市对象创建实例
+ (instancetype)instanceWithCityModel:(ZXSCityModel *)city {
    ZXSAreaCellModel *cellModel = [[ZXSAreaCellModel alloc] init];
    cellModel.name = city.name;
    cellModel.code = city.code;
    cellModel.isSelect = NO;
    return cellModel;
}

// 通过区对象创建实例
+ (instancetype)instanceWithDistrictModel:(ZXSDistrictModel *)district {
    ZXSAreaCellModel *cellModel = [[ZXSAreaCellModel alloc] init];
    cellModel.name = district.name;
    cellModel.code = district.code;
    cellModel.isSelect = NO;
    return cellModel;
}

@end
