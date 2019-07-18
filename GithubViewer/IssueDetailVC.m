//
//  IssueDetailVC.m
//  InterviewProject
//
//  Created by Rilind Hoxhaj on 7/18/19.
//

#import "IssueDetailVC.h"
#import "AFNHelper.h"
#import <MMMarkdown/MMMarkdown.h>

@interface IssueDetailVC ()

@end

@implementation IssueDetailVC

#pragma mark - View contrroller life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Issue Details";
    
    self.issueTitleLabel.text = [self.issue valueForKey:@"title"];
    self.userLabel.text = [NSString stringWithFormat:@"Created by %@", [[self.issue objectForKey:@"user"] valueForKey:@"login"]];
    
    self.commentsLabel.text = [NSString stringWithFormat:@"Comments: %@", [self.issue valueForKey:@"comments"]];
    NSArray *labels = [self.issue objectForKey:@"labels"];
    self.labelsLabel.text = [NSString stringWithFormat:@"Labels: %lu", (unsigned long)labels.count];
    NSString *state = [self.issue valueForKey:@"state"];
    state = [state isEqualToString:@"open"] ? @"Pending": @"Resolved";
    self.stateLabel.text = [NSString stringWithFormat:@"State: %@", state];
    
    NSLog(@"Issue %@", self.issue);
    
    NSString* markedDownString = [self.issue valueForKey:@"body"];
    NSError  *error;
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markedDownString error:&error];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}


@end
