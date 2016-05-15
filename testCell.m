//
//  testCell.m
//  Mark
//
//  Created by hongqing on 16/4/13.
//  Copyright © 2016年 hongqing. All rights reserved.
//
#import "testCell.h"

@implementation testCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"testCell" owner:nil options:nil];
        self=[views firstObject];
    }
    return self;
}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    _image.frame = CGRectMake(0, 0, Kwidth,200);
//    self.leftView.frame =CGRectMake(Kwidth-40, 0, 30, 50);
//    self.nameLabel.frame =CGRectMake(20, 150, Kwidth-40, 30);
//}

//- (void)commonInit {
//    [self addSubview:self.image];
//    [self.image addSubview:self.UnwatchImage];
//    [self.image addSubview:self.is_Liked];
//    [self.image addSubview:self.likeNum];
//    [self.image addSubview:self.nameLabel];
//}

//- (UIImageView *)image {
//    if (_image == nil) {
//        _image =[[UIImageView alloc ]init];
//        
//    }
//    return _image;
//}

@end
