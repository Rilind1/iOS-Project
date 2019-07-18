//
//  Issue.m
//  GithubViewer
//
//  Created by Blerd Foniqi on 7/18/19.
//

#import "Issue.h"

@implementation Issue

- (id) initWithDict: (NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self.title = [dict objectForKey:@"title"];
        self.createdAt = [self configureAgeLabelForIssue: dict];
    }
    return self;
}

- (NSString *) configureAgeLabelForIssue: (NSDictionary *)issue
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    NSDate *date = [formatter dateFromString:[issue valueForKey:@"created_at"]];
    formatter.dateFormat = @"dd-MM-yyyy";
    NSString *dateString = [formatter stringFromDate:date];
    return [NSString stringWithFormat:@"Created on %@", dateString];
}

@end
