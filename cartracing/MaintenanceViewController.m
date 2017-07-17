//
//  MaintenanceViewController.m
//  cartracing
//
//  Created by l on 5/10/16.
//
//

#import "MaintenanceViewController.h"
#import "AppDelegate.h"
#import "UIViewController+BackButtonHandler.h"
#import "TracingCarViewController.h"
#import "MaintainItemRecordCell.h"
#import "MaintainItem.h"
#import "MaintainRecord.h"
#import "Car.h"

@interface MaintenanceViewController ()

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSMutableArray *maintainRecords;
@property(nonatomic,retain) IBOutlet UIScrollView *maintainScrollView;
@property(nonatomic,retain) IBOutlet UITableView *currentMaintainRecordsTable;
@property(nonatomic,retain) IBOutlet UIButton *showRecordsBtn;
@property(nonatomic,retain) IBOutlet UILabel *mTitle;
@property(nonatomic,retain) IBOutlet UITextField *maintainMilesField,*maintainDate;

@end


@implementation MaintenanceViewController

@synthesize appDelegate,maintainRecords,maintainScrollView,currentMaintainRecordsTable,showRecordsBtn,maintainMilesField,mTitle,maintainDate;


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        maintainRecords=[NSMutableArray array];
        return self;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self setTitle:@"保养记录"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
     NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    UIBarButtonItem *finishBtn=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishMaintain)];
    [finishBtn setTitleTextAttributes:fontDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=finishBtn;
    
    UIView *supplementView=[[UIView alloc] init];
    [supplementView setBackgroundColor:[UIColor clearColor]];
    [supplementView.layer setMasksToBounds:YES];
    [supplementView.layer setCornerRadius:5.0f];
    [currentMaintainRecordsTable setTableFooterView:supplementView];
    [currentMaintainRecordsTable setTableHeaderView:supplementView];
    
    [appDelegate setDateInputView:maintainDate];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [currentMaintainRecordsTable reloadData];
    if ([maintainRecords count]==1) {
        [mTitle setText:@"单项保养"];
    }else [mTitle setText:@"批量保养"];
    
    NSNumber *number=[NSNumber numberWithInteger:appDelegate.currentCar.currentMiles];
    [maintainMilesField setText:[appDelegate.numberFormater stringFromNumber:number]];
   // [maintainMilesField setText:@"1111"];
    [maintainDate setText:[appDelegate.dateFormatter stringFromDate:[NSDate date]]];
    //.
 //   [maintainScrollView setContentSize:CGSizeMake(appDelegate.screenWidth-10, 900)];
    [maintainScrollView setContentOffset:CGPointMake(0, 0)];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [showRecordsBtn.titleLabel setNumberOfLines:0];
    showRecordsBtn.titleLabel.lineBreakMode=0;
    [showRecordsBtn setTitle:@"全部\n保养\n记录" forState:UIControlStateNormal];
    self.navigationController.navigationBar.hidden=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    CGFloat width=appDelegate.screenWidth-10;
    [maintainScrollView setContentSize:CGSizeMake(appDelegate.screenWidth, appDelegate.screenHeight)];
    
    if ([currentMaintainRecordsTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [currentMaintainRecordsTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([currentMaintainRecordsTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [currentMaintainRecordsTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(IBAction)forwardStep:(id)sender{
    [appDelegate removeFunctionViewController:self];
    [self finishMaintain];
}

-(IBAction)backwardStep:(id)sender{
    [appDelegate removeFunctionViewController:self];
    [self navigationShouldPopOnBackButton];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -Tableview

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34.0f;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 //   NSLog(@"numberOfRowsInSection %d",(int)[maintainRecords count]);
    return [maintainRecords count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"MaintainRecordIdentifier";
    MaintainItemRecordCell *recordCell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (recordCell==nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"MaintainItemRecordCell" owner:self options:nil];
        recordCell=[nib objectAtIndex:0];
    }
    
    NSInteger row=[indexPath row];
    MaintainRecord *record=[maintainRecords objectAtIndex:row];
    recordCell.itemName.text=record.itemname;
    if (record.lifeMiles!=0) {
        [recordCell.lifeMiles setText: [[NSString alloc] initWithFormat:@"%d", (int)record.lifeMiles]];
    }else{
        [recordCell.lifeMiles setText: [[NSString alloc] initWithFormat:@"%d月", (int)record.lifeTime]];
    }
    
    [recordCell setRecord:record];
    
    [recordCell.cost1 setTintColor:[UIColor whiteColor]];
    [recordCell.cost2 setTintColor:[UIColor whiteColor]];
    return recordCell;
    

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

#pragma mark -maintainRecords

-(void) clearMaintainRecords
{
    [maintainRecords removeAllObjects];
}

-(BOOL) isNullRecords
{
    if ([maintainRecords count]==0) {
        return YES;
    }
    return NO;
}

-(void) addMaintainRecord:(MaintainRecord *)record
{
    [maintainRecords addObject:record];
}

-(void) finishMaintain
{
    // get maintain miles
    NSString *text=[maintainMilesField text];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger tMiles=[text intValue];
    
    NSString* currentDate=[maintainDate text];
    
    if ([currentDate isEqualToString:@""]) {
        [appDelegate showNotification:@"请输入保养日期!"];
        return;
    }
    
    //check validity of maintain miles
    MaintainRecord *record;
    for (int i=0; i<[maintainRecords count]; i++) {
        record=[maintainRecords objectAtIndex:i];
        if (tMiles<record.maintainMiles) {
            [appDelegate showNotification:[NSString stringWithFormat:@"%@ 上次保养里程大于当前保养里程!",record.itemname]];
            return;
        }
    }
    
    //update maintain data
    MaintainItem *item;
    for (int i=0; i<[appDelegate.maintainItems count]; i++) {
        item=[appDelegate.maintainItems objectAtIndex:i];
        if (item.mTag==0) {
            if (tMiles>appDelegate.currentCar.currentMiles) {
                [item updateCurrentMiles:tMiles];
            }
        }if (item.mTag>0) {
             [item maintain:tMiles Date:currentDate];
        }
    }
    
    //commit maintain data
    [appDelegate updateMaintainItemInfoOfCar:appDelegate.currentCar WithBuffer:appDelegate.maintainItems];
     [appDelegate postMaintainRecordsOfCar:appDelegate.currentCar Buffer:maintainRecords];
   
    //refresh mainView
    [appDelegate.tracingCarViewController finishFunctionOprationWithMiles:tMiles];
    
    
    //slipe down keyboard
    MaintainItemRecordCell *recordCell;
    for (int i=0; i<[maintainRecords count]; i++) {
        record=[maintainRecords objectAtIndex:i];
        record.maintainMiles=tMiles;
        [appDelegate insertmaintainRecord:record];
        recordCell=(MaintainItemRecordCell*)[currentMaintainRecordsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0 ]];
        [recordCell.cost1 resignFirstResponder];
        [recordCell.cost2 resignFirstResponder];
    }
    
    [maintainMilesField resignFirstResponder];
    
 //   [appDelegate.navigationController popViewControllerAnimated:YES];
   
}

-(BOOL) navigationShouldPopOnBackButton
{
  //  [appDelegate.navigationController popViewControllerAnimated:YES];
    
    [maintainMilesField resignFirstResponder];
    MaintainItemRecordCell *recordCell;
    for (int i=0; i<[maintainRecords count]; i++) {
        recordCell=(MaintainItemRecordCell*)[currentMaintainRecordsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0 ]];
        [recordCell.cost1 resignFirstResponder];
        [recordCell.cost2 resignFirstResponder];
    }
    
 //   showFunctionView=false;
    MaintainItem *item;
    for (int i=0; i<[appDelegate.maintainItems count] ;  i++) {
        item=[appDelegate.maintainItems objectAtIndex:i];
        [item freshTag];
    }
    
    [appDelegate.tracingCarViewController finishFunctionOprationWithMiles:0];

    
//    [self.maintainItemsTable reloadData];
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    [appDelegate setCurrentInputDate:maintainDate];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text=[textField.text stringByReplacingCharactersInRange:range withString:string ];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumber *number=[NSNumber numberWithInt:[text intValue]];
    [textField setText:[appDelegate.numberFormater stringFromNumber:number] ];
    return NO;
}

@end
