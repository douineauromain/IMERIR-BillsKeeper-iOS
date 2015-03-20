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

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.listCategory objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[NSUserDefaults standardUserDefaults] setValue:[self.listCategory objectAtIndex:indexPath.row] forKey:@"tempCategory"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonNewCategory:(id)sender {
    if ([self.textFieldNewCategory.text isEqual:@""]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Category name unfilled"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }else{
        //self.listCategory = [NSMutableArray arrayWithObjects:@"Hébergement", @"Restauration", @"Transport", @"Autres", nil];
        [self.listCategory addObject:self.textFieldNewCategory.text];
        [self.tableView reloadData];
        self.textFieldNewCategory.text = @"";
    }
}

@end
