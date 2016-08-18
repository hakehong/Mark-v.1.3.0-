//
//  searchMovie.h
//  Mark
//
//  Created by hongqing on 16/4/18.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class imageAll;
@interface searchMovie : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy)NSString *alt;
@property (nonatomic, strong) imageAll *images;
@end
