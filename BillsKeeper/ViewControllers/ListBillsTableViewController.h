//
//  ListBillsTableViewController.h
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 18/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ListBillsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonAddBill;
@property (strong) MFMailComposeViewController* sendCSVMail;
- (IBAction)buttonSendCSV:(id)sender;
- (IBAction)buttonSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;

@end
