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
@property NSUserDefaults* userDefault;
@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listCategory = [[NSMutableArray alloc] init];
    self.userDefault = [NSUserDefaults standardUserDefaults];
    self.listCategory = [NSMutableArray arrayWithObjects:@"Hébergement", @"Restauration", @"Transport", @"Autres", nil];
    
    //[self.userDefault setObject:self.listCategory forKey:@"Categories"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.listCategory objectAtIndex:indexPath.row];
    
    return cell;
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
    
    DetailBillViewController* VC = segue
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //DetailBillViewController* dest = segue.destinationViewController;
    
    /*if ([segue.identifier isEqualToString:@"gameDetail"]) {
        NSUInteger selectedRow = self.tableView.indexPathForSelectedRow.row;
        dest.selectedGame = [[GamesManager sharedGamesManager] gameAtIndex:selectedRow];
    }*/
}

- (IBAction)buttonNewCategory:(id)sender {
    if ([self.textFieldNewCategory.text  isEqual: @""]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Category name unfilled"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }else{
        [self.listCategory addObject:self.textFieldNewCategory.text];
        [self.tableView reloadData];
    }
}

@end
