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
//#import <MessageUI/MessageUI.h>

@interface ListBillsTableViewController (){
    RLMResults *allBill;
    NSString *csvText;
    //MFMailComposeViewController* SendMailCSV;
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
    csvText = [csvText stringByAppendingString:[NSString stringWithFormat:@"%@;%@;%@;%@\n", theBill.name, theBill.category, [NSDate stringFromDate:theBill.dateBill], [NSString stringWithFormat:@"%2.f",theBill.amount]]];
    
    return cell;
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)buttonSendCSV:(id)sender {
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* filePath = [documentsDirectory stringByAppendingPathComponent:@"BillsCSV.txt"];
    
    [csvText writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSData* CSVattachment = [NSData dataWithContentsOfFile:filePath];
    
    
    self.sendCSVMail = [[MFMailComposeViewController alloc]init];
    self.sendCSVMail.mailComposeDelegate = self;
    [self.sendCSVMail setSubject:@"Test CSV"];
    [self.sendCSVMail addAttachmentData:CSVattachment mimeType:(@"%@", documentsDirectory) fileName:@"BillsCSV.txt"];
    
    [self.sendCSVMail setMessageBody:@"CSV AUTO" isHTML:NO];
     [self presentModalViewController:self.sendCSVMail animated:YES];
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
@end
