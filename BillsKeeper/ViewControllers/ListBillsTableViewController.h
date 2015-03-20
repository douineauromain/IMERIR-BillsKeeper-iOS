//
//  ListBillsTableViewController.h
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 18/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ListBillsTableViewController : UITableViewController <UITextFieldDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonAddBill;
@property (strong) MFMailComposeViewController* sendCSVMail;
- (IBAction)buttonSendCSV:(id)sender;
- (IBAction)buttonDelete:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *textFieldSearch;
- (void)textFieldChanged:(id)sender;

@end
