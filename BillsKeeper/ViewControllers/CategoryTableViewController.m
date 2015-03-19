//
//  CategoryTableViewController.m
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "CategoryTableViewController.h"

@interface CategoryTableViewController ()
@property NSMutableArray* listCategory;
@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listCategory = [[NSMutableArray alloc] init];
    self.listCategory = [NSMutableArray arrayWithObjects:@"Hébergement", @"Restauration", @"Transport", @"Autres", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.listCategory objectAtIndex:indexPath.row];
    
    return cell;
}

@end
