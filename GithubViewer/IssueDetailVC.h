//
//  IssueDetailVC.h
//  InterviewProject
//
//  Created by Rilind Hoxhaj on 7/18/19.
//

#import <UIKit/UIKit.h>
#import "Issue.h"

@interface IssueDetailVC : UIViewController

@property (nonatomic, strong) Issue *issue;

@property (weak, nonatomic) IBOutlet UILabel *issueTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelsLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
