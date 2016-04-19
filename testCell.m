//
//  testCell.m
//  Mark
//
//  Created by hongqing on 16/4/13.
//  Copyright © 2016年 hongqing. All rights reserved.
//
#import "testCell.h"

@implementation testCell
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self =[super initWithFrame:frame];
//    if (self) {
//        UIImageView *img =[UIImageView new];
//        [self.contentView addSubview:img];
//        self.cycleImage =img;
//        //        [self settingFrame];
//    }
//    return self;
//}
- (void)layoutSubviews{
    [super layoutSubviews];
    _image.frame = CGRectMake(0, 0, Kwidth,200);
    
}
@end
