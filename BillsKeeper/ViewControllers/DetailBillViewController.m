//
//  DetailBillViewController.m
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "DetailBillViewController.h"
#import "ListBillsTableViewController.h"
#import <Realm/Realm.h>
#import "Bill.h"
#import "UIImage+loadScan.h"
#import "NSDate+Helper.h"

@interface DetailBillViewController (){
    RLMResults *allBill;
    Bill *aBill;
}

@end

@implementation DetailBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //configuration navigation bar :
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //autre
    [self.buttonCategory setTitle:@"Others" forState:UIControlStateNormal];
    
    NSLog(@"indexOfSelectedCellReceived : %d", [self.indexOfSelectedCellReceived intValue]);
    
    if ([self.fromShoot boolValue] != NO) { //from shoot
        [self.textFeildName becomeFirstResponder];
        
        UITableViewCell *lastCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lastCell"];
        
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:lastCell]
    atScrollPosition:UITableViewScrollPositionBottom
    animated:YES];
    }
    
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
        self.buttonCategory.titleLabel.text = aBill.category;
        self.labelDate.text = [NSDate stringForDisplayFromDate:aBill.dateBill];
        [self.textViewDescription setText:aBill.descriptionBill];
        

    }
    @catch (NSException *exception) {
        NSLog(@"La base est vide");
    }
    
    [self.tableView reloadData];
    
    
}

- (void) viewDidAppear:(BOOL)animated{
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
    aBill.amount = [self.textFeildAmout.text floatValue];
    aBill.category = self.buttonCategory.titleLabel.text;
    aBill.descriptionBill = self.textViewDescription.text;
    
    [realm commitWriteTransaction];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
