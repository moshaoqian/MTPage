//
//  MTPageCollectionCell.h
//  Meecha
//
//  Created by Kevin on 16/12/5.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPageButton.h"
@interface MTPageCollectionCell : UICollectionViewCell
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageH;
@property (weak, nonatomic) IBOutlet MTPageButton *page;
@end
