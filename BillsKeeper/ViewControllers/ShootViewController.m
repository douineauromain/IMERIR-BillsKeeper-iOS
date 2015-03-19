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
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No camera"
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
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    self.shootImageView.image = chosenImage;
    UIImage *lowImage = [[UIImage alloc] init];
    lowImage = [self imageWithImage:chosenImage scaledToSize:CGSizeMake(64, 64)];
    
   
    //REALM CERATION OBJETS FACTURE
    // Create object
    Bill *theBill = [[Bill alloc] init];
    theBill.imageLink = [NSString stringWithFormat:@"%d.png", theBill.objectId];
    theBill.imageLowLink = [NSString stringWithFormat:@"%d-low.png", theBill.objectId];
    
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    // You only need to do this once (per thread)
    
    // Add to Realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:theBill];
    [realm commitWriteTransaction];
    
    NSLog(@"Le bill a été sav");
    
    [chosenImage saveScan:theBill.imageLink];
    [lowImage saveScan:theBill.imageLowLink];
    
    
    NSLog(@"L'image a été sav");
    

    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
