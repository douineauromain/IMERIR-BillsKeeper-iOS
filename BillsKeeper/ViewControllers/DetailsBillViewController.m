//
//  DetailsBillViewController.m
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "DetailsBillViewController.h"
#import "CategoriesViewController.h"

@interface DetailsBillViewController ()

@end

@implementation DetailsBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonCategoryTouch:(id)sender {
    CategoriesViewController *catVC = [[CategoriesViewController alloc] init];
    [self presentViewController:catVC animated:YES completion:nil];
}
@end
