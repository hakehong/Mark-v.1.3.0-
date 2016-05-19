//
//  DetailViewTool.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/20.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "DetailViewTool.h"
#import "CycleMovieList.h"
#import "HttpTool.h"
#import "NSObject+YYModel.h"
@implementation DetailViewTool

+ (void)getDetailStoryWithStoryId:(NSNumber *)storyId Callback:(CallBack)callBack{
     {
      NSDictionary *params =  [NSDictionary dictionaryWithObjectsAndKeys:storyId,@"id",@"HU0QIAGVzI0xIDq6k9RHcA==",@"muid",@"1718",@"uid", nil];
       [HttpTool post:[NSString stringWithFormat:@"http://114.215.104.21/mark_web/singles/detail"] parameters:params withCompletionBlock:^(id returnValue) {
           CycleMovieList *movieList  = [CycleMovieList yy_modelWithDictionary:returnValue];
//           movie.htmlUrl =[NSString stringWithFormat:@"<html><head></head><body>%@</body></html>",movie.contentInfo];
           callBack(movieList.singleData);
       } withFailureBlock:^(NSError *error) {
           nil;
       }];
     }
}

//+ (void)getStoryExtraWithStoryId:(NSNumber *)storyId Callback:(CallBack)callBack{
//   
//    [HttpTool get:[NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/story-extra/%@",storyId] params:nil success:^(id json) {
//        
//        StoryExtra *extra = [StoryExtra mj_objectWithKeyValues:json];
//        callBack(extra);
//        
//    } failure:^(NSError *error) {
//        nil;
//    }];
//
//}
@end
