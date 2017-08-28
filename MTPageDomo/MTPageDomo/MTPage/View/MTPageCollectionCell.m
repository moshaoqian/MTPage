//
//  MTPageCollectionCell.m
//  Meecha
//
//  Created by Kevin on 16/12/5.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import "MTPageCollectionCell.h"
#import "UIImage+Add.h"
#import "Common.h"

@implementation MTPageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.pageW.constant = 30;
    self.pageH.constant = 30;
    self.page.layer.masksToBounds = YES;
    self.page.layer.cornerRadius = 15;
    self.page.titleLabel.font = [UIFont systemFontOfSize:12];
    self.page.adjustsImageWhenHighlighted = NO;
    [self.page setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.page setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.page setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.page setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [self.page setBackgroundImage:[UIImage imageWithColor:kGlobalColor size:CGSizeMake(10, 10)] forState:UIControlStateSelected];
    [self.page setBackgroundImage:[UIImage imageWithColor:kGlobalColor size:CGSizeMake(10, 10)] forState:UIControlStateHighlighted];
}
@end
