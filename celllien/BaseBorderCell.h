//
//  BaseCell.h
//  celllien
//
//  Created by jiaxin on 15/12/9.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

//此cell只简单负责border的配置，cell中的内容可以继承于此类再进行封装

typedef NS_ENUM(NSUInteger, BaseCellBorderStyle) {
    BaseCellBorderStyleNoRound = 0,
    BaseCellBorderStyleTopRound,
    BaseCellBorderStyleBottomRound,
    BaseCellBorderStyleAllRound,
};

@interface BaseBorderCell : UITableViewCell

@property (nonatomic, assign) BaseCellBorderStyle borderStyle;//边框类型
@property (nonatomic, strong) UIColor *contentBorderColor;//边框颜色
@property (nonatomic, strong) UIColor *contentBackgroundColor;//边框内部内容颜色
@property (nonatomic, assign) CGFloat contentBorderWidth;//边框的宽度，这个宽度的一半会延伸到外部
@property (nonatomic, assign) CGFloat contentMargin;//左右距离父视图的边距
@property (nonatomic, assign) CGSize contentCornerRadius;//边框的圆角

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
//如果不想用上面的方法初始化cell，就用下面的方法设置borderStyle
- (void)setBorderStyleWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
