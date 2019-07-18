//
//  RegisterViewController.m
//  GithubViewer
//
//  Created by Rilind Hoxhaj on 7/17/19.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)registerButtonClicked:(UIButton *)sender {
    NSString *email = [self.emailTextField text];
    NSString *password = [self.passwordTextField text];
    NSString *confirmPassword = [self.confirmPasswordTextField text];
    
    NSString *message = nil;
    if ([email length] == 0 || [password length] == 0 || [confirmPassword length] == 0) {
        message = @"Plotesoni te dhenat";
    } else if (![self isEmail:email]) {
        message = @"Emaili nuk eshte ne rregull";
    } else if (![password isEqualToString:confirmPassword]) {
        message = @"Konfirmimi i fjalkalimit nuk eshte i sakte";
    }
    
    if (message != nil) {
        [self showAlert:message];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (BOOL)isEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)showAlert:(NSString*)message
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:nil];
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
