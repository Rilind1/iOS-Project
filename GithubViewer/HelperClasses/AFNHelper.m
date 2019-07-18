//
//  AFNHelper.m
//  Tinder
//
//  Created by Elluminati - macbook on 04/04/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import "AFNHelper.h"
#import "AFNetworking.h"
#import <UIKit/UIKit.h>

@implementation AFNHelper

+ (AFHTTPRequestOperationManager *)requestManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
    return manager;
}

+ (void) getRequestWithPath:(NSString *)path params:(NSMutableDictionary *)params completionBlock:(void(^)(id response, NSError *error))completionBlock
{
    AFHTTPRequestOperationManager *manager = [self requestManager];
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", operation.responseString);
        if (completionBlock) {
            if(responseObject==nil) {
                completionBlock(operation.responseData, nil);
            }
            else {
                completionBlock(responseObject, nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
}

+ (void)downloadImageWithURL:(NSString *)url completionBlock:(void(^)(UIImage *image))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString: url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData: imgData];
            completionBlock(image);
        });
    });
}

@end
