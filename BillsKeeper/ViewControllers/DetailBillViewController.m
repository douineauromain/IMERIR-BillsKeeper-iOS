//
//  DetailBillViewController.m
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "DetailBillViewController.h"
#import "ListBillsTableViewController.h"
#import "CategoryTableViewController.h"
#import <Realm/Realm.h>
#import "Bill.h"
#import "UIImage+loadScan.h"
#import "NSDate+Helper.h"

@interface DetailBillViewController (){
    RLMResults *allBill;
    Bill *aBill;
    NSMutableArray *pickerArray;
}

@end

@implementation DetailBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //configuration navigation bar :
    self.navigationController.navigationBar.translucent = NO;
    //for full screen
    self.wantsFullScreenLayout = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //--
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //picker
    pickerArray = [NSMutableArray arrayWithArray:@[@"New Category",                  @"Restaurant",@"Hosting",@"Transport"]];
    
    //autre
    
    
    NSLog(@"indexOfSelectedCellReceived : %d", [self.indexOfSelectedCellReceived intValue]);
    
    if ([self.fromShoot boolValue] != NO) { //from shoot
        [self.textFeildName becomeFirstResponder];
        
        UITableViewCell *lastCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lastCell"];
        
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:lastCell]
    atScrollPosition:UITableViewScrollPositionBottom
    animated:YES];
    }
    
    //gesture recognizer for TF
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    //Recuperation dans la base
    @try {
        allBill = [Bill allObjects];
        
        aBill = [allBill objectAtIndex:[self.indexOfSelectedCellReceived intValue]];
        NSLog(aBill.name);
        
        //mise a jour de l'interface
        self.imageBillHigh.image = [UIImage imageWithScan:aBill.imageLink];
        self.textFeildName.text = aBill.name;
        self.textFeildAmout.text = [NSString stringWithFormat:@"%2.f",aBill.amount];
        self.textFieldCategory.text = aBill.category;
        self.labelDate.text = [NSDate stringForDisplayFromDate:aBill.dateBill];
        [self.textViewDescription setText:aBill.descriptionBill];
        

    }
    @catch (NSException *exception) {
        NSLog(@"La base est vide");
    }
    
    [self.tableView reloadData];
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    //scroll
    [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    //Bouton category
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"tempCategory"] == nil) {
        NSLog(@"Il n'y a pas de variable temporaire tempCategory");
    } else {
        NSLog(@"Il y a une variable temporaire tempCategory : %@",[[NSUserDefaults standardUserDefaults]stringForKey:@"tempCategory"]);
        
        self.buttonCategory.titleLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"tempCategory"];
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tempCategory"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonSaveTouch:(id)sender {
//    ListBillsTableViewController *LBTVC = [[ListBillsTableViewController alloc] init];
//    [self.navigationController showViewController:LBTVC sender:self];
    
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    aBill.name = self.textFeildName.text;
    
    NSString *amountTextWithVirgule = self.textFeildAmout.text;
    NSString *amountTextWithPoint = [amountTextWithVirgule stringByReplacingOccurrencesOfString:@"," withString:@"."];
    float goodFloat = [[NSString stringWithFormat:@"%.2f", [amountTextWithPoint floatValue]] floatValue];;
    
    NSLog(@"amount float : %f", goodFloat);
    aBill.amount = goodFloat;
    aBill.category = self.textFieldCategory.text;
    aBill.descriptionBill = self.textViewDescription.text;
    [realm commitWriteTransaction];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {     switch (buttonIndex) {
    case 0:
//        self.textFieldCategory.text = pickerArray[0];
        [self performSegueWithIdentifier:@"showCategory" sender:self];
        
        break;
    case 1:
        self.textFieldCategory.text = pickerArray[1];
        break;
    case 2:
        self.textFieldCategory.text = pickerArray[2];
        break;
    case 3:
        self.textFieldCategory.text = pickerArray[3];
        break;
}
   
    
}
- (IBAction)textfieldCategoryEditingDidBegin:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Category type :" delegate:self cancelButtonTitle:@"Other" destructiveButtonTitle:nil otherButtonTitles:pickerArray[0], pickerArray[1],pickerArray[2],pickerArray[3], nil];
    
    [actionSheet showInView:self.view];
}

//resing all TF
- (void)hideKeyBoard{
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self hideKeyBoard];
}
@end
