//
//  TracingCarViewController.m
//  234
//
//  Created by l on 14-6-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TracingCarViewController.h"
#import "LifeMilesSetViewController.h"
#import "PersonalCenterViewController.h"
#import "CarManageViewController.h"
#import "CarBrandViewController.h"
#import "MaintainRecordViewController.h"
#import "OilConsumeViewController.h"
#import "SpinnerViewController.h"
#import "MaintainItem.h"
#import "FuelingItem.h"
#import "OilConsumeRecord.h"
#import "RespairItem.h"
#import "MaintainItemCell.h"
#import "MaintainItemRecordCell.h"
#import "RespairSubItemCell.h"
#import "RespairSubItem.h"
#import "MaintainRecord.h"
#import "FuelingItemCell.h"
#import "RespairItemCell.h"
#import "AppDelegate.h"
#import "MaintenanceViewController.h"
#import "FuelingViewController.h"
#import "RepairViewController.h"
#import "CreateNewCarViewController.h"
#import "Car.h"
#import "CarsTableView.h"
#import "Garage.h"
#import "RoundCornorView.h"
#import "MoveLabel.h"
#import "MilesInputView.h"
#import "DefaultTableViewCell.h"
#import "CustomProgressView.h"
#import "NotificationLabel.h"
#import "WZLBadgeImport.h"

@implementation TracingCarViewController
@synthesize appDelegate,locationManager;
@synthesize currentCar,currentGarage;
@synthesize titleView;
@synthesize moveLabel;

@synthesize aCarMiles;
@synthesize aCarLicense;
@synthesize currentCarMiles;
@synthesize currentMilesBoard;
@synthesize tempMiles;
@synthesize maintainItemsTable;
@synthesize listData;
@synthesize database,carBrandDataBase;
@synthesize maintainRecords,respairSubItems;
@synthesize fuelingMiles;
@synthesize fuelingLeftPercent;
@synthesize fuelingleftPercentLabel;
@synthesize fuelingLastOilConsumption;
@synthesize fuelingOilCost,fuelingCost;
@synthesize fuelingOilPrice;
@synthesize fuelingOilVolume,fuelingVolue;
@synthesize respairView,repairViewController;
@synthesize respairItemsNames,respairSubItemsTable,addRespairSbuItemBtn;
@synthesize repairCost,respairScrollView;
@synthesize respairMiles;
@synthesize leftExpend;
@synthesize chooseMitems;
@synthesize segmentControl;
@synthesize mItemName;

@synthesize mItemLatestMiles;
@synthesize itemInitItemName,itemInitLatestMaintainMiles,addMaintainItemName,itemInitMaintainLifeMiles,itemInitLatestMaintainDate,itemInitLatestMaintainDateDiv,accessoryView,customInput;
@synthesize mItemNote;
@synthesize finishMtBtn;
@synthesize functionBtn;

@synthesize maintainView,maintainScrollView,maintainScrollViewContentView,maintenanceViewController;
@synthesize itemInitMaintainView,maintainItemSetScrollView,reComputeOilConsumeAlert,milesAlertView;
@synthesize fuelingViewController,fuelingView,fuelingScrollView,ecardScrollView;
@synthesize milesInputView,eCardView;
@synthesize registerNewCarView,registerNewCarScrollView,createNewCarViewController;

//concerned register new car
@synthesize keys,lists;
@synthesize  oneCarBrandNameButton,oneCarAreaName,oneCarCheckYearUnit,oneCarInsuranceYearUnit,oneCarLicense;
@synthesize oneCarMiles,oneCarBrandMark,oneCarOilBoxVolume;
@synthesize insuranceInterval,insuranceDay,inspectDay,inspectIntertal;
@synthesize areaViewController,carBrandViewController,maintainRecordViewController,oilConsumeViewController;

//concerned ecard view.
@synthesize ecGarageName,ecGarageContact,ecGarageAddr,ecGarageTel,ecGarageBusiness,advertiseBoard,slideDownMark;

-(IBAction)testOperation:(id)sender
{
   // [appDelegate selectRespairItems];
    [self.maintainItemsTable reloadData];
}

-(void) refreshMilesView
{
  //  UIFont *font=[UIFont fontWithName:@"DBLCDTempBlack" size:25.0];
  //  NSLog(@"refeashMilesView milesStr=%ld",appDelegate.currentCar.currentMiles);
    NSNumber *number=[NSNumber numberWithInteger:appDelegate.currentCar.currentMiles];
    
    NSString *milesStr=[numberFormatter stringFromNumber:number];
    
  //  CGSize size=CGSizeMake(320, 320);
  //  CGSize labelSize=[milesStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
  //  [self.currentCarMiles setFrame:CGRectMake(131, 20, labelSize.width, labelSize.height+10)];
    
    self.currentCarMiles.text=milesStr;
  //  garageInfo.text=[NSString stringWithFormat:@"%@ 提向您:",appDelegate.garage.shortname];    
}

-(void) refreshView
{
    
    [self refreshMilesView];
    NSLog(@"refreshView%@  brand:%@",appDelegate.currentCar.license,appDelegate.currentCar.brandName);
    [titleView.textLabel setText:appDelegate.currentCar.license];
    NSString *imagePath=[appDelegate getMarkWithBrand:appDelegate.currentCar.brandName];
    UIImage *image=[UIImage imageNamed: imagePath];
    [titleView.imageView setImage:image];
    [appDelegate saveCurrentCarInfo];
    [appDelegate selectMaintainTableWithCarId:appDelegate.currentCar.car_id ToBuffer:appDelegate.maintainItems];
    [appDelegate selectFuelingItems];
    [appDelegate selectAllFuelingItems];
    [appDelegate selectRespairItems];
    [self.maintainItemsTable reloadData];
    
}

-(void)finishMaintainDateSet
{
    NSLog(@"finishMaintainDateSet is called!");
    switch (customInput.tag) {
        case 0:
            [inspectDay setText:[dateFormatter stringFromDate:customInput.date]];
            [inspectDay resignFirstResponder];
             
            break;
        case 1:
            [insuranceDay setText:[dateFormatter stringFromDate:customInput.date]];
            [insuranceDay resignFirstResponder];
            
            break;    
        case 2:
            [itemInitLatestMaintainMiles resignFirstResponder];
            [itemInitMaintainLifeMiles resignFirstResponder];
            [itemInitLatestMaintainDate resignFirstResponder];
            [itemInitLatestMaintainDateDiv resignFirstResponder];
            [itemInitLatestMaintainDate setText:[dateFormatter stringFromDate:customInput.date]];
            break;
        case 3:
            [appDelegate.currentInputDate resignFirstResponder];
            [appDelegate.currentInputDate setText:[dateFormatter stringFromDate:customInput.date]];
        appDelegate.currentEditItem.latestMaintainDate=appDelegate.currentInputDate.text;
            break;
        case 4:
            [insuranceDay setText:[dateFormatter stringFromDate:customInput.date]];
            [insuranceDay resignFirstResponder];
            break;
        default:
            break;
    }
    
}

-(void)loadInitMaintainItemViewWithItemIndex:(NSInteger )index
{
    /*
    NSLog(@"index=%ld",(long)index);
    [UIView animateWithDuration:1.0 animations:^{
        itemInitMaintainView.center=CGPointMake(itemInitMaintainView.center.x+appDelegate.screenWidth, itemInitMaintainView.center.y);
    }];
    
    if (addMaintainItemName.tag==0) {
        // maintain item init set.
        addMaintainItemName.hidden=YES;
        MaintainItem *item=[appDelegate.maintainItems objectAtIndex:index];
        itemInitItemName.tag=index;
        NSString *str=[NSString stringWithFormat:@"%@\n%@",item.itemName,[appDelegate.itemDetails objectAtIndex:item.itemId-1]];
        
        [itemInitItemName setText:str];
        NSLog(@"%@",str);
     //   [itemInitItemName sizeToFit];
    }else{
        // add maintain item.
        [itemInitItemName setText:@"名称"];
        
    }
    
    
   
    [maintainItemSetScrollView setContentOffset:CGPointMake(0, 0)];
     [maintainItemSetScrollView setContentSize:CGSizeMake(appDelegate.screenWidth-10, 1000)];
    [itemInitLatestMaintainMiles setText:@""];
    [itemInitMaintainLifeMiles setText:@""];
    [itemInitLatestMaintainDate setText:@""];
    [itemInitLatestMaintainDateDiv setText:@""];
    */
    
}


-(IBAction)cancelMaintainItemInitialization:(id)sender
{
    /*
    [UIView animateWithDuration:1.0 animations:^{
        itemInitMaintainView.center=CGPointMake(itemInitMaintainView.center.x-appDelegate.screenWidth, itemInitMaintainView.center.y);
    }];     
    [itemInitLatestMaintainMiles resignFirstResponder];
    [itemInitMaintainLifeMiles resignFirstResponder];
    [itemInitLatestMaintainDate resignFirstResponder];
    [itemInitLatestMaintainDateDiv resignFirstResponder];
    */
}

-(void)loadMaintainView:(MaintainItem *)item
{
   
    item.mTag=1;
  //  [maintainRecords removeAllObjects];
    MaintainRecord *record=[[MaintainRecord alloc] initWithItemId:item.itemId carId:appDelegate.currentCar.car_id carLicense:appDelegate.currentCar.license itemName:item.itemName lifeMiles:item.lifeMiles Date:[dateFormatter stringFromDate:[NSDate date]]];
    record.maintainMiles=item.latestMaintainMiles;
    record.lifeTime=item.lifeTime;
  //  [maintainRecords addObject:record];
    [maintenanceViewController clearMaintainRecords];
    [maintenanceViewController addMaintainRecord:record];
    [appDelegate.navigationController pushViewController:maintenanceViewController animated:YES];
    
   
}

-(IBAction)loadMaintainRecordView:(id)sender
{
    MaintainRecord *record;
    [maintainRecordViewController clearData];
    for (int i=0; i<[maintainRecords count]; i++) {
        record=[maintainRecords objectAtIndex:i];
        [appDelegate selectMaintainRecordsWithItemId:record.item_id toBuffer:maintainRecordViewController.currentItems];
    }
    [appDelegate selectMaintainAllRecordsToBuffer:maintainRecordViewController.allItems];
    [maintainRecordViewController sortDate];
    [appDelegate.navigationController pushViewController:maintainRecordViewController animated:YES];
}

-(IBAction)maintainViewKeyboard:(id)sender
{
    [mItemLatestMiles resignFirstResponder];
    MaintainItemRecordCell *cell;
    NSIndexPath *indexPath;
    for (int i=0; i<[maintainRecords count]; i++) {
        indexPath=[NSIndexPath indexPathForRow:i inSection:0];
    //    cell=(MaintainItemRecordCell*)[maintainRecordsTable cellForRowAtIndexPath:indexPath];
        [cell.cost1 resignFirstResponder];
        [cell.cost2 resignFirstResponder];
        
    }

}

-(IBAction)respairViewCancelKeyboard:(id)sender
{
    [respairMiles resignFirstResponder];
    RespairSubItemCell *cell;
    NSIndexPath *indexPath;
    for (int i=0; i<[respairSubItems count]; i++) {
        indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        cell=(RespairSubItemCell*)[respairSubItemsTable cellForRowAtIndexPath:indexPath];
        [cell.name resignFirstResponder];
        [cell.cost1 resignFirstResponder];
        [cell.cost2 resignFirstResponder];
        
    }
    
    
}

-(void)setMilesNumber
{
    NSInteger currentMiles=appDelegate.currentCar.currentMiles;
    MilesInputView *subView;
    for(int i=6;i>=0;i--)
    {
     //   NSLog(@"current miles :%ld  mod:%ld",currentMiles,(currentMiles%10));
        subView=[milesNumbers objectAtIndex:i];
        [subView setNumber:(currentMiles%10)];
        currentMiles/=10;
    }
}

-(NSInteger) getMilesNumber
{
    NSInteger newMiles=0;
    MilesInputView *subView;    
    for(int i=0;i<6;i++)
    {
        subView=[milesNumbers objectAtIndex:i];
        
        newMiles+=[subView getNumber];
        newMiles*=10;
    }
    subView=[milesNumbers objectAtIndex:6];
    newMiles+=[subView getNumber];    
   // NSLog(@"getmilesnumber miles:%ld",newMiles);
    return newMiles;
}

-(void)updateCurrentMiles
{
    //----load milesInputView----
    [self setMilesNumber];
    [UIView animateWithDuration:0.8 animations:^{
        milesInputView.center=CGPointMake(milesInputView.center.x+appDelegate.screenWidth, milesInputView.center.y);
                               }];
    NSLog(@"milsInputView width:%f height:%f",milesInputView.frame.size.width,milesInputView.frame.size.height);
    
}

-(IBAction)cancelMilesView:(id)sender
{
    [self.maintainItemsTable reloadData];
    [UIView animateWithDuration:0.8 animations:^{
        milesInputView.center=CGPointMake(milesInputView.center.x-appDelegate.screenWidth, milesInputView.center.y);
    }];
}

-(IBAction)returnMilesView:(id)sender
{
   // NSString *text=[tempMiles text];
  //  text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger tMiles=[self getMilesNumber];
  //  appDelegate.currentCarMiles=tMiles;
    
   // currentCarMiles.text=tempMiles.text;
    if(tMiles<appDelegate.currentCar.currentMiles){
        milesAlertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"里程减小，可能导致保养数据有误!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [milesAlertView show];
        [milesAlertView setTag:tMiles];
        return;
    }
    //..
    //   [self.maintainItemsTable reloadData];
    [self updateCurrenCarMiles: tMiles];
    
    [UIView animateWithDuration:0.8 animations:^{
        milesInputView.center=CGPointMake(milesInputView.center.x-appDelegate.screenWidth, milesInputView.center.y);
    }];
}

-(void) updateCurrenCarMiles:(NSInteger) newMiles
{
    appDelegate.currentCar.currentMiles=newMiles;
    [self refreshMilesView];
    //..
    MaintainItem *tItem;
    for(int i=0;i<[appDelegate.maintainItems count]; i++)
    {
        tItem=[appDelegate.maintainItems objectAtIndex:i];
        [tItem updateCurrentMiles:newMiles];
    }
    [self.maintainItemsTable reloadData];
    
    [appDelegate updateCurrentCarInfo];
    [appDelegate updateMaintainItemInfoOfCar:appDelegate.currentCar WithBuffer:appDelegate.maintainItems];

}

-(IBAction)showECardView:(id)sender
{
    if (appDelegate.memberType==0 && [appDelegate.relatedGarages count]==0) {
        [appDelegate setScanOperationFlag:1];
        [appDelegate setupCapture];
        return;
    }
    
    if (appDelegate.memberType>=2) {
        currentGarage=appDelegate.customGarage;
    }
    
    [eCardView setHidden:NO];
 //    [self setCanMoveAway:false];
    //--set ecardView content.
    [ecGarageName setText:currentGarage.name];
    [ecGarageContact setText:currentGarage.contact];
    
    [ecGarageAddr setText:[[NSString alloc] initWithFormat:@"地址:%@",currentGarage.addr]];
    [ecGarageTel setText:[[NSString alloc] initWithFormat:@"电话:%@",currentGarage.tel]];

 //   NSLog(@"服务:%@",currentGarage.business);
    [ecGarageBusiness setText:[[NSString alloc] initWithFormat:@"  服务项目\n   %@",currentGarage.business]];
    [self slideDownAnimation];
    
    CGRect frame=eCardView.frame;
    NSLog(@" @@@ show ecard view width:%f   height:%f ",frame.size.width,frame.size.height);
    
}

-(BOOL) isEcardShow
{
    if (eCardView.hidden) {
        return NO;
    }else return YES;
}

-(void) temporaryCustomGarage
{
    /*
    currentGarage=appDelegate.customGarage;
    [advertiseBoard setTitle:[[NSString alloc] initWithFormat:@"%@ 提醒您",currentGarage.shortname] forState:UIControlStateNormal];
    */
}

-(void) slideDownAnimation
{
    [UIView animateWithDuration:2.0f animations:^{
        slideDownMark.center=CGPointMake(slideDownMark.center.x, slideDownMark.center.y+20);
    }completion:^(BOOL finished){
        slideDownMark.center=CGPointMake(slideDownMark.center.x, slideDownMark.center.y-20);
        if (![eCardView isHidden]) {
         //   slideDownMark.center=CGPointMake(slideDownMark.center.x, slideDownMark.center.y-20);
            [self slideDownAnimation];
        }
    }];
}

-(IBAction)hiddeECardView:(id)sender
{
    [eCardView setHidden:YES];
    [self setCanMoveAway:true];
}

-(IBAction)callContact:(id)sender{
    
    //@"tel://10086"
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",currentGarage.tel]]];
}




-(void)updateMaintainItems
{
    MaintainItem *tItem;
    for(int i=0;i<[appDelegate.maintainItems count]; i++)
    {
        tItem=[appDelegate.maintainItems objectAtIndex:i];
        [tItem updateCurrentMiles:appDelegate.currentCar.currentMiles];
    }
  //  [self.maintainItemsTable reloadData];
   // [appDelegate updateMaintainItemInfo];
    [appDelegate updateMaintainItemInfoOfCar:appDelegate.currentCar WithBuffer:appDelegate.maintainItems];
}

-(IBAction)returnMaintainView:(id)sender
{
    /*
    [UIView animateWithDuration:1.0 animations:^{
        maintainView.center=CGPointMake(maintainView.center.x-appDelegate.screenWidth, maintainView.center.y);
    }]; 
    
    showFunctionView=false;
    
    
    NSString *text=[mItemLatestMiles text];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];    
    
    NSInteger tMiles=[text intValue];
  //  NSInteger row=finishMtBtn.tag;
    MaintainRecord *record;
    for (int i=0; i<[maintainRecords count]; i++) {
        record=[maintainRecords objectAtIndex:i];
        if (tMiles<record.maintainMiles) {
            [self showNotitationWithInfo:[NSString stringWithFormat:@"%@上次保养里程大于当前保养里程",record.itemname]];
            return;
        }
    }
    
    
    
    MaintainItem *item;//=[appDelegate.maintainItems objectAtIndex:row];
    for (int i=0; i<[appDelegate.maintainItems count]; i++) {
        item=[appDelegate.maintainItems objectAtIndex:i];
  //      NSLog(@"miles:%ld  %@ %ld",tMiles,item.itemName,item.mTag);
        if (item.mTag==0) {
            [item updateCurrentMiles:tMiles];
        } else [item maintain:tMiles Date:[dateFormatter stringFromDate:[NSDate date]]];
    }
      
    if(tMiles>currentCar.currentMiles)
    {
         appDelegate.currentCar.currentMiles=tMiles;        
        [appDelegate updateCurrentCarInfo];   
        [self refreshMilesView];
         
    }
    [appDelegate updateMaintainItemInfoOfCar:appDelegate.currentCar WithBuffer:appDelegate.maintainItems];
    [self.maintainItemsTable reloadData];
    
    MaintainItemRecordCell *recordCell;
    for (int i=0; i<[maintainRecords count]; i++) {
        record=[maintainRecords objectAtIndex:i];
        record.maintainMiles=tMiles;
        [appDelegate insertmaintainRecord:record];
        recordCell=(MaintainItemRecordCell*)[maintainRecordsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0 ]];
        [recordCell.cost1 resignFirstResponder];
        [recordCell.cost2 resignFirstResponder];
    }
    
    // remove keyboard.
    [mItemLatestMiles resignFirstResponder];
    
    //post maintainRecords to Cloud.
    [appDelegate postMaintainRecordsOfCar:appDelegate.currentCar Buffer:maintainRecords];
    [self setCanMoveAway:true];
    
    */
    
}

-(IBAction)cancelMaintainView:(id)sender
{
    /*
    [UIView animateWithDuration:1.0 animations:^{
        maintainView.center=CGPointMake(maintainView.center.x-appDelegate.screenWidth, maintainView.center.y);
    }];     
    [mItemLatestMiles resignFirstResponder];
    MaintainItemRecordCell *recordCell;
    for (int i=0; i<[maintainRecords count]; i++) {
        recordCell=(MaintainItemRecordCell*)[maintainRecordsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0 ]];
        [recordCell.cost1 resignFirstResponder];
        [recordCell.cost2 resignFirstResponder];
    }
    
    showFunctionView=false;    
    MaintainItem *item;
    for (int i=0; i<[appDelegate.maintainItems count] ;  i++) {
        item=[appDelegate.maintainItems objectAtIndex:i];
        [item freshTag];
    }
    
    
     [self.maintainItemsTable reloadData];
    [self setCanMoveAway:true];
    */
}


-(IBAction)backgroundClick:(id)sender
{
  //  [tempMiles resignFirstResponder];
    /*
    if (carsTableView.view.tag==1) {
        [carsTableView.view removeFromSuperview];        
        carsTableView.view.tag=0;
        
        //  UIImageView *accessoryMark=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]];
        [titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]]];        
    }    
    
     */
    
    
}

-(void) reLocationRegisterNewCarView
{
    NSLog(@"reLocationRegisterNewCarView is worked!");
    if (registerNewCarView.center.x>0) {
        return;
    }
    [UIView animateWithDuration:1 animations:^{
        registerNewCarView.center=CGPointMake(registerNewCarView.center.x+appDelegate.screenWidth, registerNewCarView.center.y)  ;
     //   [appDelegate.navigationController.view setHidden:YES];
    }];
}

-(IBAction)drawMenuView:(id)sender
{
    NSLog(@"loadMenuView is called");
  
    UIView *navigationView=appDelegate.navigationController.view;
    if(navigationView.center.x<(appDelegate.screenWidth/2+10))
    {
        [self clearSubviews];
      
        [UIView animateWithDuration:0.8 animations:^{
            navigationView.center=CGPointMake(navigationView.center.x+(appDelegate.screenWidth*2/3), navigationView.center.y);
        }]; 
    } else
    {
        [UIView animateWithDuration:0.4 animations:^{
            navigationView.center=CGPointMake(navigationView.center.x-(appDelegate.screenWidth*2/3), navigationView.center.y);
        
        }]; 
                
        if ([appDelegate.cars count]==0) {
            [self loadCreateNewCarView];
        }
        
 //       leftExpend=false;  
    }
    // set view
    [appDelegate.personalCenterViewController updateView];
    
}
-(IBAction)switchFunction:(id)sender
{
  //  NSLog(@"switchFunction is worked index:%ld",segmentControl.selectedSegmentIndex);
   
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
            [functionBtn setTitle:@"批量保养" forState:UIControlStateNormal];
            [maintainItemsTable registerClass:[MaintainItemCell class] forCellWithReuseIdentifier:@"identifier1"];
            break;
        case 1:
            [functionBtn setTitle:@"记录加油" forState:UIControlStateNormal];
             [maintainItemsTable registerClass:[FuelingItemCell class] forCellWithReuseIdentifier:@"identifier2"];
            break;     
        case 2:
            [functionBtn setTitle:@"记录维修" forState:UIControlStateNormal];
             [maintainItemsTable registerClass:[RespairItemCell class] forCellWithReuseIdentifier:@"identifier3"];

            break;  
        default:
            break;
    }
     [self.maintainItemsTable reloadData];
}
/*
-(IBAction)finishBatchMaintain:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        batchMaintainView.center=CGPointMake(batchMaintainView.center.x-320, batchMaintainView.center.y);    }];
    MaintainItem *oneItem;
    NSString *text=[mItemLatestMiles text];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger newMile=[text intValue];
    for(int i=0;i<appDelegate.maintainItems.count;i++)
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        MaintainItemCell *cell=(MaintainItemCell *)[self.maintainItemsTable 
                                                    cellForRowAtIndexPath:indexPath];
        oneItem=[appDelegate.maintainItems objectAtIndex:i];
        NSLog(@"lifemiles=%ld",oneItem.lifeMiles);
        if(cell.checkbox.tag==1)
            [oneItem maintain:newMile];
        else [oneItem updateCurrentMiles:newMile];
    }
    if(newMile>[currentCarMiles.text intValue])
        currentCarMiles.text=mItemLatestMiles.text;
    [mItemLatestMiles resignFirstResponder];
    [mItemCost resignFirstResponder];
    [mItemNote resignFirstResponder];
    NSThread *thread=[[NSThread alloc] initWithTarget:appDelegate selector:@selector(updateMaintainItemInfo) object:nil];
    [thread start];
    [self.maintainItemsTable reloadData];
} */

-(IBAction)finishFueling:(id)sender
{
    CGFloat leftPercent=[fuelingLeftPercent value];
    
    // input check.
    if (leftPercent==1) {
        [self showNotitationWithInfo:@"油箱剩余未调整！"];
        return;
    }
    if (![appDelegate checkFuelingMiles:[[fuelingMiles text] intValue] ]) {
        [self showNotitationWithInfo:@"燃油里程已记录！"];
        return;
    }
    if ((fuelingVolue*fuelingCost)==0 ) {
        [self showNotitationWithInfo:@"加油量未计入！"];
        return;
    }
    /*
    if ([fuelingOilPrice.text isEqualToString:@""]) {
        [self showNotitationWithInfo:@"油价为空！"];
        return;
    } */
    
    
    [UIView animateWithDuration:1.0 animations:^{
        fuelingView.center=CGPointMake(fuelingView.center.x-appDelegate.screenWidth, fuelingView.center.y);
    }];
    [self insertFuelingRecord];
     [self setCanMoveAway:true];
}

-(NSInteger) getMonth:(NSString *)date
{
    NSString *sub=[date substringFromIndex:4];
    sub=[sub substringToIndex:2];
    return [sub intValue];
}

-(IBAction)cancelFuelingView:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        fuelingView.center=CGPointMake(fuelingView.center.x-appDelegate.screenWidth, fuelingView.center.y);
    }];
    [self setCanMoveAway:true];
}

-(IBAction)computeLastFuelingWear:(id)sender
{
    /*
    NSInteger miles =[fuelingMiles.text intValue];
    CGFloat leftPercent=[fuelingLeftPercent value];
    FuelingItem *tItem;
    for(int i=0;i<appDelegate.fuelingItems.count;i++)
    {
        tItem=[appDelegate.fuelingItems objectAtIndex:i];
        if(miles>tItem.miles) break;
    }
    Car *currentCar=appDelegate.currentCar;
    CGFloat lastOilVol=currentCar.oilBoxVolume*tItem.leftVol/100+tItem.volume-currentCar.oilBoxVolume*leftPercent/100;    
    CGFloat lastOilAver=lastOilVol/(miles-tItem.miles);
    fuelingLastOilConsumption.titleLabel.text=[[NSString alloc] initWithFormat:@"%.2f 元/公里",lastOilAver];
    */
}

-(IBAction)prepareRecomputeOilConsume:(id)sender
{
    if ([appDelegate.currentCar isAlreadyNewRecord]) {
        [self showNotitationWithInfo:@"已是新油耗记录！"];
        return;
    }
    NSString *msg=[[NSString alloc] initWithFormat:@"油耗将从%@重新计算！",[dateFormatter stringFromDate:[NSDate date]] ];
    reComputeOilConsumeAlert=[[UIAlertView alloc] initWithTitle:@"警告" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    
    [reComputeOilConsumeAlert show];
}

-(void) reComputeOilConsume
{
    [appDelegate.currentCar reComputeOilConsumeWithStartDate:[dateFormatter stringFromDate:[NSDate date]]];
    [appDelegate.currentCar updateFuelingInfo];
    [appDelegate updateCurrentCarInfo];
}

-(IBAction)oilLeftSliderChange:(id)sender
{
    [fuelingleftPercentLabel setText:[[NSString alloc] initWithFormat:@"%.0f%%",fuelingLeftPercent.value*100]];
}

-(void) insertFuelingRecord
{
    
    [fuelingMiles resignFirstResponder];
    [fuelingOilVolume resignFirstResponder];
    [fuelingOilCost resignFirstResponder];
    [fuelingOilPrice resignFirstResponder];
    
    NSString *text=[fuelingMiles text];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger miles =[text intValue];
    CGFloat leftPercent=[fuelingLeftPercent value];
    
    // input check.
    /*
    if (leftPercent==1) {
        [self showNotitationWithInfo:@"油箱剩余未调整！"];
        return;
    } */
    
    
    
    NSDate *sendDate=[NSDate date];
    NSString *date=[dateFormatter stringFromDate:sendDate];
  //  NSLog(@"fueling date:%@",date);
    FuelingItem *item=[[FuelingItem alloc] initWithCurrentMiles:miles LeftVol:leftPercent*currentCar.oilBoxVolume Volume:fuelingVolue Cost:fuelingCost Date:date];
    item.carId=appDelegate.currentCar.car_id;
    FuelingItem *tItem;
    int i,totalMiles;
    
    
    CGFloat wearedOil;
    //---insert fueling record
    
    for(i=0;i<appDelegate.fuelingItems.count;i++)
    {
        tItem=[appDelegate.fuelingItems objectAtIndex:i];
        if(miles>tItem.miles)
        {
          //  NSLog(@"i=%ld",i);
       
                item.addMiles=item.miles-tItem.miles;
                wearedOil=tItem.leftVol+tItem.volume-item.leftVol;
           //     tItem.avOil=wearedOil/item.addMiles;
           //     tItem.avCost=tItem.cost/item.addMiles;
                item.avOil=wearedOil/item.addMiles;   //save the last av_value to the current record.
                item.avCost=tItem.cost/item.addMiles;
                //update fueling record
            //    [appDelegate updateFuelingRecord:tItem];
            if(i>0)
            {
                tItem=[appDelegate.fuelingItems objectAtIndex:(i-1)];
                tItem.addMiles=tItem.miles-item.miles;
                wearedOil=item.leftVol+item.volume-tItem.leftVol;
           //     item.avOil=wearedOil/tItem.addMiles;
           //     item.avCost=item.cost/tItem.addMiles;
                tItem.avOil=wearedOil/tItem.addMiles;
                tItem.avCost=item.cost/tItem.addMiles;
                [appDelegate updateFuelingRecord:tItem];                
            }
                      
            break;
        }
    } 
    [appDelegate.fuelingItems insertObject:item atIndex:i];     
    [appDelegate insertFuelingRecord:item];
    [appDelegate postFuelingRecordOfCar:appDelegate.currentCar Record:item];
    //---compute recent three months oil consumption
    /*
    NSInteger cMonth=[self getMonth:date];
    NSInteger tMonth,mVal,rtOilVolume=0,rtMiles;
    for(i=1;i<appDelegate.fuelingItems.count;i++)
    {
        tItem=[appDelegate.fuelingItems objectAtIndex:i];
        tMonth=[self getMonth:tItem.date];
        NSLog(@"month:%ld",tMonth);
        mVal=((cMonth-tMonth)+12)%12;
        if(mVal<=2)
        {
            rtMiles=tItem.miles;
            rtOilVolume+=tItem.volume;
        } else break;
        
    }    */
    //compute total oil consume 
    OilConsumeRecord *oilConsumeRecord;
    appDelegate.currentCar.totalOilConsumption+=item.volume; 
    appDelegate.currentCar.totalOilCost+=item.cost;
    oilConsumeRecord=[appDelegate.currentCar.oilConsumeRecords objectAtIndex:0];
    if ([appDelegate.fuelingItems count]==1) {
        appDelegate.currentCar.initMiles=miles;
     //   [appDelegate.currentCar.fuelingInfo setString: @"首次记录"];
    //    oilConsumeRecord=[[OilConsumeRecord alloc] initWithStartDate:date EndDate:date OilPm:0 CostPm:0];
    //    [appDelegate.currentCar.oilConsumeRecords addObject:oilConsumeRecord];
        oilConsumeRecord.startDate=date;
        
    }else{
        totalMiles=(int)(miles-appDelegate.currentCar.initMiles);
     //   appDelegate.currentCar.fuelingInfo=[[NSString alloc] initWithFormat:@"油耗:%.2f升/公里 %.2f元/公里",appDelegate.currentCar.totalOilConsumption/totalMiles, appDelegate.currentCar.totalOilCost/totalMiles ];
        
        [oilConsumeRecord updateConsumeRecordWithOilPm:appDelegate.currentCar.totalOilConsumption/totalMiles CostPm:appDelegate.currentCar.totalOilCost/totalMiles EndDate:date];
   //     [appDelegate.currentCar.fuelingInfo setString:[[NSString alloc] initWithFormat:@"%.2f 升/公里  %.2f 元/公里 \n %@~%@",oilConsumeRecord.oilPm,oilConsumeRecord.costPm,oilConsumeRecord.startDate,oilConsumeRecord.endDate] ];
        NSLog(@"the latest fueling info:%@",appDelegate.currentCar.fuelingInfo);
    }
    [appDelegate.currentCar updateFuelingInfo];
    /*
    if(miles>appDelegate.currentCar.currentMiles) appDelegate.currentCar.currentMiles=miles;
    if(i>=appDelegate.fuelingItems.count) 
        [appDelegate.fuelingItems insertObject:item atIndex:appDelegate.fuelingItems.count];
    Car *currentCar=appDelegate.currentCar;
    CGFloat totalAver=currentCar.totalOilConsumption/(currentCar.currentMiles-currentCar.initMiles);
    currentCar.fuelingInfo=[[NSString alloc] initWithFormat:@"总油耗: %.2f 元/公里 \n最近三个月油耗:%.2f 元/公里",totalAver,rtOilAver ];
    */
    if(miles>appDelegate.currentCar.currentMiles)
    {
        appDelegate.currentCar.currentMiles=miles;
        [appDelegate updateCurrentCarInfo];         
        [self refreshMilesView];
        [self updateMaintainItems];
      
    }
    [appDelegate updateCurrentCarInfo];      
     [self.maintainItemsTable reloadData];
}

-(IBAction)cancelRespairView:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        respairView.center=CGPointMake(respairView.center.x-appDelegate.screenWidth, respairView.center.y);
    }];  
    showFunctionView=false;
     [self setCanMoveAway:true];
}

-(IBAction)finishRespairRecord:(id)sender
{
    [respairMiles resignFirstResponder];
 //   [respairItemsNames resignFirstResponder];
 //   [repairCost resignFirstResponder];
    NSString *text=respairMiles.text;
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger miles=[text intValue];
  //  NSString *names=respairItemsNames.text;

    CGFloat tcost=[repairCost.text floatValue ];
    NSDate *sendDate=[NSDate date];
 //   [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *date=[dateFormatter stringFromDate:sendDate];
    RespairItem *item=[[RespairItem alloc] initWithNames:@"" Miles:miles Cost:tcost Date:date];    
    NSMutableString *repairItem=[[NSMutableString alloc] init];
    RespairSubItem *subItem;
    RespairSubItemCell *subItemCell;
    for (int i=0; i<[respairSubItems count]; i++) {
        subItem=[respairSubItems objectAtIndex:i];
        subItemCell=(RespairSubItemCell*)[respairSubItemsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [subItemCell returnKeyBoard];
        if ([subItem.name isEqualToString:@""]) {
            //空项目
            break;
        }
        [item.subItems addObject:subItem];
        [repairItem appendFormat:@"{\"itemname\":\"%@\",\"cost1\":\"%f\",\"cost2\":\"%f\"}",subItem.name,subItem.cost1,subItem.cost2];
        
    }
    
    [repairItem appendString:@"]"];
    [repairItem insertString:@"[" atIndex:0];
   
    item.names=[repairItem stringByReplacingOccurrencesOfString:@"}{" withString:@"},{"];
 //    NSLog(@"respairSubItems:%@",item.names);
    item.carId=appDelegate.currentCar.car_id;
    
    if ([item.subItems count]==0) {
        [appDelegate showNotification:@"项目名称空缺!"];
        return;
    }
    [UIView animateWithDuration:1.0 animations:^{
        respairView.center=CGPointMake(respairView.center.x-appDelegate.screenWidth, respairView.center.y);
    }];
    
   // item.subItems=respairSubItems;
    [appDelegate.respairItems insertObject:item atIndex:0];
    [appDelegate insertRespairRecord:item];
    [appDelegate postRepairRecordOfCar:appDelegate.currentCar Record:item];
    showFunctionView=false;
    [self.maintainItemsTable reloadData];
    if(miles>appDelegate.currentCar.currentMiles)
    {
        appDelegate.currentCar.currentMiles=miles;
        [appDelegate updateCurrentCarInfo];           
        [self refreshMilesView];
        [self updateMaintainItems];
    }    
      [self setCanMoveAway:true];
}

-(void)showOilConsumeView
{
    NSLog(@"showOilConsumeView is worked.");
    oilConsumeViewController.records=appDelegate.currentCar.oilConsumeRecords;
    [appDelegate.navigationController pushViewController:oilConsumeViewController animated:YES];
}

-(IBAction)addRespairSubItem:(id)sender{
    RespairSubItem *subItem=[[RespairSubItem alloc] init];
    [respairSubItems insertObject:subItem atIndex:0];
    
    
  //  CGRect tableFrame=respairSubItemsTable.frame;
    if ([respairSubItems count]<4) {
        [respairView setFrame:CGRectMake(respairView.frame.origin.x, respairView.frame.origin.y, respairView.frame.size.width, 250+34*[respairSubItems count])];
    
    }
    
    [respairSubItemsTable reloadData];
}

-(IBAction)functionOperation:(id)sender
{
    /*
    if ([self isEcardShow]) {
        return;
    } */
    [self clearSubviews];
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
        {
       //     NSInteger dis=0;
            
            if(!chooseMitems)
            {
                chooseMitems=true;
                [maintainItemsTable reloadData];                
            } else
            {
                chooseMitems=false;
                       
             //   NSString *mItemNames=@"保养项目 ";
             //   [ maintainRecords removeAllObjects];
                [maintenanceViewController clearMaintainRecords];
                for(int i=0;i<appDelegate.maintainItems.count;i++)
                {
                    MaintainItem *item=[appDelegate.maintainItems objectAtIndex:i];                       
                    if(item.mTag>0){
                        MaintainRecord *record=[[MaintainRecord alloc] initWithItemId:item.itemId carId:appDelegate.currentCar.car_id carLicense:appDelegate.currentCar.license itemName:item.itemName lifeMiles:item.lifeMiles Date:[dateFormatter stringFromDate:[NSDate date]]];
                        record.maintainMiles=item.latestMaintainMiles;
                        record.lifeTime=item.lifeTime;
                        [maintenanceViewController addMaintainRecord:record];
                   //     [maintainRecords addObject:record];
                    }
                }
                [maintainItemsTable reloadData];
                if ([maintenanceViewController isNullRecords]) {
                    break;
                }
             //   [appDelegate.navigationController pushViewController:maintenanceViewController animated:YES];
               [appDelegate loadFunctionViewController:maintenanceViewController];
               
            }
                
            break;
        }
        case 1:
        {
            
            [appDelegate loadFunctionViewController:fuelingViewController];
            
           // [appDelegate.navigationController pushViewController:fuelingViewController animated:YES];
          //  [appDelegate loadFunctionViewController:fuelingViewController];
            break;
        }
        case 2:
        {
           /*   if (showFunctionView) {
                break;
            } */
          //  showFunctionView=true;
            /*
            [respairSubItems removeAllObjects];
            RespairSubItem *subItem=[[RespairSubItem alloc] init];
            [respairSubItems insertObject:subItem atIndex:0];
            [respairView setFrame:CGRectMake(respairView.frame.origin.x, respairView.frame.origin.y, respairView.frame.size.width, 284)];
            
            NSNumber *number=[NSNumber numberWithInt:(int)appDelegate.currentCar.currentMiles];
            [respairMiles setText:[numberFormatter stringFromNumber:number]];  
            [repairCost setText:@"0"];
            [UIView animateWithDuration:1.0 animations:^{
                respairView.center=CGPointMake(respairView.center.x+appDelegate.screenWidth, respairView.center.y);
            }];
            [respairSubItemsTable reloadData];
            */
         //   [appDelegate.navigationController pushViewController:repairViewController animated:YES];
            [appDelegate loadFunctionViewController:repairViewController];
            break;
        }
        default:
            break;
    }
    [self setCanMoveAway:false];
}

-(void) finishFunctionOprationWithMiles:(NSInteger)newMiles
{
    if(newMiles>appDelegate.currentCar.currentMiles)
    {
        appDelegate.currentCar.currentMiles=newMiles;
        [appDelegate updateCurrentCarInfo];
        [self refreshMilesView];
        
    }
     [self.maintainItemsTable reloadData];
    
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

-(void) segmentControllSet
{
  //  UIImage *image=[UIImage imageNamed:@"green.png" ] ;
  //  UIImage *whiteImage=[UIImage imageNamed:@"white.png"];
  //  UIImage *divider=[UIImage imageNamed:@"divider.png"];
    NSMutableDictionary *txtAttr1=[NSMutableDictionary dictionary];
    [txtAttr1 setObject:[UIColor colorWithRed:0 green:185/255.0 blue:187/255.0 alpha:1] forKey:NSForegroundColorAttributeName];
    NSMutableDictionary *txtAttr2=[NSMutableDictionary dictionary];
    [txtAttr2 setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
  //  NSLog(@"image size width %f",image.size.width);
  //  CGRect sFrame=CGRectMake(40, 86, 240, 34);
  //  [segmentControl setFrame:sFrame];
  //  [segmentControl setBackgroundImage:image forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segmentControl setTintColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f]];
    [segmentControl setBackgroundColor:[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f]];
 //   [segmentControl setDividerImage:divider forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segmentControl setTitleTextAttributes:txtAttr2 forState:UIControlStateNormal ];
    [segmentControl setTitleTextAttributes:txtAttr2 forState:UIControlStateSelected];
 //   segmentControl.layer.cornerRadius=5.0f;
 //   segmentControl.layer.borderWidth=1;
 //   [segmentControl.layer setBorderColor:[UIColor colorWithRed:0 green:185/255.0 blue:187/255.0 alpha:1].CGColor];
 //   [segmentControl.layer setBackgroundColor:[UIColor grayColor].CGColor];
    [segmentControl setSelectedSegmentIndex:0];
}

-(void) testTimer
{
    NSLog(@"tracing car test Timer");
}
-(void) changeGarageIndex
{
    NSLog(@"***changeGarageIndex  garage count: %d ",(int)[appDelegate.relatedGarages count ]);
    if ([appDelegate.relatedGarages count]==0) {
        [advertiseBoard setTitle:@"汽车云管理提醒您" forState:UIControlStateNormal];
        return;
    }
    
    currentGarageIndex++;
    currentGarage=[appDelegate.relatedGarages objectAtIndex:currentGarageIndex%[appDelegate.relatedGarages count]];
    NSLog(@"***changeGarageIndex %@ ",currentGarage.name);
    NSMutableAttributedString *content=[[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"%@ 提醒您",currentGarage.shortname] ];
    NSRange contentRange={0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    [advertiseBoard setAttributedTitle:content forState:UIControlStateNormal];
  //  [advertiseBoard.titleLabel setText:[[NSString alloc] initWithFormat:@"%@ 提醒您",currentGarage.shortname]];
    [advertiseBoard.titleLabel sizeToFit];
}

-(void) startMoveLabel:(NSString *)txt
{
    [moveLabel setText:txt];
    [moveLabel start];
 //   NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(testTimer) userInfo:nil repeats:YES];
}

-(void) showNotitationWithInfo:(NSString *)info
{
    /*
    [infoBoard setText:info];
    [infoBoard sizeToFit];
  //  [infoBoard sizeThatFits:[infoBoard getInsetSize]];
    infoBoard.center=CGPointMake(self.view.center.x, infoBoard.center.y);
//    [infoBoard setLayoutMargins:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
   
  //   [infoBoard setHidden:NO];    
    
    [UIView animateWithDuration:1 animations:^{      
        infoBoard.alpha=1;
        NSLog(@"show warning info");
    }completion:^(BOOL finished){
   //     [infoBoard setHidden:YES];   
        [NSThread sleepForTimeInterval:0.8];
     //   infoBoard.alpha=0;
        [UIView animateWithDuration:1.0f animations:^{infoBoard.alpha=0;} completion:^(BOOL finished){}];
        
        
        NSLog(@" fading finished.");
    }];
    
    */
}


-(void)showCarsTableView
{
    NSLog(@"showCarsTableView is called");
    if ([appDelegate showCarsTableView]) {
        [self removeCarsTableView:nil];
        [self setCanMoveAway:true];
        return;
    }
    appDelegate.carsTableView.plot=0;
    [appDelegate loadCarsTableView];
    [titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner_up.png"]]];
}

-(IBAction)removeCarsTableView:(id)sender
{
    if (![appDelegate showCarsTableView]) {
        return;
    }
     //   [self setCanMoveAway:true];
        [appDelegate takeAwayCarsTableView];
        [titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]]];
    
}

-(void) initEcardView
{
    int width=appDelegate.screenWidth-10;
    int height=301*width/471;
    UIImageView *eCardBackground=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width
                                                                               , height)];
    [eCardBackground setImage:[UIImage imageNamed:@"ecard.png"]];
    [eCardView addSubview:eCardBackground];
    [eCardView sendSubviewToBack:eCardBackground];
 //   [eCardView setFrame:CGRectMake(5, 100, appDelegate.screenWidth-10, 256)];
  //  [eCardView setBounds:CGRectMake(0, 0, 310, 60)];
  //  [eCardView setAlpha:0.8f];
    [eCardView setHidden:YES];
    
    NSLog(@" **** initEcardView  view width:%f   height:%f",eCardView.frame.size.width,eCardView.frame.size.height);
    
    //----------------------------------
    //concerned font.
    UIFont *font=[UIFont fontWithName:@"HYh1gj" size:25.0];
    [ecGarageContact setFont:font];
    UIFont *font1=[UIFont fontWithName:@"HYh1gj" size:20.0];
    [ecGarageName setFont:font1];
    UIFont *font2=[UIFont fontWithName:@"HYh1gj" size:18.0];
    [ecGarageAddr setFont:font2];
    [ecGarageTel setFont:font2];
    [ecGarageBusiness setFont:font1];
    
}

-(void) clearSubviews
{
    [self removeCarsTableView:nil];
     [eCardView setHidden:YES];
}

// concerned register new car.
-(void) initDataBase
{
    NSString *carBrandDataBasePath=[[NSBundle mainBundle] pathForResource:@"carBrand" ofType:@"db"];
    if(sqlite3_open([carBrandDataBasePath UTF8String], &carBrandDataBase) !=SQLITE_OK)
    {
        sqlite3_close(carBrandDataBase);
        NSAssert(0,@"Failed to open carbranddatabase");
    }
    keys=[NSMutableArray array];
    lists=[NSMutableArray array];
    [self selectKeys];
}

-(void) selectKeys
{
    NSString *query=@"select letter from car_brand_table  group by letter";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(carBrandDataBase, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        char *str;
        NSString *letter;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            str=(char*)sqlite3_column_text(statement, 0);
            letter=[[NSString alloc] initWithUTF8String:str];
       //     NSLog(letter);
            [keys addObject:letter];
            [self selectBrandWithKey:letter];
        }
    }
    
    
}

-(void) selectBrandWithKey:(NSString * ) key
{
    
    NSString *query=[[NSString alloc] initWithFormat:@"select brand from car_brand_table where letter='%@' group by brand",key];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(carBrandDataBase, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        NSMutableArray *subList=[NSMutableArray array];        
        char *str;
        NSString *brand;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            str=(char*)sqlite3_column_text(statement, 0);
            brand=[[NSString alloc] initWithUTF8String:str];
       //     NSLog(brand);
            [subList addObject:brand];
        }
        [lists addObject:subList];
    }
    
}

-(IBAction)loadCarBrandView:(id)sender
{
    
    carBrandViewController.title=@"选择品牌";
    carBrandViewController.keys=keys;
    carBrandViewController.lists=lists;
    [carBrandViewController setLevel:0];
    carBrandViewController.carBrandDataBase=carBrandDataBase;    
    carBrandViewController.nav=appDelegate.navigationController;
    [appDelegate.navigationController pushViewController:carBrandViewController animated:NO];
}
-(IBAction)showAreaList:(id)sender
{
    
   // [areaViewController setAreaNameBtn:oneCarAreaName];
   // areaViewController.areaNameBtn=oneCarAreaName;
  //  [self.view addSubview:areaViewController.view];
    CGRect frame=CGRectMake((appDelegate.screenWidth-100)/2, oneCarAreaName.frame.origin.y-40, 100, 160);
    [areaViewController initWithData:appDelegate.areaCodeArray Frame:frame Button:oneCarAreaName];
    [self.view addSubview:areaViewController.view];
    
}

-(IBAction)loadCarCheckYearUnitView:(id)sender
{
    CGRect frame=CGRectMake(oneCarCheckYearUnit.frame.origin.x, oneCarCheckYearUnit.frame.origin.y-40, 70, 160);
    [areaViewController initWithData:appDelegate.carCheckYearUnits Frame:frame Button:oneCarCheckYearUnit];
    [self.view addSubview:areaViewController.view];
    
}

-(IBAction)loadCarInsuranceYearUnitView:(id)sender
{
    CGRect frame=CGRectMake(oneCarInsuranceYearUnit.frame.origin.x, oneCarInsuranceYearUnit.frame.origin.y-40, 70, 160);
    [areaViewController initWithData:appDelegate.carCheckYearUnits Frame:frame Button:oneCarInsuranceYearUnit];
    [self.view addSubview:areaViewController.view];
}

-(IBAction)returnRegisterNewCarView:(id)sender
{
    if ([appDelegate.cars count]==0) {
        return;
    }
    
    if (registerNewCarView.center.x>=0) {
        [UIView animateWithDuration:1.0 animations:^{
            registerNewCarView.center=CGPointMake(registerNewCarView.center.x-appDelegate.screenWidth, registerNewCarView.center.y);
        }];
        
    }
    // restore titleView content.
    [titleView.textLabel setText:appDelegate.currentCar.license];
    NSString *imagePath=[appDelegate getMarkWithBrand:appDelegate.currentCar.brandName];
    UIImage *image=[UIImage imageNamed: imagePath];
    [titleView.imageView setImage:image];
    
}

-(void) setRegisternewCarView
{
    /*
    [UIView animateWithDuration:0.1 animations:^{
        registerNewCarView.center=CGPointMake(self.view.center.x, registerNewCarView.center.y);
    }]; */
    registerNewCarView.transform=CGAffineTransformMakeTranslation(self.view.center.x-registerNewCarView.center.x, 0);
}

-(IBAction)clearSubViewsOnRegisterView:(id)sender
{
    [areaViewController.view removeFromSuperview ];
    [self removeCarsTableView:sender];
}


-(void) loadCreateNewCarView
{
    NSLog(@"*** loadCreateNewCarView  1");
    [self clearSubviews];
    if (createNewCarViewController==nil) {
         createNewCarViewController=[[CreateNewCarViewController alloc] initWithNibName:@"CreateNewCarViewController" bundle:nil];
    }
   // [appDelegate loadFunctionViewController:createNewCarViewController];
    [appDelegate.navigationController pushViewController:createNewCarViewController animated:YES];
     NSLog(@"*** loadCreateNewCarView  2");
    
}

-(void)showRegisterNewCar
{
    /*
    if (registerNewCarView.center.x>=0) {
        return;
    }
    [titleView.textLabel setText:@"添加新车"];
    [titleView.imageView setImage:[UIImage imageNamed:@"add_mark.png"]];
    [UIView animateWithDuration:1.0 animations:^{
        registerNewCarView.center=CGPointMake(registerNewCarView.center.x+appDelegate.screenWidth, registerNewCarView.center.y);
    }];    
    [oneCarBrandNameButton.titleLabel setText:@"选择品牌"];
    //[oneCarBrandNameButton.titleLabel setm]
    [oneCarOilBoxVolume setText:@"70"];
  //  [self initDataBase];
    */
}

-(IBAction)commitNewCarData:(id)sender
{
    /*
    NSLog(@"commit new car ");
    if ([oneCarBrandNameButton.titleLabel.text isEqualToString:@"选择品牌"]) {
       // [self showNotitationWithInfo:@"品牌！"];
        [appDelegate showNotification:@"汽车品牌!"];
        return;
    }
    if ([oneCarLicense.text isEqualToString:@""]) {
      //  [self showNotitationWithInfo:@"车牌号码！"];
        [appDelegate showNotification:@"车牌号码!"];
        return;
    }
    if ([oneCarMiles.text isEqualToString:@""]) {
       // [self showNotitationWithInfo:@"初始里程！"];
        [appDelegate showNotification:@"初始里程！"];
        return;
    }
    NSString *tLicense=[NSString stringWithFormat:@"%@%@",oneCarAreaName.titleLabel.text,oneCarLicense.text];
    tLicense=[tLicense uppercaseString];
    
    NSString *milesStr=[oneCarMiles.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *carInspectDay,*carInsuranceDay;
    NSInteger carInspectInterval=0,carInsuranceInterval=0;
    carInspectDay=inspectDay.text;
    carInsuranceDay=insuranceDay.text;
    if (![oneCarCheckYearUnit.titleLabel.text isEqualToString:@"年限"]) {
        carInspectInterval=oneCarCheckYearUnit.tag+1;
    }
    if (![oneCarInsuranceYearUnit.titleLabel.text isEqualToString:@"年限"]) {
        carInsuranceInterval=oneCarCheckYearUnit.tag+1;
    }
    if (![carInspectDay isEqualToString:@""] && carInspectInterval==0) {
        [appDelegate showNotification:@"填入车检时间间隔！"];
        return;
    }
    
    if (![carInsuranceDay isEqualToString:@""] && carInsuranceInterval==0) {
        [appDelegate showNotification:@"填入车险时间间隔！"];
        return;
    }
    
    
    Car *newCar=[[Car alloc] initTempCar:[milesStr intValue] license:tLicense];
    [newCar setBrandName:oneCarBrandNameButton.titleLabel.text];
    [newCar setOilBoxVolume:[oneCarOilBoxVolume.text doubleValue]];
    newCar.car_id=[appDelegate getNewCarId];
    
    //concerned car insurance and inspection
    
    if (carInspectInterval>0) {
        newCar.inspectDay=carInspectDay;
        newCar.inspectInterval=carInspectInterval;
     
        MaintainItem *item=[[MaintainItem alloc] initWithCarId:newCar.car_id ItemId:[appDelegate.maintainItems count]+1 itemName:@"车检" lifeTime: carInspectInterval*12 latestMaintinDate:carInspectDay];
        [appDelegate.maintainItems addObject:item];
        //   [appDelegate.maintainItems insertObject:item atIndex:0];
        [appDelegate insertMaintainItem:item ];
     
    }
    
    if (carInsuranceInterval>0) {
        newCar.insuranceDay=carInsuranceDay;
        newCar.insuranceInterval=carInsuranceInterval;
        
        MaintainItem *item=[[MaintainItem alloc] initWithCarId:newCar.car_id ItemId:[appDelegate.maintainItems count]+1 itemName:@"车险" lifeTime: carInsuranceInterval*12 latestMaintinDate:carInsuranceDay];
        [appDelegate.maintainItems addObject:item];
        [appDelegate insertMaintainItem:item];
     
    }
    
    
    [newCar initNewCarInfo];
    [appDelegate insertNewCar:newCar];
    appDelegate.currentCar=newCar;
    [appDelegate initMaintainItems];
    for (int i=0; i<[appDelegate.maintainItems count]; i++) {
        MaintainItem *item=[appDelegate.maintainItems objectAtIndex:i];
        [item setCarId:newCar.car_id];
        [appDelegate insertMaintainItem:item];
    }
    
    [self refreshView];
    [appDelegate updateMaintainCloudInfoWithBuffer:appDelegate.maintainItems Car:appDelegate.currentCar];
    
    [UIView animateWithDuration:1.0 animations:^{
        registerNewCarView.center=CGPointMake(registerNewCarView.center.x-appDelegate.screenWidth, registerNewCarView.center.y);
    }];      
    [oneCarMiles resignFirstResponder];
    [oneCarLicense resignFirstResponder];    
    [oneCarOilBoxVolume resignFirstResponder];
    
    //reset data.
    [registerNewCarScrollView setContentOffset:CGPointMake(0, 0)];
    */
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    locationManager.delegate=self;
    currentCar=appDelegate.currentCar;
    NSArray *array=[[NSArray alloc] initWithObjects:@"Sleepy",@"Sneezy",@"Bashful", nil];
    self.listData=array;
    self.maintainRecords=[NSMutableArray array]; 
    respairSubItems=[NSMutableArray array];
    leftExpend=false;
    chooseMitems=false;
    showFunctionView=false;
    currentGarageIndex=0;
    [self setCanMoveAway:true];
  
    
    UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setFrame:CGRectMake(0, 0, 24, 24)];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(drawMenuView:) forControlEvents:UIControlEventTouchUpInside];
   //  [menuBtn showBadge];
  //  [menuBtn setShowsTouchWhenHighlighted:YES];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    UIButton *addNewCarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [addNewCarBtn setFrame:CGRectMake(0, 0, 14, 14)];
    [addNewCarBtn setBackgroundImage:[UIImage imageNamed:@"new_car_mark.png"] forState:UIControlStateNormal];
    [addNewCarBtn addTarget:self action:@selector(loadCreateNewCarView) forControlEvents:UIControlEventTouchUpInside];
    [addNewCarBtn setShowsTouchWhenHighlighted:YES];
 //   self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:addNewCarBtn];
 //   leftMenuBtn.badgeCenterOffset=CGPointMake(-8, 0);
  //  [leftMenuBtn showBadge];
    UIBarButtonItem *returnButtonItem=[[UIBarButtonItem alloc] init];
    [returnButtonItem setTitle:@"返回"];
     NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    [returnButtonItem setTitleTextAttributes:fontDic forState:UIControlStateNormal];
    [self.navigationItem setBackBarButtonItem:returnButtonItem];
    
    
    titleView=[[DefaultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
    [titleView setFrame:CGRectMake(0, 0, 200, 45)];
    [titleView.textLabel setBackgroundColor:[UIColor clearColor]];
    [titleView.textLabel setTextColor:[UIColor whiteColor]];
    [titleView.textLabel setFont:[UIFont fontWithName:@"Arial" size:16.0f]];
    UIImageView *accessoryMark=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]];
    [titleView setAccessoryView:accessoryMark];
    
    self.navigationItem.titleView=titleView;
   
    
    UITapGestureRecognizer *updateCurrentMilesGeser=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateCurrentMiles)];
    [currentMilesBoard addGestureRecognizer:updateCurrentMilesGeser];
    [currentMilesBoard setUserInteractionEnabled:YES];
    
    
    
    currentCarMiles.font=[UIFont fontWithName:@"DBLCDTempBlack" size:30.0];
    
    functionBtn.layer.cornerRadius=5.0f;
    functionBtn.layer.masksToBounds=YES;
    [functionBtn setTitle:@"保养" forState:UIControlStateNormal];
    
  
    [self segmentControllSet];
    currentMilesBoard.layer.cornerRadius=5.0f;
    numberFormatter=[NSNumberFormatter new];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [moveLabel selfReInit];
   // [moveLabel setText:@"日期 天气 限号"];
   // [moveLabel start];
    
    // init miles input view
    NSArray *nibView=[[NSBundle mainBundle] loadNibNamed:@"milesInputView" owner:self options:nil];
    milesInputView=[nibView objectAtIndex:0];
    milesInputView.frame=CGRectMake(-appDelegate.screenWidth+5, 0, appDelegate.screenWidth-10, 165);
    [self.view addSubview:milesInputView];
    
  //  [milesInputView setAlpha:0.5f];
    // init eCardView.
    NSArray *nibView1=[[NSBundle mainBundle] loadNibNamed:@"electronic_card" owner:self options:nil];
    eCardView=[nibView1 objectAtIndex:0];
    int width=appDelegate.screenWidth-10;
    int height=301*width/471;
    
    NSLog(@"*!!!* ecard  width:%d, height:%d",(int)width,(int)height);
   // eCardView.frame=CGRectMake(5, 100, width, height);
    [eCardView setFrame:CGRectMake(5, 100, width,height )];
     [self.view addSubview:eCardView];
    [self initEcardView];
    
    
    maintenanceViewController=[[MaintenanceViewController alloc] initWithNibName:@"MaintenanceViewController" bundle:nil];
     fuelingViewController=[[FuelingViewController alloc] initWithNibName:@"FuelingViewController" bundle:nil];
    repairViewController=[[RepairViewController alloc] initWithNibName:@"RepairViewController" bundle:nil];
    if (createNewCarViewController==nil) {
        createNewCarViewController=[[CreateNewCarViewController alloc] initWithNibName:@"CreateNewCarViewController" bundle:nil];
    }
    // new initMaintainView
    /*
    nibView=[[NSBundle mainBundle] loadNibNamed:@"maintainItemSetView" owner:self options:nil];
    itemInitMaintainView=[nibView objectAtIndex:0];
    itemInitMaintainView.frame=CGRectMake(-appDelegate.screenWidth+5, 0, appDelegate.screenWidth-10, 400);
    //appDelegate.screenHeight-100
    [self.view addSubview:itemInitMaintainView];
    
    
    //----load maintainView----
    nibView=[[NSBundle mainBundle] loadNibNamed:@"maintainView" owner:self options:nil];
    maintainView=[nibView objectAtIndex:0];
    maintainView.frame=CGRectMake(-appDelegate.screenWidth+5, 0, appDelegate.screenWidth-10, 330);
    [self.view addSubview:maintainView];
    
    
    // init fuelingView
   
    nibView=[[NSBundle mainBundle] loadNibNamed:@"fuelingView" owner:self options:nil];
    fuelingView=[nibView objectAtIndex:0];
    fuelingView.frame=CGRectMake(-appDelegate.screenWidth+5, 0, appDelegate.screenWidth-10, 300);
    [self.view addSubview:fuelingView ];
    
    // init respairView
    nibView=[[NSBundle mainBundle] loadNibNamed:@"respairView" owner:self options:nil];
    respairView=[nibView objectAtIndex:0];
    respairView.frame=CGRectMake(-appDelegate.screenWidth+5, 0, appDelegate.screenWidth-10, 284);
    [self.view addSubview:respairView];
    
    // init registerNewCarView
    if (createNewCarViewController==nil) {
        createNewCarViewController=[[CreateNewCarViewController alloc] initWithNibName:@"CreateNewCarViewController" bundle:nil];
    }
    
    nibView=[[NSBundle mainBundle] loadNibNamed:@"registerNewCarView" owner:self options:nil];
    registerNewCarView=[nibView objectAtIndex:0];
    registerNewCarView.frame=CGRectMake(-appDelegate.screenWidth, 0, appDelegate.screenWidth, 568);
    [self.view addSubview:registerNewCarView];
    
    
    
    
    mItemLatestMiles.delegate=self;
    fuelingMiles.delegate=self;
    respairMiles.delegate=self;
    tempMiles.delegate=self;
    
    [maintainRecordsTable setSeparatorColor:[UIColor lightGrayColor]];
    [maintainRecordsTable setSeparatorInset:UIEdgeInsetsZero];
    [respairSubItemsTable setSeparatorColor:[UIColor lightGrayColor]];   
     */
  //  garageInfo.tag=0;
  //  garageInfo.text=[NSString stringWithFormat:@"%@ 提醒您:",appDelegate.garage.name];
  //  garageInfo.numberOfLines=0;
 //   UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGarageInfo)];
  //  garageInfo.userInteractionEnabled=YES;
  //  [garageInfo addGestureRecognizer:tapGesture4];
    
    
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changeGarageIndex) userInfo:nil repeats:YES];
    
    UITapGestureRecognizer *showCarsTableTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCarsTableView)];
    [titleView addGestureRecognizer:showCarsTableTap];
   // [self.view setUserInteractionEnabled:YES];
  //  UITapGestureRecognizer *viewTaper=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCarsTableView)];
  //  [self.view addGestureRecognizer:viewTaper];
    
    
    
    milesNumbers=[NSMutableArray array];
    NSInteger numberWidth=(appDelegate.screenWidth-50)/7;
    for (int i=0; i<7; i++) {
        MilesInputView *subView=[[MilesInputView alloc] initwithPos_X:(22+i*numberWidth) Pos_y:10 Width:numberWidth];
        [subView setNumber:0];
        [milesNumbers addObject:subView];
        [milesInputView addSubview:subView];
    }
    
    //concerned register new car.
  //  [oneCarBrandNameButton.titleLabel setNumberOfLines:0];
  //  [oneCarBrandNameButton.titleLabel sizeThatFits:CGSizeMake(oneCarBrandNameButton.frame.size.width, oneCarBrandNameButton.frame.size.height)];
    [oneCarBrandNameButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
 //   [oneCarBrandNameButton.titleLabel setMinimumFontSize:2];
    [oneCarBrandNameButton.titleLabel setMinimumScaleFactor:0.1];
    carBrandViewController=[[CarBrandViewController alloc] initWithNibName:@"CarBrandViewController" bundle:nil];    
    areaViewController=[[SpinnerViewController alloc] initWithNibName:@"SpinnerViewController" bundle:nil];
  //  areaViewController.areaNameBtn=oneCarAreaName;
    characterSet=[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ·"]; 
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
 //   NSLog(@"date:%@",[dateFormatter dateFromString:[NSDate date ]]);
    carBrandViewController.brandDictionary=appDelegate.brandDictionary;
    oneCarLicense.delegate=self;
    oneCarMiles.delegate=self;
    insuranceDay.delegate=self;
    insuranceDay.delegate=self;
    [oneCarAreaName.layer setCornerRadius:5.0f];
    [oneCarCheckYearUnit.layer setCornerRadius:5.0f];
    [oneCarInsuranceYearUnit.layer setCornerRadius:5.0f];
    
    [oneCarBrandMark.layer setCornerRadius:5.0f];
    [oneCarBrandNameButton.layer setCornerRadius:5.0f];
    inspectDay.inputView=customInput;
    inspectDay.inputAccessoryView=accessoryView;
    insuranceDay.inputView=customInput;
    insuranceDay.inputAccessoryView=accessoryView;
    [NSThread detachNewThreadSelector:@selector(initDataBase) toTarget:self withObject:nil];
    
    //concerned maintain view
    maintainRecordViewController=[[MaintainRecordViewController alloc] initWithNibName:@"MaintainRecordViewController" bundle:nil];
    maintainRecordViewController.title=@"保养记录";
    
    oilConsumeViewController=[[OilConsumeViewController alloc] initWithNibName:@"OilConsumeViewController" bundle:nil];
    oilConsumeViewController.title=@"油耗统计";
    showOilConsumeViewTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOilConsumeView)];
    
  //  itemInitLatestMaintainDate.inputView=customInput;
  //  itemInitLatestMaintainDate.inputAccessoryView=accessoryView;
    
    NSMutableArray *tbItems=[NSMutableArray array];
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishMaintainDateSet)];
    [tbItems addObject:barButtonItem];
    [accessoryView setItems:[[NSArray alloc] initWithObjects:barButtonItem, nil]];
    
    
    
    if ([appDelegate.cars count]>0) {
        [self refreshView];        
    } else [self showRegisterNewCar];
    
    //  info board set ;
    /*
    infoBoard=[[NotificationLabel alloc] initWithFrame:CGRectMake(20, appDelegate.screenHeight-200, appDelegate.screenWidth-40, 44)];
  //  infoBoard==[UILabel i];
    [infoBoard setBackgroundColor:[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f]];
    [infoBoard setTextColor:[UIColor whiteColor]];
    [infoBoard setFont:[UIFont fontWithName:infoBoard.font.fontName size:14]];
    [infoBoard setTextAlignment:NSTextAlignmentCenter];
    [infoBoard.layer setMasksToBounds:YES];
    [infoBoard.layer setCornerRadius:5.0f];
    [infoBoard.layer setBorderColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f].CGColor];
    [infoBoard.layer setBorderWidth:1.0f];
    [infoBoard setText:@"tttttttt"];
    [infoBoard setLayoutMargins:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    infoBoard.alpha=0;
    [self.view addSubview:infoBoard]; */
 //   NSLayoutConstraint *constraint=[NSLayoutConstraint constraintWithItem:infoBoard attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
 //   [self.view addConstraint:constraint];
    
    //concerns version
    NSComparisonResult order=[[UIDevice currentDevice].systemVersion compare:@"7.0" options:NSNumericSearch];
    if (order==NSOrderedSame || order==NSOrderedDescending) {
        // OS version>=7.0
        self.edgesForExtendedLayout=UIRectEdgeNone;
     //   [maintainItemsTable setSeparatorInset:UIEdgeInsetsZero];
     //   [respairSubItemsTable setSeparatorInset:UIEdgeInsetsZero];
    //    [maintainRecordsTable setSeparatorInset:UIEdgeInsetsZero];
        [mItemLatestMiles setTintColor:[UIColor whiteColor]];
    }
    
    [maintainItemsTable setBackgroundColor:[UIColor clearColor]];
    maintainItemsTable.layer.masksToBounds=YES;
    maintainItemsTable.layer.cornerRadius=5.0f;
  //  UIView *tableFootView=[[UIView alloc] init];
   // [tableFootView setBackgroundColor:[UIColor clearColor]];
  //  tableFootView.layer.masksToBounds=YES;
  //  tableFootView.layer.cornerRadius=5.0f;
    
    
  //  [maintainItemsTable setTableFooterView:tableFootView];
  //  [maintainItemsTable setTableHeaderView:tableFootView];
    
    [maintainItemsTable setDataSource:self];
    [maintainItemsTable setDelegate:self];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [maintainItemsTable setCollectionViewLayout:layout];
    
    [self initLocationManager];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([appDelegate.cars count]==0) {
        NSLog(@"load create new car from viewWillAppear.");
     //  [self loadCreateNewCarView];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  //   NSLog(@"tracingCarViewController viewWillDisappear");
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    int width=appDelegate.screenWidth-10;
   // int height=301*width/471;
  //  [maintainScrollView setContentSize:CGSizeMake(width, 800)];
  //  [registerNewCarScrollView setContentSize:CGSizeMake(width, 800)];
    [ecardScrollView setContentSize:CGSizeMake(width, 600)];
  //  [maintainItemSetScrollView setContentSize:CGSizeMake(appDelegate.screenWidth-10, 900)];
   // [respairScrollView setContentSize:CGSizeMake(appDelegate.screenWidth-10, 500)];
    
    //concerned tableView separator inset.
    if ([maintainItemsTable respondsToSelector:@selector(setSeparatorInset:)]) {
     //   [maintainItemsTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([maintainItemsTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [maintainItemsTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    /*
    if ([maintainRecordsTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [maintainRecordsTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([maintainRecordsTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [maintainRecordsTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    } */
    
  //  NSLog(@"tracingCarViewController viewDidLayoutSubviews");
    
}

- (void)viewDidUnload
{
    [self setSegmentControl:nil];
    [self setFunctionBtn:nil];
    [self setFuelingMiles:nil];
    [self setFuelingLastOilConsumption:nil];
    [self setFuelingOilCost:nil];
    [self setFuelingOilPrice:nil];
    [self setFuelingOilVolume:nil];
    [self setFuelingLeftPercent:nil];
    [self setRespairItemsNames:nil];
    [self setRepairCost:nil];
    [self setRespairMiles:nil];
    [self setMItemNote:nil];
   // [self setGarageInfo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    NSLog(@"tracingview viewDidUnload");
    [appDelegate saveCurrentCarInfo];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setCanMoveAway:(Boolean)flag
{
    canMoveAway=flag;
}

-(Boolean) isCanMoveAway
{
    return canMoveAway;
}


#pragma mark -
#pragma mark collectionTableView  Data Source Methods


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger rows;
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
            rows=[appDelegate.maintainItems count];
            break;
        case 1:
            rows=[appDelegate.fuelingItems count]+1;
            break;
        case 2:
            rows=[appDelegate.respairItems count];
            break;
        default:
            rows=0;
    }
    return rows;

}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row;
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
        {
            MaintainItemCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"identifier1" forIndexPath:indexPath];
            
            
            row=[indexPath row];
            MaintainItem *item=[appDelegate.maintainItems objectAtIndex:row];
            cell.itemName.lineBreakMode=NSLineBreakByWordWrapping;   //UILineBreakModeWordWrap;
            cell.itemName.numberOfLines=0;
            //    cell.itemName.preferredMaxLayoutWidth=72;
            cell.itemName.text=item.itemName;
            
            cell.checkbox.tag=row;
            [cell initAppDelegate];
            [cell showCheckBoxWithFlag:chooseMitems];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell.pastMiles setText:[[NSString alloc] initWithFormat:@"已行驶%d公里",(int)(appDelegate.currentCar.currentMiles-item.latestMaintainMiles)]];
            [cell.pastDays setText:[[NSString alloc] initWithFormat:@"已行驶%d天",(int)item.pastTime]];
            
            if (item.lifeTime>0) {
                //    [cell.timeLeftPercent setText:[[NSString alloc] initWithFormat:@"%d天",(int)item.leftTime ]];
                //    [cell.leftPercent setProgress:(float)(item.timeLeftPercent)/100];
                
                
            };
            if (item.lifeMiles>0) {
                //    [cell.milesLeftPercent setText:[[NSString alloc] initWithFormat:@"%d公里",(int)item.leftMiles]];
                //    [cell.leftPercent setProgress:(float)(item.leftPercent)/100];
                //       [cell.leftPercent setProgress:row*0.1];
            };
            
            return cell;
        }
            
        case 1:
        {
            FuelingItemCell *fcell=[collectionView dequeueReusableCellWithReuseIdentifier:@"identifier2" forIndexPath:indexPath];
            
            
            row=[indexPath row];
            if (row==0) {
                
                fcell.miles.text=[appDelegate.currentCar theLatestOilWearInfo];
                [fcell.miles setNumberOfLines:0];
                [fcell.miles sizeToFit];
                [fcell addGestureRecognizer:showOilConsumeViewTap];
                return fcell;
                
            }
            FuelingItem *fitem=[appDelegate.fuelingItems objectAtIndex:row-1];
            
            fcell.miles.text=[NSString stringWithFormat:@"%d 公里(+%d)",(int)fitem.miles,(int)fitem.addMiles];
            fcell.date.text=[NSString stringWithFormat:@"%@",fitem.date];
            fcell.volume.text=[NSString stringWithFormat:@"油量:%.1f 升 %.2f 升/公里",fitem.volume,fitem.avOil];
            fcell.cost.text=[NSString stringWithFormat:@"金额:%.1f 元 %.2f 元/公里",fitem.cost,fitem.avCost ];
            
            return fcell;
        }
        case 2:
        {
            RespairItemCell *rcell=[collectionView dequeueReusableCellWithReuseIdentifier:@"identifier3" forIndexPath:indexPath];
            
            [rcell.subItemsTable setSeparatorColor:[UIColor lightGrayColor]];
            row=[indexPath row];
            RespairItem *ritem=[appDelegate.respairItems objectAtIndex:row];
            
            rcell.miles.text=[NSString stringWithFormat:@"%d 公里",(int)ritem.miles ];
            rcell.date.text=[NSString stringWithFormat:@"%@",ritem.date];
            rcell.subItems=ritem.subItems;
            //    NSLog(@"cell respair row=%d,subitem count:%d",row,[rcell.subItems count] );
            rcell.cost.text=[NSString stringWithFormat:@"%g 元",ritem.cost];
            [rcell.subItemsTable reloadData];
            return rcell;
            
            
        }
        default:
            return nil;
    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   // return CGSizeMake(280, 60);
    
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
            return CGSizeMake(appDelegate.screenWidth-16, 90);
        case 1:
            if ([indexPath row ]==0) {
                return CGSizeMake(appDelegate.screenWidth-16, 70);
            }else  return    CGSizeMake(appDelegate.screenWidth-16, 100);
        case 2:{
            RespairItem *item=[appDelegate.respairItems objectAtIndex:[indexPath row]];
            
            return CGSizeMake(appDelegate.screenWidth-16, 121+34*[item.subItems count]);
        }
        default:
            return CGSizeMake(appDelegate.screenWidth-16, 22);
    
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (segmentControl.selectedSegmentIndex) {
        case 0:
           
            return 90;
        case 1:
            if ([indexPath row ]==0) {
                return 70;
            }
            return 100;
        case 2:
            if (tableView==respairSubItemsTable) {
                return 34;
            }else{
                
                RespairItem *item=[appDelegate.respairItems objectAtIndex:[indexPath row]];
          //      NSLog(@"cell height respair row=%ld,subitem count:%ld",[indexPath row],[item.subItems count] );
                return (121+34*[item.subItems count]);
               // return 60;
            }
            
        default:
                       
            return 44;
    }
}

/*
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(tableView==respairSubItemsTable){
        [respairSubItemsTable deselectRowAtIndexPath:[respairSubItemsTable indexPathForSelectedRow] animated:NO];
        
    }
    
    
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}  */



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==fuelingOilPrice) {
        appDelegate.currentOilPrice=[fuelingOilPrice.text floatValue];
        return YES;
    }else if (textField==fuelingOilVolume) {
        if (appDelegate.currentOilPrice==0) {
            [appDelegate showNotification:@"油价为空!"];
            return YES;
        }
      //  appDelegate.oilPrice=[fuelingOilPrice.text floatValue];
        if ([fuelingOilVolume.text isEqualToString:@""]) {
            return YES;
        }
        if (![fuelingOilCost.text isEqualToString:@""]) {
            fuelingOilCost.text=@"";
        }
        fuelingVolue=[[fuelingOilVolume.text stringByReplacingCharactersInRange:range withString:string] floatValue];
        fuelingCost=fuelingVolue*appDelegate.currentOilPrice;
        [fuelingOilCost setPlaceholder:[[NSString alloc] initWithFormat:@"%.2f",fuelingCost]];
        return YES;
    }else  if (textField==fuelingOilCost) {
        if (appDelegate.currentOilPrice==0) {
            //[fuelingOilPrice.text isEqualToString:@""]
            [appDelegate showNotification:@"油价为空!"];
            return YES;
        }
    //    appDelegate.oilPrice=[fuelingOilPrice.text floatValue];
        if ([fuelingOilCost.text isEqualToString:@""]) {
            return YES;
        }
        if (![fuelingOilVolume.text isEqualToString:@""]) {
            fuelingOilVolume.text=@"";
        }        
        fuelingCost=[[fuelingOilCost.text stringByReplacingCharactersInRange:range withString:string] floatValue];
        fuelingVolue=fuelingCost/appDelegate.currentOilPrice;
        [fuelingOilVolume setPlaceholder:[[NSString alloc] initWithFormat:@"%.2f",
                                          fuelingVolue]];
        return YES;
    }else if (textField==oneCarLicense) {
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
            
        }else{
            if (!pointed) {
                pointed=true;
                NSMutableString *tempStr=[[NSMutableString alloc] initWithFormat:@"%@",newString ];
                [tempStr insertString:@"·" atIndex:1];
                newString=(NSString*)tempStr;
            }
        }
        NSLog(@"newString:%@",newString);
        
        [textField setText:[newString substringToIndex:MIN(newString.length , 7)] ];
        return NO;        
        
    }
    NSString *text=[textField.text stringByReplacingCharactersInRange:range withString:string ];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumber *number=[NSNumber numberWithInt:[text intValue]];
    [textField setText:[numberFormatter stringFromNumber:number] ];
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==inspectDay) {
        customInput.tag=0;
    }else if(textField==insuranceDay){
        customInput.tag=1;
    }else if(textField==itemInitLatestMaintainDate){
        customInput.tag=2;
    }else if(textField==insuranceDay){
        customInput.tag=4;
    }
    
    
    return YES;
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==reComputeOilConsumeAlert) {
        if (buttonIndex==0) {
            [reComputeOilConsumeAlert removeFromSuperview];
        } else if (buttonIndex==1){
            [self reComputeOilConsume];
        }
    }else if (alertView==milesAlertView){
        if (buttonIndex==1) {
            [self updateCurrenCarMiles:milesAlertView.tag];
            [UIView animateWithDuration:0.8 animations:^{
                milesInputView.center=CGPointMake(milesInputView.center.x-appDelegate.screenWidth, milesInputView.center.y);
            }];
        }
    }
}

-(void) initLocationManager
{
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLHeadingFilterNone;
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_7_1){
        [locationManager requestAlwaysAuthorization];
    }
    appDelegate.city=nil;
    [locationManager startUpdatingLocation];
 
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations objectAtIndex:0] completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] >0) {
            CLPlacemark *placemark=[placemarks objectAtIndex:0];
            if (!appDelegate.city) {
                appDelegate.city=placemark.locality;
                appDelegate.province=placemark.administrativeArea;
                if(!appDelegate.city){
                    appDelegate.city=placemark.administrativeArea;
                }
                NSLog(@"location city:%@",appDelegate.city);
                [appDelegate getUsefulInfo];
             //   [appDelegate getru]
            }
           
        }
    }];
    [locationManager stopUpdatingLocation];
}
-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"location error");
}



@end
