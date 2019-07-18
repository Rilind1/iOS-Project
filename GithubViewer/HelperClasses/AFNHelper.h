//
//  AFNHelper.h
//  Tinder
//
//  Created by Elluminati - macbook on 04/04/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define POST_METHOD @"POST"
#define GET_METHOD  @"GET"

typedef void (^RequestCompletionBlock)(id response, NSError *error);

@interface AFNHelper : NSObject
{
    //blocks
    RequestCompletionBlock dataBlock;
}
@property(nonatomic,copy)NSString *strReqMethod;

+ (void) getRequestWithPath:(NSString *)path params:(NSMutableDictionary *)params completionBlock:(void(^)(id response, NSError *error))completionBlock;

+ (void)downloadImageWithURL:(NSString *)url completionBlock:(void(^)(UIImage *image))completionBlock;

@end
