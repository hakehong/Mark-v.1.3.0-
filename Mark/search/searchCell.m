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

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (IBAction)addMovie:(id)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"alreadyAddIcon"]];
}
-(void)layoutSubviews
{
    _movieImage.frame = CGRectMake(10, 0, Kwidth/3-30, Kwidth/3-30);
    _movieName.frame = CGRectMake(10, Kwidth/3-30, Kwidth/3-30, 15);
    
}
- (void)setImage: (NSString *)imageStr content : (NSString *)content
{
    
    self.movieImage.yy_imageURL =[NSURL URLWithString:imageStr];
    self.movieName.text =content;
}

@end
