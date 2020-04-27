//
//  ZXSAreaSelector.m
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/21.
//

#import "ZXSAreaSelector.h"
#import "ZXSCommon.h"
#import "ZXSProvinceModel.h"
#import "ZXSCityModel.h"
#import "ZXSDistrictModel.h"
#import "ZXSAreaSelectorViewController.h"

@implementation ZXSAreaSelector

// present方式显示地区选择
+ (void)launchOnContorller:(UIViewController *)vc currentArea:(nullable ZXSAreaModel *)currentArea select:(nullable void(^)(ZXSAreaModel *selectArea))selectBlock
                    cancel:(nullable void(^)(void))cancelBlock {
    // 加载地区json文件
    NSDictionary *areaDictionary = (NSDictionary *)[ZXSCommon jsonWithFileName:@"ZXSArea"];
    // 字典数据Model化，方便使用;
    NSArray *originalProvinceArray = areaDictionary[@"provinces"][@"province"];
    NSMutableArray<ZXSProvinceModel *> *tempProvinceArray = [NSMutableArray array];
    [tempProvinceArray removeAllObjects];
    [originalProvinceArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull provinceDictioanry, NSUInteger idx, BOOL * _Nonnull stop) {
        ZXSProvinceModel *province = [[ZXSProvinceModel alloc] init];
        province.name = provinceDictioanry[@"ssqname"];
        province.code = provinceDictioanry[@"ssqid"];
        NSArray *originalCityArray = provinceDictioanry[@"cities"][@"city"];
        NSMutableArray<ZXSCityModel *> *tempCityArray = [NSMutableArray array];
        [tempCityArray removeAllObjects];
        [originalCityArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull cityDictioanry, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXSCityModel *city = [[ZXSCityModel alloc] init];
            city.name = cityDictioanry[@"ssqname"];
            city.code = cityDictioanry[@"ssqid"];
            NSArray *originalDistrictArray = cityDictioanry[@"areas"][@"area"];
            NSMutableArray<ZXSDistrictModel *> *tempDistrictArray = [NSMutableArray array];
            [tempDistrictArray removeAllObjects];
            [originalDistrictArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull districtDictionary, NSUInteger idx, BOOL * _Nonnull stop) {
                ZXSDistrictModel *district = [[ZXSDistrictModel alloc] init];
                district.name = districtDictionary[@"ssqname"];
                district.code = districtDictionary[@"ssqid"];
                [tempDistrictArray addObject:district];
            }];
            city.districtArray = [tempDistrictArray copy];
            [tempCityArray addObject:city];
        }];
        province.cityArray = [tempCityArray copy];
        [tempProvinceArray addObject:province];
    }];
    NSArray *provinceModelArray = [tempProvinceArray copy];
    
    // 读取故事版资源
    ZXSAreaSelectorViewController *areaVc = (ZXSAreaSelectorViewController *)[ZXSCommon controllerWithStoryboardName:@"ZXSArea" identifier:@"ZXSAreaSelectorViewController"];
    
    // 设置省市区数据源
    areaVc.provinceArray = provinceModelArray;
    
    // 设置回调属性
    if (currentArea) {
        areaVc.currentArea = currentArea;
    }
    if (selectBlock) {
        areaVc.selectBlock = selectBlock;
    }
    if (cancelBlock) {
        areaVc.cancelBlock = cancelBlock;
    }
    
    // 全屏present方式展示对话框
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:areaVc animated:YES completion:nil];
}

@end
