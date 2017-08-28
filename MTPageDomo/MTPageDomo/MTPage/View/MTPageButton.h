//
//  MTPageButton.h
//  Meecha
//
//  Created by Kevin on 16/12/6.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTPageButton : UIButton
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
