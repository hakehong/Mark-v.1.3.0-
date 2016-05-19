//
//  movieList.m
//  Mark
//
//  Created by hongqing on 16/3/12.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "CycleMovieList.h"
#import "CycleMovie.h"
@implementation CycleMovieList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : CycleMovie.class
             };
}
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"singleData":@"data",
             
             };
}
@end
