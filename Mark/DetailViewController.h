//
//  DetailViewController.h
//  Mark
//
//  Created by hongqing on 16/4/29.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CycleMovie;
@interface DetailViewController : UIViewController
@property (nonatomic, strong) NSNumber *movieId;
@property (nonatomic, strong) CycleMovie *movieDetail;
@end
