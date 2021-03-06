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
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"listCategory"] == nil){
        self.listCategory = [NSMutableArray arrayWithObjects:@"MacDo", nil];
        [[NSUserDefaults standardUserDefaults] setObject:self.listCategory forKey:@"listCategory"];
        
        
    } else {
        self.listCategory = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"listCategory"]];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.listCategory objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
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
        NSString *stringToAdd = [[NSString alloc] init];
        stringToAdd = self.textFieldNewCategory.text;
        [self.listCategory addObject:stringToAdd];
        [self.tableView reloadData];
        self.textFieldNewCategory.text = @"";
        [[NSUserDefaults standardUserDefaults] setObject:self.listCategory forKey:@"listCategory"];
    }
}

- (IBAction)buttonBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
