//
//  MaintainRecordViewController.m
//  234
//
//  Created by l on 2/3/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MaintainRecordViewController.h"
#import "MaintainRecord.h"

@implementation MaintainRecordViewController

@synthesize segmentedControll;
@synthesize recordsTable;
@synthesize currentItems,allItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentItems=[NSMutableArray array];
        allItems=[NSMutableArray array];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
    self.title=@"保养记录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    [recordsTable.layer setMasksToBounds:YES];
    [recordsTable.layer setCornerRadius:5.0f];
    [recordsTable setSeparatorInset:UIEdgeInsetsZero];
    [recordsTable setBackgroundColor:[UIColor clearColor]];
    
    UIView *tableFootView=[[UIView alloc] init];
    [tableFootView setBackgroundColor:[UIColor clearColor]];
    tableFootView.layer.masksToBounds=YES;
    tableFootView.layer.cornerRadius=5.0f;
    [recordsTable setTableFooterView:tableFootView];
    [recordsTable setTableHeaderView:tableFootView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidLayoutSubviews
{
    if ([recordsTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [recordsTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([recordsTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [recordsTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)switchRecords:(id)sender
{
    [recordsTable reloadData];
}

-(void)sortDate
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors=[NSArray  arrayWithObject:sortDescriptor];
    [currentItems sortUsingDescriptors:sortDescriptors];
    [allItems sortUsingDescriptors:sortDescriptors];
    
}

-(void) clearData
{
    [currentItems removeAllObjects];
    [allItems removeAllObjects];
}

#pragma mark table view methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (segmentedControll.selectedSegmentIndex) {
        case 0:
            return [currentItems count];
            
        case 1:
            return [allItems count];
        default:
            return [currentItems count];
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row;
    MaintainRecord *record;
    NSString *identifier;
    identifier=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==Nil) {
      //  cell=[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    row=[indexPath row];
    
    switch (segmentedControll.selectedSegmentIndex) {
        case 0:
            record=[currentItems objectAtIndex:row];
            break;
            
        case 1:
            record=[allItems objectAtIndex:row];
            break;
        default:
            record=[currentItems objectAtIndex:row];
    }
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel sizeToFit];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f]];
    cell.textLabel.text=[[NSString alloc] initWithFormat:@"%@ \n %d公里\n %@",record.itemname,(int)record.maintainMiles,record.date];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

@end
