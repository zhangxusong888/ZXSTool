//
//  ZXSAreaCell.h
//  Pods-ZXSTool_Example
//
//  Created by zxs on 2020/4/23.
//

#import <UIKit/UIKit.h>
#import "ZXSAreaCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXSAreaCell : UITableViewCell

// 更新cell
- (void)updateWithCellModel:(ZXSAreaCellModel *)cellModel;

@end

NS_ASSUME_NONNULL_END
