//
//  GarageViewController.m
//  234
//
//  Created by l on 8/1/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "GarageRegisterController.h"
#import "AppDelegate.h"
#import "Garage.h"

@implementation GarageRegisterController
@synthesize appDelegate;
@synthesize garageTel;
@synthesize garageContact,garageRegisterDate,garageValidateTime;
@synthesize garageBusiness;
@synthesize garageName;
@synthesize garageShortName;
@synthesize garageAddr;
@synthesize workerTel,scanGarageCodeBtn;

-(void)moveView:(NSInteger)dis
{
    [UIView animateWithDuration:0.5f animations:^{
        self.view.center=CGPointMake(self.view.center.x, self.view.center.y-dis);
    }];
}

-(IBAction)returnMainView:(id)sender
{
 //   UIView *mainView=appDelegate.navigationController.view;
 //   [UIView animateWithDuration:1.0 animations:^{
 //       mainView.center=CGPointMake(mainView.center.x+160, mainView.center.y);
 //   }];
    [appDelegate.leftNavigationController popViewControllerAnimated:YES];
}

-(IBAction)customGarageInfo:(id)sender{
    [self returnMainView:nil];
    appDelegate.garage.shortname=garageShortName.text;
}

-(IBAction)commitRegisterInfo:(id)sender
{
    [self returnMainView:sender];
    //check info.
    if ([garageName.text isEqualToString:@""] || [garageShortName.text isEqualToString:@""]||
        [garageTel.text isEqualToString:@""] || [garageContact.text isEqualToString:@""]||
        [garageAddr.text isEqualToString:@""] || [garageBusiness.text isEqualToString:@""]) {
        [appDelegate showNotification:@"填入注册必要信息！"];
    }
    if ([garageRegisterDate.text isEqualToString:@""] || [garageValidateTime.text isEqualToString:@""]) {
        [appDelegate showNotification:@"填入时间信息！"];
    }
    if ([scanGarageCodeBtn.text isEqualToString:@""] || [workerTel.text isEqualToString:@""]) {
        [appDelegate showNotification:@"填入身份认证信息！"];
    }
    
    
    //  commit register info
    NSString *password=@"";
    NSInteger validated_days=(NSInteger)([garageValidateTime.text intValue]*30);
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/garage_register.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"tel=%@&contact=%@&password=%@&name=%@&shortname=%@&addr=%@&business=%@&register_date=%@&validated_days=%lu&garage_code=%@&workerTel=%@",garageTel.text,garageContact.text,password,garageName.text,garageShortName.text,garageAddr.text,garageBusiness.text,garageRegisterDate.text,validated_days,scanGarageCodeBtn.text ,workerTel.text];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",[postData length]];
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
 //   [self moveView:-100];
    [garageName resignFirstResponder];
    [garageShortName resignFirstResponder];
    [garageTel resignFirstResponder];
    [garageAddr resignFirstResponder];
    [garageContact resignFirstResponder];
    [garageBusiness resignFirstResponder];
    [workerTel resignFirstResponder];
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    garageName.delegate=self;
//    UIBarButtonItem *finishBtn=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(returnMainView)];
    self.title=@"商家注册";
 //   self.navigationItem.rightBarButtonItem=finishBtn;
    
    //concerned version.
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
}

- (void)viewDidUnload
{
    [self setGarageTel:nil];
    [self setGarageContact:nil];
    [self setGarageName:nil];
    [self setGarageAddr:nil];
    [self setWorkerTel:nil];
    [self setGarageBusiness:nil];
    [self setGarageShortName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
     
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==garageName)
    {
        [self moveView:100];
    }
}



@end
