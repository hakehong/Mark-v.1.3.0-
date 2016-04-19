//
//  seachMovieList.m
//  Mark
//
//  Created by hongqing on 16/4/18.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "seachMovieList.h"
#import "searchMovie.h"
@implementation seachMovieList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"subjects" : searchMovie.class
             };
}
@end
