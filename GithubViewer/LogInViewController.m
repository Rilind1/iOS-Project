//
//  ViewController.m
//  GithubViewer
//
//  Created by Rilind Hoxhaj on 7/17/19.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)loginButtonClicked:(UIButton *)sender {
    NSString *email = [self.emailTextField text];
    NSString *password = [self.emailTextField text];
    
    NSString *savedEmail = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    NSString *savedPassword = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    
    if ([email isEqualToString:savedEmail] && [password isEqualToString:savedPassword]) {
        
    }
}


@end
