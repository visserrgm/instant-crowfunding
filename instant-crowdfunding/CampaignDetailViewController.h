//
//  CampaignDetailViewController.h
//  instant-crowdfunding
//
//  Created by Ruud Visser on 10/12/15.
//  Copyright © 2015 Ruud Visser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CampaignDetailViewController : UIViewController

@property (nonatomic,retain) PFObject *campaign;

@end
