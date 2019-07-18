//
//  ViewController.m
//  InterviewProject
//
//  Created by Rilind Hoxhaj on 7/18/19.
//

#import "RepoViewController.h"
#import "AFNHelper.h"
#import "IssueListVC.h"

@interface RepoViewController ()

@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *repo;

@property (nonatomic, strong) NSString *repoUrl;

@end

@implementation RepoViewController
{
    UIAlertAction *okAction;
}

#pragma mark - View contrroller life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.owner = @"Alamofire";
    self.repo = @"Alamofire";
    
    [self changeRepoAlert];
    
    [(UIScrollView*)[self.webView.subviews objectAtIndex:0] setShowsVerticalScrollIndicator:NO];
}

- (IBAction)changeRepoButtonClicked:(UIBarButtonItem *)sender {
    [self changeRepoAlert];
}

- (void) changeRepoAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Enter the name of the owner and the repo" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Owner name";
        [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Repo name";
        [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"Default" style:UIAlertActionStyleCancel handler: ^(UIAlertAction * _Nonnull action) {
        [self loadRepoData];
    }]];
    
    okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *ownerTextField = [[alert textFields] objectAtIndex:0];
        UITextField *repoTextField = [[alert textFields] objectAtIndex:1];
        
        NSString *ownerName = ownerTextField.text;
        
        NSString *repoName = repoTextField.text;
        
        if (![ownerName isEqualToString:@""] && ![repoName isEqualToString:@""]) {
            self.owner = ownerName;
            self.repo = repoName;
            
            [self loadRepoData];
        }
    }];
    okAction.enabled = NO;
    [alert addAction: okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueToIssueList"])
    {
        IssueListVC  *vc = [segue destinationViewController];
        vc.owner = self.owner;
        vc.repo = self.repo;
    }
}

#pragma mark - Helper methods
- (void) loadRepoData
{
    self.repoUrl = [NSString stringWithFormat:@"%@/repos/%@/%@", BASE_URL, self.owner, self.repo];

    [self getRepoInfo];
    [self getRepoReadme];
}

- (void) textChanged: (UITextField *)textField
{
    okAction.enabled = ![textField.text isEqualToString:@""];
}

#pragma mark - API calls
- (void) getRepoInfo
{
    [AFNHelper getRequestWithPath: self.repoUrl params:nil completionBlock:^(id response, NSError *error) {
        if (error == nil) {
            if (response) {
                NSLog(@"Response: %@", response);
                
                self.title = [response valueForKey:@"name"];
                self.issuesBarButton.enabled = [[response valueForKey:@"has_issues"] boolValue];
                
                self.repoNameLabel.text = [response valueForKey:@"full_name"];
                self.repoStarLabel.text = [NSString stringWithFormat:@"★ Star: %@", [response valueForKey:@"stargazers_count"]];
                
            }
        }
        else
        {
            NSLog(@"An error occured: %@", error);
        }
        
    }];

}

- (void) getRepoReadme
{
    NSString *readmeUrl = [self.repoUrl stringByAppendingString:@"/readme"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc] initWithString: readmeUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    [request setValue:@"application/vnd.github.VERSION.html" forHTTPHeaderField:@"Accept"];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSString* htmlString = [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView loadHTMLString:htmlString baseURL:nil];
        });
        
    }];
    [task resume];

}

@end
