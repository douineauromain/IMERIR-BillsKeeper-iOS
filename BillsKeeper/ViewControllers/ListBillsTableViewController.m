//
//  ListBillsTableViewController.m
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 18/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "ListBillsTableViewController.h"
#import "CategoryTableViewController.h"
#import "Bill.h"
#import "BillsViewCell.h"
#import "NSDate+Helper.h"
#import "UIImage+loadScan.h"
#import "DetailBillViewController.h"

@interface ListBillsTableViewController (){
    RLMResults *allBill;
    NSString *csvText;
}
@end

@implementation ListBillsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
//    //REALM CERATION OBJETS TEST
//    // Create object
//    Bill *billTest = [[Bill alloc] init];
//    billTest.name = @"Facture test";
//    billTest.imageLink = @"test.png";
//    
//    // Get the default Realm
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    // You only need to do this once (per thread)
//    
//    // Add to Realm with transaction
//    [realm beginWriteTransaction];
//    [realm addObject:billTest];
//    [realm commitWriteTransaction];

    csvText = [[NSString alloc] init];
    csvText = @"Bill Name;Category;Date;Amount\n";
    
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    @try {
        allBill = [Bill allObjects];
        
        Bill *aBill = [allBill objectAtIndex:0];
        NSLog(aBill.name);
    }
    @catch (NSException *exception) {
        NSLog(@"La base est vide");
    }
    
    [self.tableView reloadData];
    
    //configuration navigation bar :
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor yellowColor]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return allBill.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BillsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"billCell" forIndexPath:indexPath];
    
    // Configure the cell...
   
    Bill *theBill = [allBill objectAtIndex:indexPath.row];
    cell.name.text = theBill.name;
    cell.category.text = theBill.category;
    NSDate *theBillDate = theBill.dateBill;
    cell.dateBill.text = [NSDate stringForDisplayFromDate:theBillDate];
    cell.amount.text = [NSString stringWithFormat:@"%2.f",theBill.amount];
    
    UIImage *theBillImage = [UIImage imageWithScan:theBill.imageLowLink];
    cell.image.image = theBillImage;
    
    //CSV Generation
    csvText = [csvText stringByAppendingString:[NSString stringWithFormat:@"%@;%@;%@;%@\n", theBill.name, theBill.category, [NSDate stringFromDate:theBill.dateBill], [NSString stringWithFormat:@"%2.f",theBill.amount]]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetailsBill"]) {
        //objectIDOfSelectedCell
        DetailBillViewController *DBVC = [segue destinationViewController];
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        DBVC.indexOfSelectedCellReceived = [NSNumber numberWithInt: selectedIndex];
        DBVC.fromShoot = [NSNumber numberWithBool:NO]
        ;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




@end
