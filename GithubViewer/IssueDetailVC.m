//
//  IssueDetailVC.m
//  InterviewProject
//
//  Created by Rilind Hoxhaj on 7/18/19.
//

#import "IssueDetailVC.h"
#import "AFNHelper.h"
#import <MMMarkdown/MMMarkdown.h>
#import "Issue.h"

@interface IssueDetailVC ()

@end

@implementation IssueDetailVC

#pragma mark - View contrroller life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Issue Details";
    
    self.issueTitleLabel.text = self.issue.title;
    self.userLabel.text = self.issue.createdBy;
    
    self.commentsLabel.text = self.issue.comments;
    self.labelsLabel.text = self.issue.labels;
    self.stateLabel.text = self.issue.state;
    
    NSString* markedDownString = [self.issue body];
    NSError  *error;
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markedDownString error:&error];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}


@end
