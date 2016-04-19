//
//  testCell.m
//  Mark
//
//  Created by hongqing on 16/4/13.
//  Copyright © 2016年 hongqing. All rights reserved.
//
#import "testCell.h"

@implementation testCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _image.frame = CGRectMake(0, 0, Kwidth,200);
    self.leftView.frame =CGRectMake(Kwidth-40, 0, 30, 50);
}

- (void)commonInit {
    [self addSubview:self.image];
    [self addSubview:self.UnwatchImage];
    [self addSubview:self.is_Liked];
    [self addSubview:self.likeNum];
}

//- (UIImageView *)image {
//    if (_image == nil) {
//        _image =[[UIImageView alloc ]init];
//        
//    }
//    return _image;
//}

@end
