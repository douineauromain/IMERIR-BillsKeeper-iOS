//
//  ListBillsTableViewController.m
//  BillsKeeper
//
//  Created by  Romain on 18/03/2015.
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
    NSString *csvTextFirstLine;
}
@end

@implementation ListBillsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    csvText = [[NSString alloc] init];
    csvTextFirstLine = @"Bill Name;Category;Date;Amount;Description;imagelink\n";
    csvText = csvTextFirstLine;
    
    //searchbar
    self.textFieldSearch.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated{
    csvText = csvTextFirstLine;
    @try {
        allBill = [Bill allObjects];
        
        Bill *aBill = [allBill objectAtIndex:0];
        NSLog(@"%@", aBill.name);
    }
    @catch (NSException *exception) {
        NSLog(@"La base est vide");
    }
    
    [self.tableView reloadData];
    
    //configuration navigation bar :
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor yellowColor]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //gesture recognizer for TF
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    csvText = [csvText stringByAppendingString:[NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@\n", cell.name.text, cell.category.text, [NSDate stringFromDate:theBill.dateBill], cell.amount.text, theBill.descriptionBill, theBill.imageLink]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Bill *billToDelete = [[Bill alloc] init];
        billToDelete = [allBill objectAtIndex:indexPath.row];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject:billToDelete];
        [realm commitWriteTransaction];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

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
}

- (IBAction)buttonSendCSV:(id)sender {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* filePath = [documentsDirectory stringByAppendingPathComponent:@"Bills.csv"];
    
    [csvText writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSData* CSVattachment = [NSData dataWithContentsOfFile:filePath];
    
    self.sendCSVMail = [[MFMailComposeViewController alloc]init];
    self.sendCSVMail.mailComposeDelegate = self;
    [self.sendCSVMail setSubject:@"Bills CSV"];
    [self.sendCSVMail addAttachmentData:CSVattachment mimeType:documentsDirectory fileName:@"Bills.csv"];
    
    [self.sendCSVMail setMessageBody:@"CSV AUTO" isHTML:NO];
     [self presentModalViewController:self.sendCSVMail animated:YES];
}

- (void)buttonDelete:(id)sender {
        self.textFieldSearch.text = @"";
        allBill = [Bill allObjects];
        [self.tableView reloadData];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissModalViewControllerAnimated:YES];
}

//resing all TF
- (void)hideKeyBoard{
    [self.view endEditing:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"textFieldChanged");
    if ([self.textFieldSearch.text isEqualToString:@""]) {
        NSLog(@"Vide");
        [self buttonDelete:self];
    }else{
        NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"name CONTAINS[c] '%@'", self.textFieldSearch.text]];
        
        allBill = [Bill allObjects];
        allBill = [allBill objectsWithPredicate:pred];
        [self.tableView reloadData];
        csvText = csvTextFirstLine;
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"endEditindSearch");
    [self.textFieldSearch resignFirstResponder];
    [searchBar resignFirstResponder];
    csvText = csvTextFirstLine;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"clickedSearch");
    [self.textFieldSearch resignFirstResponder];
    [searchBar resignFirstResponder];
    csvText = csvTextFirstLine;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"clickResultsList");
    [self.textFieldSearch resignFirstResponder];
    csvText = csvTextFirstLine;
  

}

@end
