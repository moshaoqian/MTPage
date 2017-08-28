
//
//  Common.h
//  liaomao
//
//  Created by Mr.wc on 16/8/1.
//  Copyright © 2016年 wc. All rights reserved.
//
#import "AppDelegate.h"

//定义的全屏尺寸（包含状态栏）
#define DEVICE_BOUNDS [[UIScreen mainScreen] bounds]
#define DEVICE_SIZE [[UIScreen mainScreen] bounds].size
#define DEVICE_OS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//AppDelegate
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define autoLayoutX ((AppDelegate *)[[UIApplication sharedApplication] delegate]).autoLayOutX
#define autoLayoutY ((AppDelegate *)[[UIApplication sharedApplication] delegate]).autoLayOutY


//日志输出宏定义
#ifdef DEBUG
//调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
//发布状态
#define MyLog(...)
#endif

//获得RGB颜色
#define kColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kColorPoint(r, g, b) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]
#define kColorRGBSame(rgb) kColor(rgb, rgb, rgb)

#define kGlobalColor kColor(255, 35, 125)
#define kGlobalHighlightColor kColor(205, 25, 100)
#define kSelectGobalColor kColor(205,25,100)
#define kGlobalColorAlpha kColorAlpha(255, 35, 125, 0.9)

#define kBuleColor kColor(0, 158, 255)
#define kBuleHighlightColor kColor(0, 126, 204)

#define kRedColor kColor(255, 0, 0)

#define kTitleColor UIColorRGB(0x242427)//标题和名字
#define kTextColor UIColorRGB(0x494951)//正文
#define kSecondTitleColor UIColorRGB(0x8F9098)
#define kGrayColor UIColorRGB(0xB8B3B4)

#define kBackGroundColor kColor(247, 247, 247)
#define kButtonColor UIColorRGB(0x2d2d34)

#define kLineColor kColor(229, 229, 229)
#define kSelectorColor kColor(229, 229, 229)

#define kTableGrayColor kColor(247, 247, 247)

#define kMomentCommentColor kColor(184, 178, 180)
#define kMomentZanColor kColor(0, 163, 255)
#define kArticleNameColor kColor(189, 64, 115)
#define kUcloudBaseUrl @""

#define UIColorRGB(rgb) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:1.0f])
#define UIColorRGBA(rgb,a) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:a])

#define checkStringNull(Str) (Str) == [NSNull null] || (Str) == nil ? @”” : [NSString stringWithFormat:@”%@”, (Str)]


//系统默认字体
#define kFont(n) [UIFont systemFontOfSize:n]
#define kFontBold(n) [UIFont boldSystemFontOfSize:n]
#define kHeaderTitleFont kFontBold(18 * autoLayoutY)

//状态栏高度
#define kStatusBarHeight 20
#define kLeadingMargin 15
//navGationHeight
#define kHeaderViewHeight 44
#define kCustonButtonHeight 46*autoLayoutY
#define kCustonButtonWidth 160*autoLayoutX
//性别
typedef enum{
    kSexTypeMale = 0, //男
    kSexTypeFemale = 1, //女
    kSexTypeUnknown = 2 //未知
} SexType;


#define kSectionInstence 44
#define kMargin 10

#define kTableViewBackgroundColor kColor(255, 255, 255)




int iosMajorVersion();

NSString *Localized(NSString *s);
NSString *LocalizedByLanguage(NSString *s, NSString *language);

CGSize ScreenSize();

NSString *EncodeText(NSString *string, int key);

#pragma mark --- 苗天宇添的 ---


typedef void (^CCWebImageBlock)(UIImage *image, NSError *error);








