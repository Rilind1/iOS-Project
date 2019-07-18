//
//  IssueListVC.h
//  InterviewProject
//
//   Created by Rilind Hoxhaj on 7/18/19.
//

#import <UIKit/UIKit.h>

@interface IssueListVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *repo;

@property (weak, nonatomic) IBOutlet UITableView *issuesTableView;


@end
