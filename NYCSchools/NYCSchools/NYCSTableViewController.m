//
//  NYCSTableViewController.m
//  NYCSchools
//
//  Created by Yi Yin on 1/29/23.
//

#import "NYCSTableViewController.h"
#import "NYCSDataSource.h"
#import "NYCSDetailViewController.h"

@interface NYCSTableViewController ()

@end

@implementation NYCSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NYCSDataSource singleton];
    // Create the "Sort" button to sort by SAT
    // TODO: support more sorting keys in addition to SAT high to low
    UIBarButtonItem* item=[[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStylePlain target:self action:@selector(onSortClicked)];
    self.navigationItem.leftBarButtonItem=item;
}

-(void)onSortClicked{
    [[NYCSDataSource singleton] sortByKey:NYCSSATTotalScoreKey ascendOrder:NO];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [NYCSDataSource singleton].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NYCSTableViewCell" forIndexPath:indexPath];
    // Configure the cell
    UIView* contentView=cell.contentView;
    contentView.tag=-indexPath.row;
    // TODO: better subclass UITableViewCell to prevent finding subview by tag
    UILabel* nameLabel=[contentView viewWithTag:2];
    UILabel* satLabel=[contentView viewWithTag:3];
    // Get data entry
    NSDictionary* school=[[NYCSDataSource singleton] schoolInfoAtIndex:indexPath.row];
    nameLabel.text=school[NYCSSchoolNameKey];
    int satScore=[school[NYCSSATTotalScoreKey] intValue];
    satLabel.text=(satScore?[NSString stringWithFormat:@"%d",satScore]:@"N/A");
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    NSIndexPath* indexPath=[self.tableView indexPathForSelectedRow];
    NYCSDetailViewController* detailVC=(NYCSDetailViewController*)segue.destinationViewController;
    [detailVC setSchoolIndex:indexPath.row];
}

@end
