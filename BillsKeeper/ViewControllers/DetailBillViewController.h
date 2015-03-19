//
//  DetailBillViewController.h
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailBillViewController : UITableViewController

@property (strong) NSNumber *indexOfSelectedCellReceived;
@property (strong) NSNumber *fromShoot;

@property (weak, nonatomic) IBOutlet UIImageView *imageBillHigh;
@property (weak, nonatomic) IBOutlet UITextField *textFeildName;

@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;

@property (weak, nonatomic) IBOutlet UITextField *textFeildAmout;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@end
