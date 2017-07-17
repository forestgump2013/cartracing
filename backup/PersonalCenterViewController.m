//
//  PersonalCenterViewController.m
//  234
//
//  Created by l on 14-7-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MaintainItem.h"
#import "PersonalCenterViewController.h"
#import "CallBackViewController.h"
#import "HelpViewController.h"
#import "PartnerManageViewController.h"
#import "GarageManageViewController.h"
#import "CarManageViewController.h"
#import "TracingCarViewController.h"
#import "LoginViewController.h"
#import "CarOwnerRegisterViewController.h"

@implementation PersonalCenterViewController

@synthesize viewType,typeButton,carManagerBtn,callBackBtn,helpBtn,unloginBtn,shareBtn;

@synthesize appDelegate;
@synthesize callBackViewController,helpViewController;
@synthesize partnerViewController;
@synthesize garageManageViewController;
@synthesize carManageViewController;
@synthesize loginViewController,carOwnerRegisterViewController;
@synthesize loginView,modifyPasswordView,loginBtn,carCloudImage;

-(void) updateView
{
    /*
    switch (appDelegate.memberType) {
        case 0:
            garageManageViewController=[[GarageManageViewController alloc] initWithNibName:@"suggestGarageView" bundle:nil];
            garageManageViewController.title=@"反馈汽修厂";
            break;
        case 1:
            garageManageViewController=[[GarageManageViewController alloc] initWithNibName:@"GarageManageViewController" bundle:nil];   
            garageManageViewController.title=@"汽修厂管理";
            [typeButton setTitle:@"汽修厂管理" forState:UIControlStateNormal];
            break;
        case 2:
            garageManageViewController=[[GarageManageViewController alloc] initWithNibName:@"garagePassView" bundle:nil];
            garageManageViewController.title=@"汽修厂审批";
            [typeButton setTitle:@"汽修厂审批" forState:UIControlStateNormal];            
            break;
        default:
            break;
    }
    */
    CGFloat tx=(appDelegate.screenWidth*2/3-130)/2-20;
    carCloudImage.transform=CGAffineTransformMakeTranslation(tx, 0);
    carManagerBtn.transform=CGAffineTransformMakeTranslation(tx, 0);
    loginBtn.transform=CGAffineTransformMakeTranslation(tx, 0);
    callBackBtn.transform=CGAffineTransformMakeTranslation(tx, 0);
    helpBtn.transform=CGAffineTransformMakeTranslation(tx, 0);
    shareBtn.transform=CGAffineTransformMakeTranslation(tx, 0);
    unloginBtn.transform=CGAffineTransformMakeTranslation(tx, 0);
    typeButton.transform=CGAffineTransformMakeTranslation(tx, 0);
    
    //about rigister's operation.
    if ([appDelegate.ownerTel isEqualToString:@"none"] ) {
        // [loginBtn.titleLabel setText:@"注册登录"];
        [loginBtn setTitle:@"注册登录" forState:UIControlStateNormal];
        [loginBtn setTitle:@"注册登录" forState:UIControlStateHighlighted];
     //   [unloginBtn setHidden:YES];
    } else {
        //   [loginBtn.titleLabel setText:@"修改密码"];
        [loginBtn setTitle:@"修改密码" forState:UIControlStateNormal];
        [loginBtn setTitle:@"修改密码" forState:UIControlStateHighlighted];
        [unloginBtn setHidden:NO];
        [typeButton setHidden:NO];
        switch (appDelegate.memberType) {
            case 0:
                [typeButton setHidden:YES];
                break;
            case 1:
                [typeButton setTitle:@"商家管理" forState:UIControlStateNormal];
                [typeButton setTitle:@"商家管理" forState:UIControlStateHighlighted];
                break;
            case 2:
                [typeButton setTitle:@"业务专属" forState:UIControlStateNormal];
                [typeButton setTitle:@"业务专属" forState:UIControlStateHighlighted];
                break;
            case 3:
                [typeButton setTitle:@"最高管理" forState:UIControlStateNormal];
                [typeButton setTitle:@"最高管理" forState:UIControlStateHighlighted];
                break;
                
            default:
                break;
        }

        
    }
    
}

-(void) leftOutMainView
{
    UIView *mainView=appDelegate.navigationController.view;
    [mainView setHidden:YES];
 //   [appDelegate.leftNavigationController.navigationBar setHidden:NO];
  //  [UIView animateWithDuration:1.0 animations:^{
  //      mainView.center=CGPointMake(mainView.center.x-160, mainView.center.y);  
  //  }];
}

-(void) returnMainView
{
    NSLog(@"returnMainView is worked");
    UIView *mainView=appDelegate.navigationController.view;
    [mainView setHidden:NO];
  //  [appDelegate.leftNavigationController.navigationBar setHidden:YES];
    //   leftNavigationController.navigationBar.hidden=YES;
}

-(IBAction)checkBeforeReturn:(id)sender
{
    NSLog(@"checkBeforeReturn is worked");    
    if ([appDelegate.cars count]==0) {
        // show register new car View.
        
        [appDelegate.tracingCarViewController reLocationRegisterNewCarView];
    }
    [self returnMainView];
    
}

-(IBAction)loadCarManagementView:(id)sender
{
    [self leftOutMainView];
  //  UIBarButtonItem *backBtn=[[UIBarButtonItem alloc] initWithTitle:@"aaa" style:UIBarButtonItemStyleBordered target:self action:@selector(returnMainView)];
  //  [self.navigationItem setBackBarButtonItem:backBtn];
    [self.navigationItem hidesBackButton];
    [carManageViewController.navigationItem hidesBackButton];
 //   [carManageViewController.navigationItem setBackBarButtonItem:backBtn];
    
    [appDelegate.leftNavigationController pushViewController:carManageViewController animated:NO];
    
    
}

-(IBAction)typeFunction:(id)sender
{
    [self leftOutMainView];
    switch (appDelegate.memberType) {
        case 0:
            // no function temporary
            break;
        case 1:
            // concerned garage manage
            [appDelegate.leftNavigationController pushViewController:garageManageViewController animated:YES];
            break;
        case 2:
            // concerned partner
            [appDelegate.leftNavigationController pushViewController:partnerViewController animated:YES];
            break;
            
        default:
            break;
    }
    
    
  //  [appDelegate.leftNavigationController pushViewController:garageViewController animated:YES];
}

-(IBAction)loadCallBackView:(id)sender
{
    [self leftOutMainView];
    [appDelegate.leftNavigationController pushViewController:callBackViewController animated:YES];
}

-(IBAction)loadHelpView:(id)sender
{
    [self leftOutMainView];
    helpViewController.container=appDelegate.leftNavigationController;
    helpViewController.appDelegate=appDelegate;
    [appDelegate.leftNavigationController pushViewController:helpViewController animated:YES];    
}

-(IBAction)shareInfo:(id)sender
{
    [appDelegate sendTextToWeiXin:@"欢迎使用汽车云管理！"];
}

-(IBAction)loadLoginView:(id)sender
{
    
    if ([appDelegate.ownerTel isEqualToString:@"none"] ) {
        [UIView animateWithDuration:1.0 animations:^{
            appDelegate.navigationController.view.center=CGPointMake(appDelegate.navigationController.view.center.x-(appDelegate.screenWidth*2/3), appDelegate.navigationController.view.center.y);
            
        }];
        [appDelegate.navigationController pushViewController:loginViewController animated:YES];
        
 //   [appDelegate.leftNavigationController pushViewController:loginViewController animated:YES];
        
    } else  {
        [self leftOutMainView];
        [carOwnerRegisterViewController setWithFlag:1];
        [appDelegate.leftNavigationController pushViewController:carOwnerRegisterViewController animated:YES];
        
    }
    
    
}

-(IBAction)unLogin:(id)sender
{
    [self returnMainView];
    [appDelegate unlogin];
  ///  [loginViewController.view addSubview:loginView];
 //   [appDelegate.leftNavigationController pushViewController:loginViewController animated:YES];
  //  loginViewController.container=appDelegate.navigationController;
    [appDelegate.navigationController pushViewController:appDelegate.loginViewController animated:NO];
    [appDelegate.tracingCarViewController loadCarManageView:nil];
    
}


-(IBAction)loadGarageManageView:(id)sender
{
    
    [self leftOutMainView];
    [appDelegate.leftNavigationController pushViewController:garageManageViewController animated:YES];
}

-(void) postCarInfo
{
    //post car info
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/postCarInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"carjson=%@",[appDelegate carsJson]];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSLog(@"post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"get data:%@",reponseString);            
        }
        else NSLog(@"post error!");
    }];    
}

-(void)postMaintainInfo
{
    //post maintain info
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/postMaintainInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"maintainjson=%@",[appDelegate dataToCloud]];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    //  NSHTTPURLResponse *response=nil;
    //  NSError *error=[[NSError alloc] init];
    /*66
     NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
     if (error) {
     NSLog(@"Something wrong: %@",[error description]);
     }else {
     if (responseData) {
     NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
     NSLog(@"get %@",responseString);    */
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSLog(@"post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"get data:%@",reponseString);            
        }
        else NSLog(@"post error!");
    }];    
}

-(void) postFuelingInfo
{
    //post fueling info
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/postFuelingInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"fuelingjson=%@",[appDelegate fuelingJson]];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSLog(@"post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"get data:%@",reponseString);            
        }
        else NSLog(@"post error!");
    }];       
    
}

-(void)postRespairInfo
{
    //post respair info
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/postRespairInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"repairjson=%@",[appDelegate respairJson]];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSLog(@"post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"get data:%@",reponseString);            
        }
        else NSLog(@"post error!");
    }];   
}

-(IBAction)postInfo:(id)sender
{
    [self postCarInfo];
  //  [self postFuelingInfo];
  //  [self postRespairInfo];
    
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  //  NSLog(@"viewDidUnload is called");    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.title=@"返回";
  //  [self.navigationItem hidesBackButton];
    carManageViewController=[[CarManageViewController alloc] initWithNibName:@"CarManageViewController" bundle:nil];
    
    callBackViewController=[[CallBackViewController alloc] initWithNibName:@"CallBackViewController" bundle:nil];  
    helpViewController=[[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil] ;
    
    callBackViewController.appDelegate=appDelegate;
    partnerViewController=[[PartnerManageViewController alloc] initWithNibName:@"PartnerManageViewController" bundle:nil];
    
    loginViewController=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil ];
    carOwnerRegisterViewController=[[CarOwnerRegisterViewController alloc] initWithNibName:@"CarOwnerRegisterViewController" bundle:nil];
    
 //   NSArray *nibView=[[NSBundle mainBundle] loadNibNamed:@"LoginViewController" owner:self options:nil];
  //  loginView=[nibView objectAtIndex:0];
    NSComparisonResult order=[[UIDevice currentDevice].systemVersion compare:@"7.0" options:NSNumericSearch];
    if (order==NSOrderedSame || order==NSOrderedDescending) {
        // OS version>=7.0
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
  //  [self.navigationController.navigationBar setHidden:YES];
    
    
        
}

- (void)viewDidUnload
{
    NSLog(@"viewDidUnload is called");
    [self setTypeButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
 //   NSLog(@"viewWillDisappear is called");
    
}

-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"person center viewWillAppear is called memberType:%d",appDelegate.memberType);
    [super viewWillAppear:animated];
    [appDelegate.navigationController.view setHidden:NO];
    appDelegate.leftNavigationController.navigationBar.hidden=YES;
    
    //about rigister's operation.
    if ([appDelegate.ownerTel isEqualToString:@"none"] ) {
        // [loginBtn.titleLabel setText:@"注册登录"];
        [loginBtn setTitle:@"注册登录" forState:UIControlStateNormal];
        [loginBtn setTitle:@"注册登录" forState:UIControlStateHighlighted];
        [unloginBtn setHidden:YES];
        [typeButton setHidden:YES];
    } else {
        //   [loginBtn.titleLabel setText:@"修改密码"];
        [loginBtn setTitle:@"修改密码" forState:UIControlStateNormal];
        [loginBtn setTitle:@"修改密码" forState:UIControlStateHighlighted];
        [unloginBtn setHidden:NO];
        [typeButton setHidden:NO];
        switch (appDelegate.memberType) {
            case 0:
                [typeButton setHidden:YES];
                break;
            case 1:
                [typeButton setTitle:@"商家管理" forState:UIControlStateNormal];
                [typeButton setTitle:@"商家管理" forState:UIControlStateHighlighted];
                break;
            case 2:
                [typeButton setTitle:@"业务专属" forState:UIControlStateNormal];
                [typeButton setTitle:@"业务专属" forState:UIControlStateHighlighted];
                break;
            case 3:
                [typeButton setTitle:@"最高管理" forState:UIControlStateNormal];
                [typeButton setTitle:@"最高管理" forState:UIControlStateHighlighted];
                break;
                
            default:
                break;
        }
        
    }
  
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 //   NSLog(@"viewDidAppear is called");
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
