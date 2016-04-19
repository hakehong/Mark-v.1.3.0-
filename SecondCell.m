//
//  SecondCell.m
//  Mark
//
//  Created by hongqing on 16/4/13.
//  Copyright © 2016年 hongqing. All rights reserved.
//
#define spaceing  10
#import "SecondCell.h"
#import "CycleMovie.h"
#import "CycleMovieList.h"
#import "YYWebImage.h"

@interface SecondCell()
@end
@implementation SecondCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        UIImageView *img =[UIImageView new];
        [self.contentView addSubview:img];
        self.image =img;
    }
    return self;
}
//-(void)setMovie:(CycleMovie *)movie
//{
//    _movie =movie;
//    [self settingData];
//    [self settingFrame];
//}
//-(void)settingData
//{
//    
//    self.image.yy_imageURL =[NSURL URLWithString:_movie.img_url];
//    
//    
//}
-(void)layoutSubviews
{
    [super layoutSubviews ];
  
    self.image.frame = CGRectMake(10, 0, (Kwidth -spaceing*5)/4, 80);
}
@end
