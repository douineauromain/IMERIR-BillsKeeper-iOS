//
//  ShootViewController.m
//  BillsKeeper
//
//  Created by Jordy Kingama on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "ShootViewController.h"
#import "UIImage+loadScan.h"
#import "Bill.h"

@interface ShootViewController ()

@end

@implementation ShootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device has no camera"
                                                             delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [myAlertView show];
    } else {
        [self buttonTakePicture:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonTakePicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

//- (IBAction)buttonSelectPicture:(id)sender {
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    
//    [self presentViewController:picker animated:YES completion:NULL];
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.shootImageView.image = chosenImage;
    
   
    //REALM CERATION OBJETS FACTURE
    // Create object
    Bill *theBill = [[Bill alloc] init];
    theBill.imageLink = [NSString stringWithFormat:@"%d.png", theBill.objectId];
    
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    // You only need to do this once (per thread)
    
    // Add to Realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:theBill];
    [realm commitWriteTransaction];
    

    
    [chosenImage saveScan:theBill.imageLink];
    

    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
