//
//  SecondCell.h
//  Mark
//
//  Created by hongqing on 16/4/13.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleMovie.h"
@class CycleMovieList;

@interface SecondCell : UICollectionViewCell
@property(nonatomic,strong)CycleMovie *movie;
@property(nonatomic,strong)UIImageView *image;
//-(void)setSecondMovieList:(CycleMovieList *)list;
@end
