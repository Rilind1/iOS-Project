//
//  Issue.h
//  GithubViewer
//
//  Created by Blerd Foniqi on 7/18/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Issue : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *createdAt;
@property (strong, nonatomic) NSString *createdBy;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *labels;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *body;


- (id) initWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
