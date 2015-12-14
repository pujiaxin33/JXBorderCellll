//
//  BaseCell.m
//  celllien
//
//  Created by jiaxin on 15/12/9.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "BaseBorderCell.h"

#define Width self.contentView.frame.size.width
#define Height self.contentView.frame.size.height

@implementation BaseBorderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    BaseBorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[BaseBorderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //一定要这里设置style，而不能在上面的判断里面，因为cell重用的时候，只要有不同的地方都应该重新设置，否则拿到cell的style就是上一个的样式而自己却没有进行修改
    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        cell.borderStyle = BaseCellBorderStyleAllRound;
    }else if (indexPath.row == 0) {
        cell.borderStyle = BaseCellBorderStyleTopRound;
    }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        cell.borderStyle = BaseCellBorderStyleBottomRound;
    }else {
        cell.borderStyle = BaseCellBorderStyleNoRound;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //配置默认值
        self.contentBorderColor = [UIColor lightGrayColor];
        self.contentBackgroundColor = [UIColor whiteColor];
        self.contentBorderWidth = 2.0;
        self.contentMargin = 10.0;
        self.contentCornerRadius = CGSizeMake(5, 5);
    }
    return self;
}

- (void)setBorderStyleWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        self.borderStyle = BaseCellBorderStyleAllRound;
    }else if (indexPath.row == 0) {
        self.borderStyle = BaseCellBorderStyleTopRound;
    }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        self.borderStyle = BaseCellBorderStyleBottomRound;
    }else {
        self.borderStyle = BaseCellBorderStyleNoRound;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //在这里设置才能获取到真正显示时候的宽度，而不是原始的
    [self setupBorder];
}

- (void)setupBorder
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = self.contentBorderWidth;
    layer.strokeColor = self.contentBorderColor.CGColor;
    layer.fillColor =  self.contentBackgroundColor.CGColor;
    
    UIView *view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [view.layer insertSublayer:layer atIndex:0];
    view.backgroundColor = [UIColor clearColor];
    //用自定义的view代替cell的backgroundView
    self.backgroundView = view;
    
    CGRect rect = CGRectMake(self.contentMargin, 0, Width - 2*self.contentMargin, Height);
    switch (self.borderStyle) {
        case BaseCellBorderStyleNoRound:
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
            layer.path = path.CGPath;
        }
            break;
        case BaseCellBorderStyleTopRound:
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:self.contentCornerRadius];
            layer.path = path.CGPath;
        }
            break;
        case BaseCellBorderStyleBottomRound:
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:self.contentCornerRadius];
            layer.path = path.CGPath;
        }
            break;
        case BaseCellBorderStyleAllRound:
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.contentCornerRadius];
            layer.path = path.CGPath;
        }
            break;
        default:
            break;
    }
}

@end
