//
//  searchCell.h
//  Mark
//
//  Created by hongqing on 16/4/19.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
- (IBAction)addMovie:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *movieName;
- (void)setImage: (NSString *)imageStr content : (NSString *)content;

@end
