//
//  HttpTool.m
//  Mark
//
//  Created by hongqing on 16/4/11.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "HttpTool.h"
#import "AFHTTPSessionManager.h"
@implementation HttpTool
+(void)get:(NSString *)urlStr withCompletionBlock:(CompletionBlock)successBlock withFailureBlock:(FailureBlock)failureBlock;
{
    
    AFHTTPSessionManager *session= [AFHTTPSessionManager manager];
    
    [session GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
        if(successBlock){
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable operation, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}
+(void)post:(NSString *)urlStr parameters:(NSDictionary *)parameters withCompletionBlock:(CompletionBlock)successBlock withFailureBlock:(FailureBlock)failureBlock;
{
    
    AFHTTPSessionManager *session= [AFHTTPSessionManager manager];
    
    [session POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
        if(successBlock){
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable operation, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}
@end
