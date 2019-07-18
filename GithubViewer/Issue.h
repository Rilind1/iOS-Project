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
@property (strong, nonatomic) NSString *formattedPhone;

- (id) initWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
