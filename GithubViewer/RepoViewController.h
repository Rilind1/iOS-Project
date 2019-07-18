//
//  ViewController.h
//  InterviewProject
//
//  Created by Rilind Hoxhaj on 7/18/19.
//

#import <UIKit/UIKit.h>

NSString *const BASE_URL = @"https://api.github.com";

@interface RepoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *issuesBarButton;
@property (weak, nonatomic) IBOutlet UILabel *repoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *repoStarLabel;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

