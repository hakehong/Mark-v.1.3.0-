//
//  testCell.h
//  Mark
//
//  Created by hongqing on 16/4/13.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface testCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UIButton *is_Liked;
@property (weak, nonatomic) IBOutlet UIImageView *UnwatchImage;
//@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
