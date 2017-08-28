//
//  ViewController.m
//  MTPageDomo
//
//  Created by MiaoTianyu on 2017/8/28.
//  Copyright © 2017年 com.miaotianyu. All rights reserved.
//

#import "ViewController.h"
#import "MTPageController.h"
#import "Common.h"

@interface ViewController ()

//评论page
@property (nonatomic, assign) NSInteger totalComment;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGlobalColor;
    self.title = @"MTPage";
    
    self.totalComment = 12345;
    self.currentPage = 64;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self pageCommentBtnAction];
}
- (void)pageCommentBtnAction {
    
    MTPageController* page = [[MTPageController alloc] init];
    page.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    page.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    page.providesPresentationContextTransitionStyle = YES;
    page.pageCurrent = self.currentPage;
    page.totalComment = (self.totalComment - 1)/30 + 1;
    
//    __weak ViewController *weakSelf = self;
    page.MTPageBlock = ^(NSUInteger page){
        NSLog(@"点击了第%ld页",page);
        self.currentPage = page;
    };
    page.MTPageHiddenBlock = ^(NSString* hidden){
        NSLog(@"MTPage hidden");
    };
    //显示在最上方
//    [self.navigationController.view bringSubviewToFront:self.motaBackgroungView];
    [self.navigationController presentViewController:page animated:YES completion:nil];
}
@end
