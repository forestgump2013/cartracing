//
//  SetViewController.m
//  cartracing
//
//  Created by l on 4/24/16.
//
//

#import "SetViewController.h"
#import "AppDelegate.h"
#import "TracingCarViewController.h"
#import "LoginViewController.h"
#import "CarOwnerRegisterViewController.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImage *accessImageMark;
}

@property(nonatomic,retain) IBOutlet UITableView *table;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) CarOwnerRegisterViewController *carOwnerRegisterViewController;

@end

@implementation SetViewController

@synthesize table,appDelegate,carOwnerRegisterViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self setTitle:@"个人设置"];
   // [self.navigationController setNavigationBarHidden:NO];
  
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
      //  self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    [background setContentMode:UIViewContentModeScaleToFill];
    [background setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view  insertSubview:background atIndex:0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    [table setBackgroundColor:[UIColor clearColor]];
    
    //
     carOwnerRegisterViewController=[[CarOwnerRegisterViewController alloc] initWithNibName:@"CarOwnerRegisterViewController" bundle:nil];
    //
    UIView *tableFootView=[[UIView alloc] init];
    [tableFootView setBackgroundColor:[UIColor clearColor]];
    [tableFootView.layer setMasksToBounds:YES];
    [tableFootView.layer setCornerRadius:5.0f];
    [table setTableFooterView:tableFootView];
    [table setTableHeaderView:tableFootView];
    
    accessImageMark=[appDelegate image:[UIImage  imageNamed:@"slidedown.png"] rotation:UIImageOrientationLeft];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    
}

-(void) viewWillLayoutSubviews
{
    if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
        [table setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
        [table setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([appDelegate.ownerTel isEqualToString:@"none"]) {
        return 2;
    }
    return 3;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch ([indexPath row]) {
        case 0:
            if ([appDelegate.ownerTel isEqualToString:@"none"]) {
                [cell.textLabel setText:@"登录注册"];
            }else [cell.textLabel setText:@"密码重置"];
            break;
        case 1:
            [cell.textLabel setText:@"分享"];
            break;
        case 2:
            [cell.textLabel setText:@"退出登录"];
            
        default:
            break;
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    
    UIImageView *imageView=[[UIImageView alloc] initWithImage:accessImageMark];
    [imageView setFrame:CGRectMake(0, 0, 16, 18)];

    [cell setAccessoryView:imageView];
    
  //  [appDelegate image:[UIImage  imageNamed:@"slidedown.png"] rotation:UIImageOrientationRight];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 0:
            if ([appDelegate.ownerTel isEqualToString:@"none"]) {
                [self loadLoginView];
            }else{
                //logined
                [carOwnerRegisterViewController setWithFlag:1];
                [appDelegate.leftNavigationController pushViewController:carOwnerRegisterViewController animated:YES];
            }
            break;
        case 1: //share.
             [appDelegate sendTextToWeiXin:@"欢迎使用汽车云管理！"];
            break;
        case 2: // unlogin.
            [appDelegate unlogin];
            [self loadLoginView];
            break;
            
        default:
            break;
    }
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
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

-(void) loadLoginView
{
    [appDelegate.navigationController.view setHidden:NO];
    [appDelegate.navigationController pushViewController:appDelegate.loginViewController animated:NO];
    [appDelegate.tracingCarViewController loadCarManageView:nil];
    [appDelegate.leftNavigationController popViewControllerAnimated:YES];
}

@end
