//
//  CampaignDetailViewController.m
//  instant-crowdfunding
//
//  Created by Ruud Visser on 10/12/15.
//  Copyright © 2015 Ruud Visser. All rights reserved.
//

#import "CampaignDetailViewController.h"

@interface CampaignDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation CampaignDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.campaign) {
        self.nameLabel.text = [self.campaign objectForKey:@"name"];
        self.amountLabel.text = [self.campaign objectForKey:@"amount"];
        self.durationLabel.text = [self.campaign objectForKey:@"duration"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
