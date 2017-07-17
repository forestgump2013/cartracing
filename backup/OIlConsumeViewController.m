//
//  OIlConsumeViewController.m
//  234
//
//  Created by l on 3/24/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OIlConsumeViewController.h"
#import "OilConsumeRecord.h"

@implementation OIlConsumeViewController
@synthesize records,recordsTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    [recordsTable setBackgroundColor:[UIColor clearColor]];
    [recordsTable.layer setMasksToBounds:YES];
    [recordsTable.layer setCornerRadius:5.0f];
    [recordsTable setSeparatorInset:UIEdgeInsetsZero];
    
    UIView *tableFootView=[[UIView alloc] init];
    [tableFootView setBackgroundColor:[UIColor clearColor]];
    tableFootView.layer.masksToBounds=YES;
    tableFootView.layer.cornerRadius=5.0f;
    [recordsTable setTableFooterView:tableFootView];
    [recordsTable setTableHeaderView:tableFootView];
    
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setTitle:@"油耗记录"];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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

#pragma mark - table method

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [records count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     static NSString *cellIdentifier=@"cell";
     UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     if (cell==Nil) {
     cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
     }
     NSInteger row=[indexPath row];    */
    NSString *cellIdentifier=@"defaultCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSInteger row=[indexPath row];
    OilConsumeRecord *record=[records objectAtIndex:row];
    [cell.textLabel setText:[record readableInfo]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cell.textLabel sizeToFit];
    [cell setBackgroundColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    return cell;
    
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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
