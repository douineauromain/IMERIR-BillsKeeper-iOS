//
//  DetailBillViewController.m
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "DetailBillViewController.h"
#import <Realm/Realm.h>
#import "Bill.h"
#import "UIImage+loadScan.h"
#import "NSDate+Helper.h"

@interface DetailBillViewController (){
    RLMResults *allBill;
}

@end

@implementation DetailBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //configuration navigation bar :
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
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
        
        Bill *aBill = [allBill objectAtIndex:[self.indexOfSelectedCellReceived intValue]];
        NSLog(aBill.name);
        
        //mise a jour de l'interface
        self.imageBillHigh.image = [UIImage imageWithScan:aBill.imageLink];
        self.textFeildName.text = aBill.name;
        self.textFeildAmout.text = [NSString stringWithFormat:@"%2.f",aBill.amount];
        self.buttonCategory.titleLabel.text = aBill.category;
        self.labelDate.text = [NSDate stringForDisplayFromDate:aBill.dateBill];
        

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

@end
