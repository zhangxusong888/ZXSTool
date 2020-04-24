//
//  ZXSAreaSelectorViewController.m
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/22.
//

#import "ZXSAreaSelectorViewController.h"
#import "ZXSMacro.h"
#import "ZXSAreaCell.h"
#import "ZXSAreaCellModel.h"

static CGFloat const kIndexStep = 80.0;

// 省市区索引
typedef NS_ENUM(NSInteger,ZXSAreaIndex) {
    ZXSAreaIndexProvince = 0,
    ZXSAreaIndexCity= 1,
    ZXSAreaIndexDistrict = 2,
    ZXSAreaIndexUndefined = -1,
};

@interface ZXSAreaSelectorViewController ()<UITableViewDelegate, UITableViewDataSource>

// 省按钮
@property (weak, nonatomic) IBOutlet UIButton *provinceButton;
// 省标签
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;

// 市按钮
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
// 市标签
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

// 区按钮
@property (weak, nonatomic) IBOutlet UIButton *districtButton;
// 区标签
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;

// 蒙板视图
@property (weak, nonatomic) IBOutlet UIView *maskView;
// 蒙板左边距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maskLeftConstant;

// 地区表格
@property (weak, nonatomic) IBOutlet UITableView *areaTableView;
// 表格数据源
@property (copy, nonatomic) NSArray<ZXSAreaCellModel *> *dataSource;
// 省表格数据；外部设置所有省市区数据的时候可以确定
@property (copy, nonatomic) NSArray<ZXSAreaCellModel *> *provinceDataSource;
// 市表格数据；选定省之后，所在省的市
@property (copy, nonatomic) NSArray<ZXSAreaCellModel *> *cityDataSource;
// 区表格数据；选定市之后，所在市的区
@property (copy, nonatomic) NSArray<ZXSAreaCellModel *> *districtDataSource;

// 省市区索引
@property (assign, nonatomic) ZXSAreaIndex areaIndex;

// 选中记录
@property (strong, nonatomic) ZXSProvinceModel *selectProvince;
@property (strong, nonatomic) ZXSCityModel *selectCity;
@property (strong, nonatomic) ZXSDistrictModel *selectDistrict;
@property (assign, nonatomic) BOOL isSelectProvince;
@property (assign, nonatomic) BOOL isSelectCity;
@property (assign, nonatomic) BOOL isSelectDistrict;

@end

@implementation ZXSAreaSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 表格设置
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    self.areaTableView.tableFooterView = [[UIView alloc] init]; // 空数据时防止出现分隔条纹
    self.areaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 配置当前选中情况
    [self configCurrentArea];
}

- (void)dealloc {
    NSLog(@"地址选择页面退出了");
}

#pragma mark - action
// 取消按钮响应
- (IBAction)cancelButtonTouched:(id)sender {
    kWeakSelf(self)
    [self dismissViewControllerAnimated:YES completion:^{
        kStrongSelf(self)
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }];
}

// 省按钮响应
- (IBAction)provinceButtonTouched:(id)sender {
    // 设置索引为省
    self.areaIndex = ZXSAreaIndexProvince;
}

// 市按钮响应
- (IBAction)cityButtonTouched:(id)sender {
    // 设置索引为市
    self.areaIndex = ZXSAreaIndexCity;
}

// 区按钮响应
- (IBAction)districtButtonTouched:(id)sender {
    // 设置索引为区
    self.areaIndex = ZXSAreaIndexDistrict;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

// 单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"ZXSAreaCell";
    ZXSAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    ZXSAreaCellModel *cellModel = self.dataSource[indexPath.row];
    [cell updateWithCellModel:cellModel];
    
    return cell;
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

// 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 根据选择状态，修改数据源
    ZXSAreaCellModel *cellModel = self.dataSource[indexPath.row];
    
    // 选择了省
    if (self.areaIndex == ZXSAreaIndexProvince) {
        // 选择和上次一样，什么也不做
        if (self.isSelectProvince && [self.selectProvince.code isEqualToString:cellModel.code]) {
            return;
        }
        
        // 修改省表格数据中的选中标志
        [self.provinceDataSource enumerateObjectsUsingBlock:^(ZXSAreaCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.code isEqualToString:cellModel.code]) {
                obj.isSelect = YES;
            } else {
                obj.isSelect = NO;
            }
        }];
        
        // 确定当前选择的省
        [self.provinceArray enumerateObjectsUsingBlock:^(ZXSProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.code isEqualToString:cellModel.code]) {
                self.selectProvince = obj;
                *stop = YES;
            }
        }];
        
        // 确定当前省的市数据
        NSMutableArray *tempArray = [NSMutableArray array];
        [self.selectProvince.cityArray enumerateObjectsUsingBlock:^(ZXSCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXSAreaCellModel *cityCellModel = [ZXSAreaCellModel instanceWithCityModel:obj];
            [tempArray addObject:cityCellModel];
        }];
        self.cityDataSource = [tempArray copy];
        
        // 设置选中标志
        self.provinceLabel.text = cellModel.name;
        self.isSelectProvince = YES;
        
        // 自动移动到城市选择
        self.isSelectCity = NO;
        self.areaIndex = ZXSAreaIndexCity;
        
        return;
    }
    
    // 选择了市
    if (self.areaIndex == ZXSAreaIndexCity) {
        // 选择和上次一样，什么也不做
        if (self.isSelectCity && [self.selectCity.code isEqualToString:cellModel.code]) {
            return;
        }
        
        // 修改市表格数据中的选中标志
        [self.cityDataSource enumerateObjectsUsingBlock:^(ZXSAreaCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.code isEqualToString:cellModel.code]) {
                obj.isSelect = YES;
            } else {
                obj.isSelect = NO;
            }
        }];
        
        // 确定当前选择的市
        [self.selectProvince.cityArray enumerateObjectsUsingBlock:^(ZXSCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.code isEqualToString:cellModel.code]) {
                self.selectCity = obj;
                *stop = YES;
            }
        }];
        
        // 确定地区数据
        NSMutableArray *tempArray = [NSMutableArray array];
        [self.selectCity.districtArray enumerateObjectsUsingBlock:^(ZXSDistrictModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXSAreaCellModel *cityCellModel = [ZXSAreaCellModel instanceWithDistrictModel:obj];
            [tempArray addObject:cityCellModel];
        }];
        self.districtDataSource = [tempArray copy];
        
        // 设置选中标志
        self.cityLabel.text = cellModel.name;
        self.isSelectCity = YES;
        
        // 自动移动到地区选择
        self.areaIndex = ZXSAreaIndexDistrict;
        self.isSelectDistrict = NO;
        
        return;
    }
    
    // 选择了区
    if (self.areaIndex == ZXSAreaIndexDistrict) {
        // 修改地区数据中的选中标志
        [self.districtDataSource enumerateObjectsUsingBlock:^(ZXSAreaCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.code isEqualToString:cellModel.code]) {
                obj.isSelect = YES;
            } else {
                obj.isSelect = NO;
            }
        }];
        
        // 确定当前选择的地区
        [self.selectCity.districtArray enumerateObjectsUsingBlock:^(ZXSDistrictModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.code isEqualToString:cellModel.code]) {
                self.selectDistrict = obj;
                *stop = YES;
            }
        }];
        
        // 设置选中标志
        self.districtLabel.text = cellModel.name;
        self.isSelectDistrict = YES;
        
        // 退出，并执行回调函数
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.selectBlock) {
                ZXSAreaModel *selectArea = [[ZXSAreaModel alloc] init];
                selectArea.provinceName = self.selectProvince.name;
                selectArea.provinceCode = self.selectProvince.code;
                selectArea.cityName = self.selectCity.name;
                selectArea.cityCode = self.selectCity.code;
                selectArea.districtName = self.selectDistrict.name;
                selectArea.districtCode = self.selectDistrict.code;
                self.selectBlock(selectArea);
            }
        }];
        return;
    }
}

#pragma mark - setter 当做属性观察来用
// 数据源改变，就更新表格
- (void)setDataSource:(NSArray<ZXSAreaCellModel *> *)dataSource {
    _dataSource = dataSource;
    [self.areaTableView reloadData];
}

// 根据索引设置下划线位置和标签颜色
- (void)setAreaIndex:(ZXSAreaIndex)areaIndex {
    _areaIndex = areaIndex;
    
    // 下划线位置
    self.maskLeftConstant.constant = areaIndex * kIndexStep;
    
    // 标签颜色
    switch (areaIndex) {
        case ZXSAreaIndexProvince:
            self.provinceLabel.textColor = kBlueColor;
            self.cityLabel.textColor = kBlackColor087;
            self.districtLabel.textColor = kBlackColor087;
            break;
        case ZXSAreaIndexCity:
            self.provinceLabel.textColor = kBlackColor087;
            self.cityLabel.textColor = kBlueColor;
            self.districtLabel.textColor = kBlackColor087;
            break;
        case ZXSAreaIndexDistrict:
            self.provinceLabel.textColor = kBlackColor087;
            self.cityLabel.textColor = kBlackColor087;
            self.districtLabel.textColor = kBlueColor;
            break;
        default:
            break;
    }
    
    // 表格数据源设置
    switch (areaIndex) {
        case ZXSAreaIndexProvince:
            self.dataSource = self.provinceDataSource;
            break;
        case ZXSAreaIndexCity:
            self.dataSource = self.cityDataSource;
            break;
        case ZXSAreaIndexDistrict:
            self.dataSource = self.districtDataSource;
            break;
        default:
            break;
    }
}

// 省的选择标志控制市的按钮和标签隐藏
- (void)setIsSelectProvince:(BOOL)isSelectProvince {
    _isSelectProvince = isSelectProvince;
    
    if (isSelectProvince) {
        self.cityButton.enabled = YES;
        self.cityLabel.hidden = NO;
    } else {
        self.cityButton.enabled = NO;
        self.cityLabel.hidden = YES;
        self.provinceLabel.text = @"请选择";
    }
}

// 市的选择标志控制区的按钮和标签隐藏
- (void)setIsSelectCity:(BOOL)isSelectCity {
    _isSelectCity = isSelectCity;
    
    if (isSelectCity) {
        self.districtButton.enabled = YES;
        self.districtLabel.hidden = NO;
    } else {
        self.districtButton.enabled = NO;
        self.districtLabel.hidden = YES;
        self.cityLabel.text = @"请选择";
    }
}

// 市的选择标志控制区的按钮
- (void)setIsSelectDistrict:(BOOL)isSelectDistrict {
    _isSelectDistrict = isSelectDistrict;
    
    if (isSelectDistrict) {
        self.districtButton.enabled = YES;
        self.districtLabel.hidden = NO;
    } else {
        self.districtLabel.text = @"请选择";
    }
}

#pragma mark - private
- (void)configCurrentArea {
    if (self.currentArea) {
        // 设置选中的省
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray removeAllObjects];
        [self.provinceArray enumerateObjectsUsingBlock:^(ZXSProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXSAreaCellModel *cellModel = [ZXSAreaCellModel instanceWithProvinceModel:obj];
            if ([obj.code isEqualToString:self.currentArea.provinceCode]) {
                cellModel.isSelect = YES;
                self.selectProvince = obj;
            }
            [tempArray addObject:cellModel];
        }];
        self.provinceDataSource = [tempArray copy];
        self.provinceLabel.text = self.currentArea.provinceName;
        self.isSelectProvince = YES;
        
        // 设置选中的市
        [tempArray removeAllObjects];
        [self.selectProvince.cityArray enumerateObjectsUsingBlock:^(ZXSCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXSAreaCellModel *cellModel = [ZXSAreaCellModel instanceWithCityModel:obj];
            if ([obj.code isEqualToString:self.currentArea.cityCode]) {
                cellModel.isSelect = YES;
                self.selectCity = obj;
            }
            [tempArray addObject:cellModel];
        }];
        self.cityDataSource = [tempArray copy];
        self.cityLabel.text = self.currentArea.cityName;
        self.isSelectCity = YES;
        
        // 设置选中的区
        [tempArray removeAllObjects];
        [self.selectCity.districtArray enumerateObjectsUsingBlock:^(ZXSDistrictModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXSAreaCellModel *cellModel = [ZXSAreaCellModel instanceWithDistrictModel:obj];
            if ([obj.code isEqualToString:self.currentArea.districtCode]) {
                cellModel.isSelect = YES;
                self.selectDistrict = obj;
            }
            [tempArray addObject:cellModel];
        }];
        self.districtDataSource = [tempArray copy];
        self.districtLabel.text = self.currentArea.districtName;
        self.isSelectDistrict = YES;
        
        // 展示区数据
        self.areaIndex = ZXSAreaIndexDistrict;
    } else {
        // 省表格数据源
        NSMutableArray *tempArray = [NSMutableArray array];
        [self.provinceArray enumerateObjectsUsingBlock:^(ZXSProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXSAreaCellModel *cellModel = [ZXSAreaCellModel instanceWithProvinceModel:obj];
            [tempArray addObject:cellModel];
        }];
        self.provinceDataSource = [tempArray copy];
        self.isSelectProvince = NO;
        self.isSelectCity = NO;
        self.isSelectDistrict = NO;
        
        // 展示省数据
        self.areaIndex = ZXSAreaIndexProvince;
    }
}

@end
