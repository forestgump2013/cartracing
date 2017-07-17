//
//  MaintainItemInitViewController.m
//  cartracing
//
//  Created by l on 6/5/16.
//
//

#import "AppDelegate.h"
#import "TracingCarViewController.h"
#import "Car.h"
#import "MaintainItem.h"
#import "MaintainItemInitViewController.h"

@interface MaintainItemInitViewController ()

@property(nonatomic,retain) AppDelegate *appDelegate;
// maintian item init view.
@property(nonatomic,retain) UIView *maintainItemInitView;
@property(nonatomic,retain) IBOutlet UIView *milesView,*timeView;
@property(nonatomic,retain) IBOutlet UILabel *itemInitItemName,*itemDetail,*dateLableName;
@property(nonatomic,retain) IBOutlet UITextField *itemInitLatestMaintainMiles,*addMaintainItemName;
@property(nonatomic,retain) IBOutlet UITextField *itemInitMaintainLifeMiles;
@property(nonatomic,retain) IBOutlet UITextField *itemInitLatestMaintainDate;
@property(nonatomic,retain) IBOutlet  UITextField *itemInitLatestMaintainDateDiv;
@property(nonatomic, retain) IBOutlet UIScrollView *maintainItemSetScrollView;
@property(nonatomic,retain) IBOutlet NSLayoutConstraint *topMarginContraint;
@end

@implementation MaintainItemInitViewController

@synthesize appDelegate;
@synthesize itemInitItemName,itemInitLatestMaintainMiles,addMaintainItemName,itemInitMaintainLifeMiles,itemInitLatestMaintainDate,itemInitLatestMaintainDateDiv,maintainItemSetScrollView,itemDetail,milesView,
    timeView,topMarginContraint,dateLableName;
@synthesize buffer,parentTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view from its nib.
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    UIBarButtonItem *finishBtn=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishInitSet)];
    [finishBtn setTitleTextAttributes:fontDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=finishBtn;
    [appDelegate setDateInputView:itemInitLatestMaintainDate];
    [itemInitLatestMaintainDate setDelegate:self];
    CGRect viewFrame=self.view.frame;
    [self.view setFrame:CGRectMake(0, viewFrame.origin.y+50, viewFrame.size.width, viewFrame.size.height-50)];
    
    self.view.bounds = CGRectInset(self.view.frame, 0.0f, -50.0f);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated
{
    if (itemIndex>=0) {
        newFlag=NO;
         MaintainItem *item=[appDelegate.maintainItems objectAtIndex:itemIndex ];
        [itemDetail setText:[appDelegate.itemDetails objectAtIndex:item.itemId-1]];
        itemName=[NSString stringWithFormat:@"%@",item.itemName];
        if ([item.itemName isEqual:@"车检"]   || [item.itemName isEqual:@"车险"]) {
            [dateLableName setText:[[NSString alloc] initWithFormat:@"上次%@日期",item.itemName]];
            itemJustTime=YES;
        }
        [self setTitle:@"初始保养"];
    }else{
        [self setTitle:@"添加保养"];
        [itemDetail setText:@""];
        newFlag=YES;
        itemName=@"名称";
    }
    [addMaintainItemName  setHidden:!newFlag];
    
    [itemDetail sizeToFit];
    [itemInitItemName setText:itemName];
    
    //clean view.
    
    [maintainItemSetScrollView setContentOffset:CGPointMake(0, 0)];
    [itemInitLatestMaintainMiles setText:@""];
    [itemInitMaintainLifeMiles setText:@""];
    [itemInitLatestMaintainDate setText:@""];
    [itemInitLatestMaintainDateDiv setText:@""];
    
    if (itemJustTime) {
        //just show time.
        [milesView setHidden:YES];
        [topMarginContraint setConstant:16];
        [timeView updateConstraints];
        
    }
    
    self.navigationController.navigationBar.hidden=YES;
}


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (itemJustTime) {
        //drawdown tiem view.
        itemJustTime=NO;
        [milesView setHidden:NO];
        [timeView setFrame:CGRectMake(timeView.frame.origin.x, timeView.frame.origin.y+128, timeView.frame.size.width, timeView.frame.size.height)];
        
    }
   
}

-(void) viewDidLayoutSubviews
{
    [maintainItemSetScrollView setContentSize:CGSizeMake(appDelegate.screenWidth, appDelegate.screenHeight+400)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
-(void) prepareViewWithFlag:(BOOL)flag ItemName:(NSString *)name
{
    newFlag=flag;
    itemName=name;
 
} */

-(void) setContainerData:(NSMutableArray *)bs containerTable:(UITableView *)table
{
    buffer=bs;
    parentTable=table;
}

-(void) setisJustTime:(BOOL)isTime
{
    itemJustTime=isTime;
}

-(void) setNewItemIndex:(NSInteger)index
{
    itemIndex=index;
}

-(IBAction)forwardStep:(id)sender{
    [self finishInitSet];
    [appDelegate removeFunctionViewController:self];
}

-(IBAction)backwordStep:(id)sender{
    [appDelegate removeFunctionViewController:self];
}

-(void) finishInitSet
{
    
    NSInteger latestMaintainMiles=[[itemInitLatestMaintainMiles.text stringByReplacingOccurrencesOfString:@"," withString:@""] intValue];
    NSInteger lifeMiles=[[itemInitMaintainLifeMiles.text stringByReplacingOccurrencesOfString:@"," withString:@""] intValue];
    if ((latestMaintainMiles+lifeMiles)>0 &&latestMaintainMiles*lifeMiles==0) {
        [appDelegate showNotification:@"里程保养数据有误！"];
        return;
    }
    CGFloat intervalYear=[itemInitLatestMaintainDateDiv.text floatValue];
    NSString *date=itemInitLatestMaintainDate.text;
    if (intervalYear>0 && [date isEqualToString:@""]) {
        [appDelegate showNotification:@"时间保养数据有误！"];
        return;
    }
    
    [itemInitLatestMaintainMiles resignFirstResponder];
    [itemInitMaintainLifeMiles resignFirstResponder];
    [itemInitLatestMaintainDate resignFirstResponder];
    [itemInitLatestMaintainDateDiv resignFirstResponder];
    
    MaintainItem *item;
    if (itemIndex>=0) {
        if (latestMaintainMiles>appDelegate.currentCar.currentMiles) {
            [appDelegate showNotification:@"上次保养里程大于当前里程！"];
            return;
        }
        // init maintain item
        item=[appDelegate.maintainItems objectAtIndex:itemIndex];
        [item editItemWithCurrentMiles:appDelegate.currentCar.currentMiles LatestMaintainMiles:latestMaintainMiles  LifeMiles:lifeMiles  latestDate:date DateLife:intervalYear*12];
        [appDelegate updateSignalMaintainItemWithMaintianItem:item];
        [appDelegate.tracingCarViewController.maintainItemsTable reloadData];
    //    [appDelegate.navigationController popViewControllerAnimated:YES];
        
    } else{
        // add new maintain item.
        NSInteger currentMiles=-itemIndex;
        if (latestMaintainMiles>currentMiles) {
            [appDelegate showNotification:@"上次保养里程大于当前里程！"];
            return;
        }
        item=[[MaintainItem alloc] initWithCarId:-1 ItemId:-1 itemName:addMaintainItemName.text lifeMiles:lifeMiles latestMaintinMiles:latestMaintainMiles leftPercent:100 leftMiles:lifeMiles APPLYMARK:1];
        [item setTimeLife:intervalYear*12 latestMDate:date];
        [appDelegate insertMaintainItem:item];
        [buffer addObject:item];
        [parentTable reloadData];
    //    [appDelegate.leftNavigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    appDelegate.currentInputDate=itemInitLatestMaintainDate;
}

@end
