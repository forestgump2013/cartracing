//
//  CarManageViewController.m
//  234
//
//  Created by l on 14-7-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CarManageViewController.h"
#import "TracingCarViewController.h"
#import "LifeMilesSetViewController.h"
#import "CarBrandViewController.h"
//#import "AreaViewController.h"
#import "MaintainItem.h"
#import "MaintainItemSetCell.h"
#import "AppDelegate.h"
#import "CarsTableView.h"
#import "Car.h"
#import "HeightClass.h"

@implementation CarManageViewController
@synthesize cars,keys,lists,myAlertView;
@synthesize appDelegate;

@synthesize oneCarLicense;
@synthesize oneCarMiles;
@synthesize oneCarBrandMark;
@synthesize oneCarOilBoxVolume;
@synthesize oneCarBrandName;
@synthesize deleteCarBtn;
@synthesize oneCarBrandNameLabel;
@synthesize oneCarAreaName;
@synthesize brandDictionary;


@synthesize maintainItemsTable,titleView,carsTable,isEdited;
@synthesize lifeMilesSetViewController;
@synthesize areaViewController;
@synthesize carNavigationController;
@synthesize database,carBrandDataBase;
@synthesize editingCarMaintainItems,editCar,deletedCar,heightArray;




-(IBAction)updateMaintainItems:(id)sender
{
    MaintainItem *item;
    for (int i=0; i<[editingCarMaintainItems count]; i++) {
        item=[editingCarMaintainItems objectAtIndex:i];
        [item updateCurrentMiles:editCar.currentMiles];
    }
    
    [appDelegate updateMaintainItemInfoOfCar:editCar WithBuffer:editingCarMaintainItems];
}




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

-(IBAction)checkBeforeReturn:(id)sender
{
    NSLog(@"checkBeforeReturn is called!");
    [appDelegate.navigationController.view setHidden:NO];
     if ([appDelegate.cars count]==0) {
        //load register new Car view;
    }
    
}

-(void) updateEditStateWithFlag:(BOOL)flag
{
    [oneCarLicense setEnabled:flag];
    for (int i=0; i<[editingCarMaintainItems count]; i++) {
        MaintainItemSetCell *cell=(MaintainItemSetCell*)[maintainItemsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.latestMaintainMiles setEnabled:flag];
        [cell.lifeMiles setEnabled:flag];
        
    }
    
}

-(void) returnMainMenu
{
    NSLog(@"return mainmenu is called");
    if ([appDelegate showMaintainItemInitView] || [appDelegate showCarsTableView]) {
        return;
    }
    [appDelegate.leftNavigationController popViewControllerAnimated:YES];
    [appDelegate.tracingCarViewController refreshView];
}

-(IBAction)loadAddMaintainItemView:(id)sender
{
    appDelegate.addMaintainItemName.tag=1;
//    [appDelegate.tracingCarViewController loadInitMaintainItemViewWithItemIndex:0];
    [appDelegate loadMaintainItemInitView:nil];
}

-(void) loadCarsTableView
{
    appDelegate.carsTableView.plot=1;
    [appDelegate loadCarsTableView];
     [titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner_up.png"]]];
    
}

-(IBAction) takeAwayCarsTable:(id)sender
{
    [appDelegate takeAwayCarsTableView];
    [titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]]];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    titleView=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
    [titleView setFrame:CGRectMake(0, 0, 200, 45)];
    [titleView.textLabel setBackgroundColor:[UIColor clearColor]];
    [titleView.textLabel setTextColor:[UIColor whiteColor]];
    [titleView.textLabel setText:@"ttt"];
    //    [titleView.imageView initWithImage:[UIImage imageNamed:@"ford.png"]];
    UIImageView *accessoryMark=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]];
    [titleView setAccessoryView:accessoryMark];
    
    self.navigationItem.titleView=titleView;
    
    UITapGestureRecognizer *showCarsTableTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCarsTableView)];
    [titleView addGestureRecognizer:showCarsTableTap];
    
    //  self.title=@"车辆编辑";
    UIBarButtonItem *editBtn=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(updateCarInfo)];
    self.navigationItem.rightBarButtonItem=editBtn;
    
     UIBarButtonItem *backBtn=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnMainMenu)];
    self.navigationItem.leftBarButtonItem=backBtn;
  
    editingCarMaintainItems=[NSMutableArray array];
    heightArray=[NSMutableArray array];
    
    
   // HeightClass *heightObject;
    for (int i=0; i<30; i++) {
        HeightClass *heightObject=[[HeightClass alloc] initWithHeight:219];
     //   heightObject.height=140;
        [heightArray addObject:heightObject];
        
    }
    editCar=appDelegate.currentCar;
    [self refreshEditViewWithEditCar:appDelegate.currentCar];
    isEdited=FALSE;
    
  //  [addMaintainItemBtn addTarget:appDelegate.tracingCarViewController action:@selector(loadInitMaintainItemViewWithItemIndex:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1)
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
 //   [self.navigationController.navigationBar setHidden:NO];
    
    [deleteCarBtn.layer setCornerRadius:5.0f];
    maintainItemsTable.layer.masksToBounds=YES;
    maintainItemsTable.layer.cornerRadius=5.0f;
    [maintainItemsTable setBackgroundColor:[UIColor clearColor]];
    
    //init alertView.
    myAlertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
}

-(void) refreshEditViewWithEditCar:(Car *)aCar
{
    if (aCar==nil) {
        //clear view
        [titleView.textLabel setText:@""];
        [titleView.imageView setImage:nil];
        [oneCarLicense setText:@""];
        [maintainItemsTable setHidden:YES];
        return;
    }
    [titleView.textLabel setText:aCar.license];
    NSString *imagePath=[appDelegate getMarkWithBrand:aCar.brandName];
    UIImage *image=[UIImage imageNamed: imagePath];
    [titleView.imageView setImage:image];
    [oneCarLicense setText:aCar.license];
    [appDelegate selectMaintainTableWithCarId:aCar.car_id ToBuffer:editingCarMaintainItems];
    [maintainItemsTable reloadData];
    
}

- (void)viewDidUnload
{
    [self setOneCarAreaName:nil];
    [self setOneCarOilBoxVolume:nil];
    [self setOneCarBrandNameLabel:nil];
  //  [self setRegisterNewCarButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(IBAction)tableEdit:(id)sender
{
    [self.carsTable setEditing:!self.carsTable.editing];
}

#pragma -mark
#pragma mark table view data source method

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
    if (tableView==carsTable) {
        NSLog(@"carsTable count:%d",[appDelegate.cars count]);
        return [appDelegate.cars count];
    } else
        */
    return [editingCarMaintainItems count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *MaintainItemSetCellIdentifier=@"MaintainItemSetCellIdentifier";
        MaintainItemSetCell *cell=(MaintainItemSetCell *) [tableView dequeueReusableCellWithIdentifier:MaintainItemSetCellIdentifier];
        if(cell==nil)
        {
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"MaintainItemSetCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
            [cell initAppDelegate:appDelegate];
        }
        NSUInteger row=[indexPath row];
 //       NSLog(@"maintainItems table row:%d",row);
        [cell initWithParentTable:maintainItemsTable Row:row HeightArray:heightArray];
        MaintainItem *item=[editingCarMaintainItems objectAtIndex:row];
        cell.item=item;
        cell.itemName.text=item.itemName;
//    cell.itemDetail.text=[appDelegate.itemDetails objectAtIndex:item.itemId];
        cell.latestMaintainMiles.text=[NSString stringWithFormat:@"%ld", item.latestMaintainMiles];
        cell.lifeMiles.text=[NSString stringWithFormat:@"%ld",item.lifeMiles];
        cell.latestMaintainDate.text=item.latestMaintainDate;
    if (item.lifeTime>0) {
        cell.lifeTime.text=[NSString stringWithFormat:@"%.1f",(CGFloat)(item.lifeTime)/12];
    } else  cell.lifeTime.text=@"";
    
        return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"string:%@",string);
    if([string rangeOfCharacterFromSet:[characterSet invertedSet]].location!=NSNotFound)
        return NO;
    NSString *newString=[textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString] ];
    if(newString.length==1)
    {
        if(!pointed)
        {
            pointed=true;
            newString=[newString stringByAppendingString:@"·"];            
        } else
        {
            newString=@"";
            pointed=false;
        }
        
    }
    NSLog(@"newString:%@",newString);
    
    [textField setText:[newString substringToIndex:MIN(newString.length , 7)] ];
        return NO;
    
}
/*
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
} */

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)deleteEditedCar:(id)sender
{
    if (editCar==nil) {
        return;
    }
    myAlertView.tag=0;
    NSString *msg=[NSString stringWithFormat:@"是否删除%@?",editCar.license];
    [myAlertView setMessage:msg];
    [myAlertView show];
    
   // UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"警告" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
   // [alert show];
}

-(void)restoreOneCar:(Car *)aCar
{
    myAlertView.tag=1;
    deletedCar=aCar;
    [myAlertView setMessage:[NSString stringWithFormat:@"恢复 %@ 数据?",aCar.license]];
    [myAlertView show];
}

-(void)updateCarInfo
{
    if ([appDelegate showMaintainItemInitView] || [appDelegate showCarsTableView]) {
        return;
    }
    myAlertView.tag=2;
    [myAlertView setMessage:[NSString stringWithFormat:@"更新 %@ 信息?",editCar.license]];
    [myAlertView show];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 //   MaintainItemSetCell *cell=(MaintainItemSetCell *)[maintainItemsTable cellForRowAtIndexPath:indexPath];
    HeightClass *heightObject=[heightArray objectAtIndex:indexPath.row];
 //   return 180;
 //   NSLog(@"row %d height %d",indexPath.row,heightObject.height);
    return heightObject.height;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==1)
    {
        if (alertView.tag==0) {
            [appDelegate deleteOneCar:editCar.car_id];
            [appDelegate.cars removeObject:editCar];
         //   [appDelegate.cars]
            [appDelegate.deletedCars addObject:editCar];
            
            if (appDelegate.currentCar.car_id==editCar.car_id) {
                if ([appDelegate.cars count]>0) {
                    appDelegate.currentCar=[appDelegate.cars objectAtIndex:0];
                    editCar=appDelegate.currentCar;
                } else{
                    // load register new car view.
                    editCar=nil;
                    [appDelegate.tracingCarViewController setRegisternewCarView];
                }
                [self refreshEditViewWithEditCar:editCar];
            }
        } else if(alertView.tag==1){
            [appDelegate restoreOneCar:deletedCar];
            [appDelegate.deletedCars removeObject:deletedCar];
             [appDelegate.cars addObject:deletedCar];
            
        } else if(alertView.tag==2){
            [appDelegate updateCarInfo:editCar];
            MaintainItem *item;
            for (int i=0; i<[editingCarMaintainItems count]; i++) {
                item=[editingCarMaintainItems objectAtIndex:i];
                [item updateCurrentMiles:editCar.currentMiles];
                [item updateLeftTime];
            }
            
            [appDelegate updateMaintainItemInfoOfCar:editCar WithBuffer:editingCarMaintainItems];
        }
   //     NSLog(@"确定 button is clicked!");
        
        
        
    } 
    
}  
/*
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"didDismissWithButtonIndex:%d",buttonIndex);    
    if (buttonIndex==1) {
      //  NSLog(@"didDismissWithButtonIndex");
    }
}
*/

#pragma mark--
#pragma mark-- UIGestureRecognizeDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
        return NO;
    else return YES;
}

@end
