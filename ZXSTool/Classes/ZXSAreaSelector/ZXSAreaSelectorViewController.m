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

// 省市区索引
@property (assign, nonatomic) ZXSAreaIndex areaIndex;

@end

@implementation ZXSAreaSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 表格设置
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    self.areaTableView.tableFooterView = [[UIView alloc] init]; // 空数据时防止出现分隔条纹
    self.areaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    
}

#pragma mark - setter 当做属性观察来用
// 数据源改变，就更新表格
- (void)setDataSource:(NSArray<ZXSAreaCellModel *> *)dataSource {
    _dataSource = dataSource;
    [self.areaTableView reloadData];
}

// 设置省数组，就更新表格数据源到省列表
- (void)setProvinceArray:(NSArray<ZXSProvinceModel *> *)provinceArray {
    _provinceArray = provinceArray;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [provinceArray enumerateObjectsUsingBlock:^(ZXSProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZXSAreaCellModel *cellModel = [ZXSAreaCellModel instanceWithProvinceModel:obj];
        [tempArray addObject:cellModel];
    }];
    self.dataSource = [tempArray copy];
}

// 根据索引设置下划线位置和标签颜色
- (void)setAreaIndex:(ZXSAreaIndex)areaIndex {
    _areaIndex = areaIndex;
    
    // 下划线位置
    self.maskLeftConstant.constant = self.areaIndex * kIndexStep;
    
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
}

@end
