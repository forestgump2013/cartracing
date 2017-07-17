//
//  RepairViewController.m
//  cartracing
//
//  Created by l on 5/18/16.
//
//

#import "RepairViewController.h"
#import "AppDelegate.h"
#import "TracingCarViewController.h"
#import "Car.h"
#import "RespairItem.h"
#import "RespairSubItemCell.h"
#import "RespairSubItem.h"

@interface RepairViewController ()

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSMutableArray *repairSubItems;
@property(nonatomic,retain) NSArray *nib;
@property(nonatomic,retain) IBOutlet UILabel *repairCost;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITableView *repairItemsTable;
@property(nonatomic,retain) IBOutlet UITextField *repairMiles,*repairDate;
@property NSInteger row;

@end

@implementation RepairViewController

@synthesize appDelegate,scrollView,repairItemsTable,repairSubItems,repairMiles,repairCost,nib,row,repairDate;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    repairSubItems=[NSMutableArray array];
    for (int i=0; i<20; i++) {
        RespairSubItem *subItem=[[RespairSubItem alloc] init];
        [repairSubItems insertObject:subItem atIndex:0];
    }
    
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self setTitle:@"维修记录"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
     NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishRepairRecord)];
    [rightBtn setTitleTextAttributes:fontDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    UIView *supplementView=[[UIView alloc] init];
    [supplementView setBackgroundColor:[UIColor clearColor]];
    [supplementView.layer setMasksToBounds:YES];
    [supplementView.layer setCornerRadius:5.0f];
    [repairItemsTable setTableFooterView:supplementView];
    [repairItemsTable setTableHeaderView:supplementView];
    [repairCost setText:@""];
    [repairDate setDelegate:self];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSNumber *number=[NSNumber numberWithInteger:appDelegate.currentCar.currentMiles];
    [repairMiles setText:[appDelegate.numberFormater stringFromNumber:number]];
    [repairDate setText:[ appDelegate.dateFormatter stringFromDate:[NSDate date]]];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [scrollView setContentSize:CGSizeMake(appDelegate.screenWidth, appDelegate.screenHeight+400)];
    if ([repairItemsTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [repairItemsTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([repairItemsTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [repairItemsTable setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma table method.

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [repairSubItems count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"RespairSubItemIdentifier";
    RespairSubItemCell *subItemCell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (subItemCell==nil) {
        nib=[[NSBundle mainBundle] loadNibNamed:@"RespairSubItemCell" owner:self options:nil];
        subItemCell=[nib objectAtIndex:0];
    }
    row=[indexPath row];
    RespairSubItem *subItem=[repairSubItems objectAtIndex:row];
    //    NSLog(@"respair sub item cell: %@ row:%ld,cost1:%.1f",subItem.name,row,subItem.cost1);
    subItemCell.name.text=subItem.name;
    if (subItem.cost1==0) {
        subItemCell.cost1.text=@"";
    } else subItemCell.cost1.text=[[NSString alloc] initWithFormat:@"%.1f",subItem.cost1];
    
    if (subItem.cost2==0) {
        subItemCell.cost2.text=@"";
    } else subItemCell.cost2.text=[[NSString alloc] initWithFormat:@"%.1f",subItem.cost2];
    [subItemCell.name setTintColor:[UIColor whiteColor]];
    [subItemCell.cost1 setTintColor:[UIColor whiteColor]];
    [subItemCell.cost2 setTintColor:[UIColor whiteColor]];
    
    [subItemCell setSubItem:subItem];
    [subItemCell setTotalCost:repairCost];
    [subItemCell setEditingStyle];
    return subItemCell;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34;
}

-(IBAction)forwardStep:(id)sender
{
    [appDelegate removeFunctionViewController:self];
    [self finishRepairRecord];
}

-(IBAction)backwardStep:(id)sender
{
     [appDelegate removeFunctionViewController:self];
}

-(void) finishRepairRecord
{
    [repairMiles resignFirstResponder];
    //   [respairItemsNames resignFirstResponder];
    //   [repairCost resignFirstResponder];
    NSString *text=repairMiles.text;
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger miles=[text intValue];
    //  NSString *names=respairItemsNames.text;
    /*
    if (miles<appDelegate.currentCar.currentMiles) {
        [appDelegate showNotification:@"里程小于当前里程!"];
        return;
    } */
    
    CGFloat tcost=[repairCost.text floatValue ];
  //  NSDate *sendDate=[NSDate date];
    //   [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *date=[repairDate text ];//[ appDelegate.dateFormatter stringFromDate:sendDate];
    RespairItem *item=[[RespairItem alloc] initWithNames:@"" Miles:miles Cost:tcost Date:date];
    NSMutableString *repairItem=[[NSMutableString alloc] init];
    RespairSubItem *subItem;
    RespairSubItemCell *subItemCell;
    for (int i=0; i<[repairSubItems count]; i++) {
        subItem=[repairSubItems objectAtIndex:i];
        subItemCell=(RespairSubItemCell*)[repairItemsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
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
    
    [appDelegate.respairItems insertObject:item atIndex:0];
    [appDelegate insertRespairRecord:item];
    [appDelegate postRepairRecordOfCar:appDelegate.currentCar Record:item];
    
  //   [appDelegate.tracingCarViewController finishFunctionOprationWithMiles:miles];
 
}

-(IBAction)addRepairSubItem:(id)sender
{
    RespairSubItem *subItem=[[RespairSubItem alloc] init];
    [repairSubItems insertObject:subItem atIndex:0];
    [repairItemsTable reloadData];
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
