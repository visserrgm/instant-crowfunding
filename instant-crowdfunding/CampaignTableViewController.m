//
//  CampaignTableViewController.m
//  instant-crowdfunding
//
//  Created by Ruud Visser on 10/12/15.
//  Copyright © 2015 Ruud Visser. All rights reserved.
//

#import "CampaignTableViewController.h"
#import "CampaignDetailViewController.h"
#import <Parse/Parse.h>

@interface CampaignTableViewController ()

@property (nonatomic,retain) NSArray *campaigns;
@property (nonatomic, retain) UIRefreshControl *myRefreshControl;

@end

@implementation CampaignTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.campaigns = [[NSArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.myRefreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.myRefreshControl];
    [self.myRefreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshTable];
}

- (void)refreshTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Campaign"];
    
    // Run the query in background with completion block
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {  // The query failed
            NSLog(@"error in the query!");
        } else {  // The query is successful
            self.campaigns = objects;
            [self.tableView reloadData];
            [self.myRefreshControl endRefreshing];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.campaigns count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"campaignCell" forIndexPath:indexPath];
    
    PFObject *campaign = [self.campaigns objectAtIndex:indexPath.row];
    
    NSString *name = [campaign objectForKey:@"name"];
    NSString *amount = [campaign objectForKey:@"amount"];
    NSString *duration = [campaign objectForKey:@"duration"];
    
    [cell.textLabel setText:name];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"Amount: $%@ / $%@, duration: %@/%@ min",@"0",amount, @"0", duration]];
    
    return cell;
}

- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    [self performSegueWithIdentifier:@"showCampaignDetail" sender:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showCampaignDetail"]) {
        NSIndexPath *ip = (NSIndexPath *)sender;
        CampaignDetailViewController *campDetailVC = (CampaignDetailViewController *)segue.destinationViewController;
        campDetailVC.campaign = [self.campaigns objectAtIndex:ip.row];
    }
}


@end
