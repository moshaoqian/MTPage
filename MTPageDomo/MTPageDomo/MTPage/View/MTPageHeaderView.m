//
//  MTPageHeaderView.m
//  Meecha
//
//  Created by Kevin on 16/12/6.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import "MTPageHeaderView.h"

@implementation MTPageHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headerView = [[UIView alloc]init];
        _headerView.frame =CGRectMake(0,0, self.frame.size.width,self.frame.size.height);
        _headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_headerView];
    }
    return self;
}
@end
