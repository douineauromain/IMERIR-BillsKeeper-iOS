//
//  ShootViewController.h
//  BillsKeeper
//
//  Created by Jordy Kingama on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShootViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *shootImageView;
- (IBAction)buttonTakePicture:(id)sender;
- (IBAction)buttonSelectPicture:(id)sender;

@end
