//
//  StartCampaignViewController.m
//  instant-crowdfunding
//
//  Created by Ruud Visser on 10/12/15.
//  Copyright © 2015 Ruud Visser. All rights reserved.
//

#import "StartCampaignViewController.h"
#import <Parse/Parse.h>

@interface StartCampaignViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *durationTextField;
@property (weak, nonatomic) IBOutlet UISwitch *privacySwitch;
@end

@implementation StartCampaignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameTextField.delegate = self;
    self.amountTextField.delegate = self;
    self.durationTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if(textField == self.nameTextField) {
        [self.amountTextField becomeFirstResponder];
    } else if(textField == self.amountTextField) {
        [self.durationTextField becomeFirstResponder];
    } else if(textField == self.durationTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)createCampaign:(id)sender {
    
    NSString *name = self.nameTextField.text;
    NSString *amount = self.amountTextField.text;
    NSString *duration = self.durationTextField.text;
    BOOL private = self.privacySwitch.isOn;
    
    NSLog(@"Create campaign: %@, amount: %@, duration: %@, private: %d",name, amount, duration, private);
    
    PFObject *campaignObject = [PFObject objectWithClassName:@"Campaign"];
    campaignObject[@"name"] = name;
    campaignObject[@"amount"] = amount;
    campaignObject[@"duration"] = duration;
    campaignObject[@"private"] = [NSNumber numberWithBool:private];
    [campaignObject saveInBackground];
    
    
    [self.navigationController popViewControllerAnimated:YES];
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
