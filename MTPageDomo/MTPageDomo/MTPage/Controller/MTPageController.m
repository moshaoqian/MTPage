//
//  MTPageController.m
//  Meecha
//
//  Created by Kevin on 16/12/5.
//  Copyright © 2016年 Chatcat. All rights reserved.
//
#import "MTPageController.h"
#import "MTPageCollectionCell.h"
#import "MTPageHeaderView.h"
#import "MTPageButton.h"
#import "UIImage+Add.h"
#import "Common.h"
#import "Masonry.h"

static NSInteger itemPerPage = 50;//每页容量
static NSInteger itemPerSection = 10;//每个section容量
static NSInteger sectionPerPage = 5;//每页的section容量
static CGFloat headerScrollViewH = 50;


@interface MTPageController ()<UICollectionViewDelegate,UICollectionViewDataSource>
#pragma 头部
@property (nonatomic, strong)UIView* headerView;
@property (nonatomic, strong)UIButton* firstPageBtn;
@property (nonatomic, strong)UIButton* lastPageBtn;
@property (nonatomic, strong)UILabel* headerTitle;
@property (nonatomic, strong)UIView* headerLine;

#pragma 网格视图
@property (nonatomic, strong)UICollectionView *collectionView;

#pragma 头部滚动视图
@property (nonatomic, strong)UIScrollView* headerScrollview;
@property (nonatomic, strong)UIButton* selectedBtn;
@property (nonatomic, strong)UIColor *normalColor;
@property (nonatomic, strong)UIColor *selectedColor;
@property (nonatomic, strong)UIView* scrollViewLine;
@property (nonatomic, assign)NSInteger buttonCount;//当前屏幕能显示的按钮个数

#pragma 布局
@property (nonatomic, assign)NSInteger sectionCount;//页面的section数
@property (nonatomic, assign)NSInteger headerCount;//头部item数
@property (nonatomic, assign)NSInteger currentHeaderIndex;//当前头部item
@property (nonatomic, assign)NSInteger currentSection;//当前选中的section
@property (nonatomic, assign)NSInteger currentRow;//当前选中的row
@property (nonatomic, assign)NSInteger lastPageSection;//最后一页section
@property (nonatomic, assign)NSInteger lastSectionRow;//最后一页最后section的row
@property (nonatomic, assign)CGFloat headerHeightToTop;//顶部距离

#pragma 数据
@property (nonatomic, strong)NSMutableArray* headerArray;
@property (nonatomic, strong)NSMutableArray* selectHeaderArray;
@property (nonatomic, copy)NSString* headerString;
@end
@implementation MTPageController

-(NSMutableArray *)headerArray {
    
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}
-(NSMutableArray *)selectHeaderArray {
    
    if (!_selectHeaderArray) {
        _selectHeaderArray = [NSMutableArray array];
    }
    return _selectHeaderArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //计算布局条件
    [self sizeToLayout];
    //添加头部视图
    [self setHeaderView];
    //添加滚动视图
    [self setScrollview];
    //添加网格视图
    [self setCollectionView];
}
- (void)sizeToLayout {
    
    //测试数据
//    self.totalComment = 538;
//    self.pageCurrent = 34;
    
    self.sectionCount = sectionPerPage;
    self.headerCount = self.totalComment/itemPerPage + 1;
    self.currentHeaderIndex = (self.pageCurrent - 1)/itemPerPage;//index0开始
    self.currentSection = (self.pageCurrent - 1)%itemPerPage/itemPerSection;
    self.currentRow = (self.pageCurrent - 1)%itemPerPage%itemPerSection;
    self.lastPageSection = (self.totalComment%itemPerPage - 1)/itemPerSection + 1;
    self.lastSectionRow = (self.totalComment%itemPerPage - 1)%itemPerSection + 1;
    //header计算
    for (int i = 0; i< self.headerCount; i++) {
        if (i == (int)self.headerCount - 1) {
            self.headerString = [NSString stringWithFormat:@"%ld-%ld",itemPerPage*i+1,self.totalComment];
        }else {
            self.headerString = [NSString stringWithFormat:@"%ld-%ld",itemPerPage*i+1,itemPerPage*(i+1)];
        }
        [self.headerArray addObject:self.headerString];
        [self.selectHeaderArray addObject:self.headerString];
    }
    //顶部距离
    if (self.totalComment < itemPerPage) {
        self.headerHeightToTop = DEVICE_SIZE.height - 64 - self.lastPageSection* 90 - 20;
        headerScrollViewH = 0;
    }else {
        self.headerHeightToTop = DEVICE_SIZE.height - 64 - headerScrollViewH - sectionPerPage* 90 - 20;
        headerScrollViewH = 50;
    }
}
- (void)setHeaderView {
    
    CGFloat width = (DEVICE_SIZE.width - 30)/3;
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerHeightToTop, DEVICE_SIZE.width, 64)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    self.firstPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.firstPageBtn.titleLabel.font = kFont(16);
    self.firstPageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.firstPageBtn setBackgroundColor:[UIColor whiteColor]];
    [self.firstPageBtn setTitle:Localized(@"第一页") forState:UIControlStateNormal];
    [self.firstPageBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [self.firstPageBtn addTarget:self action:@selector(firstPageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.firstPageBtn];
    [self.firstPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(width);
        make.centerY.mas_equalTo(self.headerView.mas_centerY);
    }];
    self.lastPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastPageBtn.titleLabel.font = kFont(16);
    self.lastPageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.lastPageBtn setBackgroundColor:[UIColor whiteColor]];
    [self.lastPageBtn setTitle:Localized(@"最末页") forState:UIControlStateNormal];
    [self.lastPageBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [self.lastPageBtn addTarget:self action:@selector(lastPageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.lastPageBtn];
    [self.lastPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(width);
        make.centerY.mas_equalTo(self.headerView.mas_centerY);
    }];
    
    self.headerTitle = [[UILabel alloc] init];
    self.headerTitle.text = Localized(@"当前页");
    self.headerTitle.textColor = kTitleColor;
    self.headerTitle.font = kFont(16);
    self.headerTitle.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.headerTitle];
    [self.headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headerView.mas_centerY);
        make.centerX.mas_equalTo(self.headerView.mas_centerX);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(20);
    }];
    
    self.headerLine = [[UIView alloc] init];
    self.headerLine.backgroundColor = kColor(229, 229, 229);
    [self.headerView addSubview:self.headerLine];
    [self.headerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}
- (void)setScrollview {
    
    if (headerScrollViewH == 0) {
        return;
    }
    self.headerScrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + self.headerHeightToTop, DEVICE_SIZE.width, headerScrollViewH)];
    self.headerScrollview.backgroundColor=[UIColor whiteColor];
    self.headerScrollview.contentOffset=CGPointMake(0, 0);
    self.headerScrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.headerScrollview];
    
    self.scrollViewLine = [[UIView alloc] init];
    self.scrollViewLine.backgroundColor = kColor(229, 229, 229);
    [self.view addSubview:self.scrollViewLine];
    [self.scrollViewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(64 + headerScrollViewH - 1 + self.headerHeightToTop);
        make.height.mas_equalTo(1);
    }];

    CGFloat buttonWidth=80;
    CGFloat leadingInset;
    self.buttonCount = DEVICE_SIZE.width/buttonWidth;
    if (self.headerArray.count<=self.buttonCount) {
        self.headerScrollview.scrollEnabled=NO;
        self.headerScrollview.contentSize=CGSizeMake(0, 0);
        leadingInset = (DEVICE_SIZE.width - (self.headerArray.count - 1)*10 - self.headerArray.count* buttonWidth)/2;
    } else {
        self.headerScrollview.scrollEnabled=YES;
        leadingInset = 20;
        self.headerScrollview.contentSize=CGSizeMake(self.headerArray.count*buttonWidth + (self.headerArray.count - 1)*10 + leadingInset* 2, 0);
    }
    for (int i=0; i<self.headerArray.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor=[UIColor whiteColor];
        btn.frame=CGRectMake(i*(buttonWidth + 10) + leadingInset,(headerScrollViewH - 34)/2, buttonWidth, 34);
        MyLog(@"%lf",btn.frame.origin.x);
        btn.titleLabel.font = kFont(14);
        btn.adjustsImageWhenHighlighted = NO;
        btn.tag=i;
        if (i==self.currentHeaderIndex) {
            btn.selected=YES;
            self.selectedBtn=btn;
            if (self.headerScrollview.scrollEnabled == YES) {
                [self.headerScrollview setContentOffset:CGPointMake(btn.frame.size.width*self.currentHeaderIndex, 0) animated:YES];
            }
        } else {
            btn.selected=NO;
        }
        [btn setTitle:self.headerArray[i] forState:UIControlStateNormal];
        [btn setTitle:self.selectHeaderArray[i] forState:UIControlStateSelected];
        if (btn.selected) {
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage resizedImage:@"btn"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage resizedImage:@"btn_p"] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage resizedImage:@"btn"] forState:UIControlStateSelected];
            btn.layer.borderColor = kGlobalColor.CGColor;
        }else {
            
            [btn setTitleColor:kTitleColor forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage resizedImage:@"灰"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage resizedImage:@"白"]forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage resizedImage:@"灰"] forState:UIControlStateHighlighted];
            btn.layer.borderColor = kTitleColor.CGColor;
        }
        btn.layer.borderWidth = 0.5;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 17;
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerScrollview addSubview:btn];
    }
}
-(void)btnTouch:(UIButton *)sender
{
    [self changeSelectedBtn:sender];
    self.currentHeaderIndex = sender.tag;
    [self.collectionView reloadData];
}
-(void)changeSelectedBtn:(UIButton *)willSelectedBtn
{
    _selectedBtn.selected=NO;
    
    [_selectedBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    [_selectedBtn setBackgroundImage:[UIImage resizedImage:@"灰"] forState:UIControlStateSelected];
    [_selectedBtn setBackgroundImage:[UIImage resizedImage:@"白"]forState:UIControlStateNormal];
    [_selectedBtn setBackgroundImage:[UIImage resizedImage:@"灰"] forState:UIControlStateHighlighted];
    _selectedBtn.layer.borderColor = kTitleColor.CGColor;
    
    UIView *selectedView=[_selectedBtn viewWithTag:2];
    selectedView.backgroundColor=[UIColor whiteColor];
    willSelectedBtn.selected=YES;
    _selectedBtn=willSelectedBtn;
    UIView *view1=[willSelectedBtn viewWithTag:2];
    view1.backgroundColor=_selectedColor==nil?[UIColor cyanColor]:_selectedColor;
    
    [willSelectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [willSelectedBtn setBackgroundImage:[UIImage resizedImage:@"btn"] forState:UIControlStateNormal];
    [willSelectedBtn setBackgroundImage:[UIImage resizedImage:@"btn_p"] forState:UIControlStateHighlighted];
    [willSelectedBtn setBackgroundImage:[UIImage resizedImage:@"btn"] forState:UIControlStateSelected];
    willSelectedBtn.layer.borderColor = kGlobalColor.CGColor;
    
    if (willSelectedBtn.tag>1&&willSelectedBtn.tag<self.headerArray.count-2&&self.headerArray.count>self.buttonCount) {
        [self.headerScrollview setContentOffset:CGPointMake(willSelectedBtn.frame.size.width*(willSelectedBtn.tag-1), 0) animated:YES];
    }
}
- (void)setCollectionView {
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemWidth =(DEVICE_SIZE.width- 40)/5;
    CGFloat itemHeight =40;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    [flowLayout setHeaderReferenceSize:CGSizeMake(DEVICE_SIZE.width,10)];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + headerScrollViewH + self.headerHeightToTop, DEVICE_SIZE.width,DEVICE_SIZE.height - 64) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTPageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MTPageCollectionCell"];
    [self.collectionView registerClass:[MTPageHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MTPageHeaderView"];
    [self.view addSubview:self.collectionView];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTPageCollectionCell *cell=(MTPageCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MTPageCollectionCell" forIndexPath:indexPath];
    cell.indexPath=indexPath;
    [cell.page setTitle:[NSString stringWithFormat:@"%ld",(indexPath.row + 1)+(indexPath.section)*10 + self.currentHeaderIndex* itemPerPage] forState:UIControlStateNormal];
    [cell.page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.page.indexPath = indexPath;
    cell.page.collectionView = collectionView;
    if ([cell.page.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%ld",self.pageCurrent]]) {
        cell.page.selected = YES;
    }else {
        cell.page.selected = NO;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTPageCollectionCell *cell = (MTPageCollectionCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    MyLog(@"%@",cell.page.titleLabel.text);
    self.pageCurrent = [cell.page.titleLabel.text integerValue];
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.MTPageHiddenBlock) {
        self.MTPageHiddenBlock(@"");
    }
    if (self.MTPageBlock) {
        self.MTPageBlock(self.pageCurrent);
    }
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        //定制头部视图的内容
        MTPageHeaderView *headerV = (MTPageHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MTPageHeaderView"forIndexPath:indexPath];
        reusableView = headerV;
    }
    return reusableView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.currentHeaderIndex == self.headerCount - 1) {
        return self.lastPageSection;
    }else return sectionPerPage;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.currentHeaderIndex == self.headerCount - 1) {
        if (self.lastPageSection == section + 1) {
            return self.lastSectionRow;
        }else return itemPerSection;
    }else return itemPerSection;
}
-(void)pageAction:(MTPageButton*)button {
    
    MyLog(@"%ld",button.indexPath.section);
    MyLog(@"%ld",button.indexPath.row);
    
    [self collectionView:(UICollectionView *)button.collectionView didSelectItemAtIndexPath:button.indexPath];
}
- (void)firstPageBtnAction {

    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.MTPageHiddenBlock) {
        self.MTPageHiddenBlock(@"");
    }
    if (self.MTPageBlock) {
        self.MTPageBlock(1);
    }
}
- (void)lastPageBtnAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.MTPageHiddenBlock) {
        self.MTPageHiddenBlock(@"");
    }
    if (self.MTPageBlock) {
        self.MTPageBlock(self.totalComment);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.MTPageHiddenBlock) {
        self.MTPageHiddenBlock(@"");
    }
}
@end
