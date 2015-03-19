//
//  DetailBillViewController.h
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailBillViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;
@property (weak, nonatomic) IBOutlet UIImageView *imageBill;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@end
