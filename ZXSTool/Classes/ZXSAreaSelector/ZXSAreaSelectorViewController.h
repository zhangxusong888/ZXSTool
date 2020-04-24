//
//  ZXSAreaSelectorViewController.h
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/22.
//

#import <UIKit/UIKit.h>
#import "ZXSAreaModel.h"
#import "ZXSProvinceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXSAreaSelectorViewController : UIViewController

// 当前选中地区；
@property (strong, nonatomic, nullable) ZXSAreaModel *currentArea;

// 选择后的block
@property (copy, nonatomic, nullable) void(^selectBlock)(ZXSAreaModel *selectArea);

// 取消的block
@property (copy, nonatomic, nullable) void(^cancelBlock)(void);

// 通过所有的省数据
@property (strong, nonatomic, nonnull) NSArray<ZXSProvinceModel *> *provinceArray;

@end

NS_ASSUME_NONNULL_END
