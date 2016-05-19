
//
//  movie.m
//  Mark
//
//  Created by hongqing on 16/3/13.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "CycleMovie.h"

@implementation CycleMovie
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"Cycle_id":@"id",
             @"name":@"name",
             @"img_url":@"img_url",
             @"likes":@"likes",
             @"contentInfo":@"content",
             @"shares":@"shares",
             @"publish_time":@"publish_time",
             @"is_liked":@"is_liked"
             
             };
}
@end
