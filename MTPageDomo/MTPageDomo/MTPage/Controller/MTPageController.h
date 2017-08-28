//
//  MTPageController.h
//  Meecha
//
//  Created by Kevin on 16/12/5.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTPageController : UIViewController

@property (nonatomic, assign) NSInteger totalComment;//总条数
@property (nonatomic, assign) NSInteger pageCurrent;//当前页数

//回调
@property (nonatomic ,copy) void (^MTPageBlock)(NSUInteger page);
@property (nonatomic ,copy) void (^MTPageHiddenBlock)(NSString* hidden);

@end
