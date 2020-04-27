//
//  ZXSAreaCell.m
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/23.
//

#import "ZXSAreaCell.h"

@interface ZXSAreaCell ()

// 选项标签
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

// 选中标志
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;

@end

@implementation ZXSAreaCell

// 更新cell
- (void)updateWithCellModel:(ZXSAreaCellModel *)cellModel {
    if (cellModel) {
        self.itemLabel.text = cellModel.name;
        self.selectImage.hidden = !cellModel.isSelect;
    }
}

@end
