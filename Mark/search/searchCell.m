//
//  searchCell.m
//  Mark
//
//  Created by hongqing on 16/4/19.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "searchCell.h"
#import "YYWebImage.h"

@implementation searchCell
//-(id)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.movieImage.contentMode =UIViewContentModeScaleAspectFit;
//        
//    }
//    return self;
//}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    _movieImage.frame = CGRectMake(10, 0, (Kwidth -40)/3, (Kwidth -40)/3);
//    _movieName.frame = CGRectMake(10, (Kwidth -40)/3, (Kwidth -40)/3, 15);
//    
//}
//- (void)setImage: (NSString *)imageStr content : (NSString *)content
//{
//    
//    self.movieImage.yy_imageURL =[NSURL URLWithString:imageStr];
//    self.movieName.text =content;
//}

- (IBAction)addMovie:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"aloneAddIcon"] forState:UIControlStateNormal];
}
@end
