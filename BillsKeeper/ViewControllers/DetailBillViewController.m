//
//  DetailBillViewController.m
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "DetailBillViewController.h"

@interface DetailBillViewController ()

@end

@implementation DetailBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.buttonCategory setTitle:@"Others" forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.buttonCategory setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"tempCategory"] forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tempCategory"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
