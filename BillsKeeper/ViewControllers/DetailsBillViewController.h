//
//  DetailsBillViewController.h
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsBillViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;
- (IBAction)buttonCategoryTouch:(id)sender;

@end