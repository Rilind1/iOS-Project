//
//  IssueListVC.m
//  InterviewProject
//
//   Created by Rilind Hoxhaj on 7/18/19.
//

#import "IssueListVC.h"
#import "AFNHelper.h"
#import "IssueDetailVC.h"
#import "Issue.h"

@interface IssueListVC ()

@property (nonatomic, strong) NSMutableArray *issues;
@property (nonatomic, strong) NSDictionary *selectedIssue;

@end

@implementation IssueListVC

#pragma mark - View contrroller life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getIssuesWithStatus:@"open"];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPathForSelectedRow = [self.issuesTableView indexPathForSelectedRow];
    if (indexPathForSelectedRow) {
        [self.issuesTableView deselectRowAtIndexPath:indexPathForSelectedRow animated:YES];
    }
}

#pragma mark - TableView datasource and delegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.issues.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.issuesTableView dequeueReusableCellWithIdentifier:@"issueCell"];
    
    Issue *issue = [self.issues objectAtIndex:indexPath.row];
    cell.textLabel.text = issue.title;
    cell.detailTextLabel.text = issue.createdAt;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIssue = [self.issues objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segueToIssueDetail" sender:self];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)segmentControlValueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self getIssuesWithStatus:@"open"];
    }
    else
    {
        [self getIssuesWithStatus:@"closed"];
    }
}

#pragma mark - API calls
- (void) getIssuesWithStatus: (NSString *)status
{
    NSString *issuesUrl = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/issues", self.owner, self.repo];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:status forKey:@"state"];
    
    [AFNHelper getRequestWithPath: issuesUrl params:params completionBlock:^(id response, NSError *error) {
        if (error == nil) {
            if (response) {
                NSLog(@"Response: %@", response);
                
                NSArray *issuesDict = [NSArray arrayWithArray:response];
                self.issues = [[NSMutableArray alloc] init];
                for (int i=0; i<issuesDict.count; i++) {
                    Issue *issue = [[Issue alloc] initWithDict:issuesDict[i]];
                    [self.issues addObject:issue];
                }
                
                [self.issuesTableView reloadData];                
            }
        }
        else
        {
            NSLog(@"An error occured: %@", error);
        }
        
    }];

}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToIssueDetail"]) {
        IssueDetailVC  *vc = [segue destinationViewController];
        vc.issue = self.selectedIssue;
    }
}

@end
