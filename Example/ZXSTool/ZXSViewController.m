//
//  ZXSViewController.m
//  ZXSTool
//
//  Created by zxs on 03/20/2020.
//  Copyright (c) 2020 zxs. All rights reserved.
//

#import "ZXSViewController.h"
#import <ZXSTool/ZXSTool.h>

@interface ZXSViewController ()

@end

@implementation ZXSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)areaSelectorButtonTouched:(id)sender {
    [ZXSTool launchAreaSelectorOnContorller:self currentArea:nil select:^(ZXSAreaModel * _Nonnull selectArea) {
        NSLog(@"%@%@%@", selectArea.provinceName, selectArea.cityName, selectArea.districtName);
        NSLog(@"%@%@%@", selectArea.provinceCode, selectArea.cityCode, selectArea.districtCode);
    } cancel:nil];
}


@end
