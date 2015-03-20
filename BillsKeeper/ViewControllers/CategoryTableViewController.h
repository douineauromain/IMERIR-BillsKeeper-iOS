//
//  CategoryTableViewController.h
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailBillViewController.h"

@interface CategoryTableViewController : UITableViewController


- (IBAction)buttonNewCategory:(id)sender;
- (IBAction)buttonBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewCategory;

@end
