//
//  movie.h
//  Mark
//
//  Created by hongqing on 16/3/13.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CycleMovie : NSObject
@property(nonatomic,assign) NSNumber *Cycle_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy)NSString *img_url;
@property(nonatomic,assign) NSNumber *likes;
@property(nonatomic,copy) NSString *publish_time;
@property(nonatomic,assign) NSNumber *is_liked;


@end
