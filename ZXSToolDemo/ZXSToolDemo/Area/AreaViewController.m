//
//  AreaViewController.m
//  ZXSToolDemo
//
//  Created by zxs on 2020/4/27.
//  Copyright © 2020 kjt. All rights reserved.
//

#import "AreaViewController.h"
#import <ZXSTool/ZXSTool.h>

@interface AreaViewController ()
// 地区输入框
@property (weak, nonatomic) IBOutlet UITextField *areaTextField;

@property (strong, nonatomic) ZXSAreaModel *selectArea;

@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"省市区选择组件的例子";
}

// 地区选择按钮
- (IBAction)areaButtonTouched:(id)sender {
    [ZXSTool launchAreaSelectorOnContorller:self currentArea:self.selectArea select:^(ZXSAreaModel * _Nonnull selectArea) {
        self.selectArea = selectArea;
        self.areaTextField.text = [NSString stringWithFormat:@"%@%@%@", selectArea.provinceName, selectArea.cityName, selectArea.districtName];
    } cancel:nil];
}


@end
