//
//  LifeMilesSetViewController.m
//  234
//
//  Created by l on 14-6-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LifeMilesSetViewController.h"
#import "TracingCarViewController.h"
#import "CarManageViewController.h"
#import "MaintainItemSetCell.h"
#import "MaintainItem.h"
#import "Car.h"

@implementation LifeMilesSetViewController

@synthesize maintainItems;
@synthesize tableView;
@synthesize database;
@synthesize oneCar;
@synthesize appDelegate,carManagerViewController;



-(IBAction)cancelAddNewCar:(id)sender
{
    [self.view removeFromSuperview];
}
-(IBAction)finishLifeMilesSet:(id)sender{
    
  //  [appDelegate.carManageViewController.registerNewCarView removeFromSuperview];
  //  [self.view removeFromSuperview];
    [self.carManagerViewController backRegisterNewCarView];
    for(int i=0;i<[maintainItems count];i++)
    {
        NSIndexPath *pathOne=[NSIndexPath indexPathForRow:i inSection:0];
        MaintainItemSetCell *cellOne=(MaintainItemSetCell*)[self.tableView cellForRowAtIndexPath:pathOne];
   //     NSLog(cellOne.latestMaintainMiles.text);
   //     NSLog(cellOne.lifeMiles.text);
        MaintainItem *item=[maintainItems objectAtIndex:i];
        [item setLatestMaintainMiles:[cellOne.latestMaintainMiles.text intValue]];
        [item setLifeMiles:[cellOne.lifeMiles.text intValue]];
    }
    [UIView animateWithDuration:1.0 animations:^{
        UIView *tView=appDelegate.navigationController.view;
        tView.center=CGPointMake(tView.center.x-320, tView.center.y);
    }]; 
    
    //commit new car data
   
    oneCar.car_id=[appDelegate getNewCarId];
    [appDelegate insertNewCar:oneCar];
    [appDelegate.cars addObject:oneCar];
  //  [appDelegate.carManageViewController.carsTable reloadData];
    [appDelegate.maintainItems removeAllObjects];
    NSLog(@"init maintain items count =%d",[appDelegate.maintainItems count]);
    MaintainItem *tItem;
    for(int i=0;i<[maintainItems count];i++)
    {
        tItem=[maintainItems objectAtIndex:i];
        tItem.carId=oneCar.car_id;
        [appDelegate.maintainItems addObject:tItem];
        [appDelegate insertMaintainItem:tItem];
    }
  //  appDelegate.currentCarLicense=oneCar.license;
  //  appDelegate.currentCarBrandName=oneCar.brandName;
  //  appDelegate.currentCarMiles=oneCar.currentMiles;
  //  appDelegate.currentCarId=oneCar.car_id;
    appDelegate.currentCar=oneCar;
  //  [appDelegate saveCurrentCarInfo];
  //  [appDelegate.tracingCarViewController.maintainItemsTable reloadData];
    [appDelegate.tracingCarViewController refreshView];
}

-(IBAction) closeSoftKeyBoard:(id)sender
{
    [sender resignFirstResponder];
}

-(void)viewTapped:(UITapGestureRecognizer *)tapGr
{
  //  [tableView resignFirstResponder];
    for(int i=0;i<[maintainItems count];i++)
    {
        NSIndexPath *pathOne=[NSIndexPath indexPathForRow:i inSection:0];
        MaintainItemSetCell *cellOne=(MaintainItemSetCell*)[self.tableView cellForRowAtIndexPath:pathOne];
        [cellOne.latestMaintainMiles resignFirstResponder];
        [cellOne.lifeMiles resignFirstResponder];
    }}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITapGestureRecognizer *tapGr=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView=NO;
    [self.view addGestureRecognizer:tapGr]; 
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma -mark
#pragma mark Table View Data Source

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.maintainItems count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MaintainItemSetCellIdentifier=@"MaintainItemSetCellIdentifier";
    MaintainItemSetCell *cell=(MaintainItemSetCell *) [tableView dequeueReusableCellWithIdentifier:MaintainItemSetCellIdentifier];
    if(cell==nil)
    {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"MaintainItemSetCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSUInteger row=[indexPath row];
    MaintainItem *item=[maintainItems objectAtIndex:row];
    cell.itemName.text=item.itemName;
    cell.latestMaintainMiles.text=[NSString stringWithFormat:@"%d", oneCar.currentMiles];
    cell.lifeMiles.text=[NSString stringWithFormat:@"%d",item.lifeMiles];
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableViewRowHeight;
}



@end
