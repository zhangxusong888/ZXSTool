//
//  ZXSAreaSelectorViewController.m
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/22.
//

#import "ZXSAreaSelectorViewController.h"
#import "ZXSMacro.h"

static CGFloat const kIndexStep = 80.0;

// 省市区索引
typedef NS_ENUM(NSInteger,KJTAreaIndex) {
    KJTAreaIndexProvince = 0,
    KJTAreaIndexCity= 1,
    KJTAreaIndexDistrict = 2,
    KJTAreaIndexUndefined = -1,
};

@interface ZXSAreaSelectorViewController ()

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

// 省市区索引
@property (assign, nonatomic) KJTAreaIndex areaIndex;

@end

@implementation ZXSAreaSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.areaIndex = KJTAreaIndexProvince;
}

// 市按钮响应
- (IBAction)cityButtonTouched:(id)sender {
    // 设置索引为市
    self.areaIndex = KJTAreaIndexCity;
}

// 区按钮响应
- (IBAction)districtButtonTouched:(id)sender {
    // 设置索引为区
    self.areaIndex = KJTAreaIndexDistrict;
}

@end
