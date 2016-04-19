//
//  searchMovie.m
//  Mark
//
//  Created by hongqing on 16/4/18.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "searchMovie.h"
#import "image.h"

@implementation searchMovie
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"title":@"title",
             @"alt":@"alt",
              @"image":image.class
             };
}
@end
