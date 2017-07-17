//
//  CarOwnerRegisterViewController.m
//  234
//
//  Created by l on 3/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CarOwnerRegisterViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TracingCarViewController.h"
@implementation CarOwnerRegisterViewController
@synthesize scrollView,appDelegate,loginViewController, password,checkPassword,owner,label1,label2,label3,flag,button;


-(void)setWithFlag:(NSInteger)f
{
    flag=f;
    if (flag==1) {
        [label1 setText:@"账号"];
        [label2 setText:@"密码"];
    } else if(flag==0){
        [label1 setText:@"旧密码"];
        [label2 setText:@"新密码"];
    }
    
    
    
}

-(IBAction)commitRegisterData:(id)sender{
    
    
    [owner resignFirstResponder];
    [password resignFirstResponder];
    [checkPassword resignFirstResponder];
    if (flag==0) {
        if ([owner.text isEqualToString:@""]) {
            [appDelegate showNotification:@"账号为空！"];
            return;
        }
        if ([password.text isEqualToString:@""]) {
            [appDelegate showNotification:@"密码为空！"];
            return;
        }
        if (![password.text isEqualToString:[checkPassword text]]) {
            [appDelegate showNotification:@"密码不一致！"];
            return;
        }
        //commit register info .
         NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/owner_register.php"];
         NSString *post=nil;
         post=[NSString stringWithFormat:@"Tel=%@&Password=%@&Garage=%@&mac=%@",owner.text,password.text,@"汽车云管理",owner.text];
         NSLog(@"post:%@",post);
         NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
         NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
     //    NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"post register data  successful");
             dispatch_async(dispatch_get_main_queue(), ^{
              [appDelegate loginWithTel:owner.text Type:0 Garage:nil];
              [appDelegate.tracingCarViewController showRegisterNewCar];
              [appDelegate.navigationController popViewControllerAnimated:NO];
              [appDelegate.navigationController popViewControllerAnimated:YES];
          });
             
         
         }
         else NSLog(@"post error!");
         }];
        
        return;
    }
    if (flag==1) {
        if ([owner.text isEqualToString:@""]) {
            [appDelegate showNotification:@"旧密码为空！"];
            return;
        }
        if ([password.text isEqualToString:@""]) {
            [appDelegate showNotification:@"新密码为空！"];
            return;
        }
        if (![password.text isEqualToString:[checkPassword text]]) {
            [appDelegate showNotification:@"新设密码不一致！"];
            return;
        }
        if ([password.text isEqualToString:[owner text]]) {
            [appDelegate showNotification:@"新旧密码相同！"];
            return;
        }
        
        
        //commit new password.
        NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/updateOwnerPassword.php"];
        NSString *post=nil;
        post=[NSString stringWithFormat:@"tel=%@&password=%@&old_password=%@",appDelegate.ownerTel,password.text,owner.text];
        NSLog(@"post:%@",post);
        NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
                NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"update password result:%@",reponseString);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([reponseString integerValue]==1) {
                        [button setTitle:@"更新成功" forState:UIControlStateNormal];
                    } else [button setTitle:@"更新失败" forState:UIControlStateNormal];
                    
                });
                
        
            }}];
        
        
        return;
    }
    
    
    if (flag==2) {
        
        if ([owner.text isEqualToString:@""]) {
            [appDelegate showNotification:@"账号为空！"];
            return;
        }
        if ([password.text isEqualToString:@""]) {
            [appDelegate showNotification:@"车牌号为空！"];
            return;
        }
        NSMutableString *carLicense= [[NSMutableString alloc] initWithString:password.text] ;
        [carLicense insertString:@"·" atIndex:2];
        // commit check info.
        NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/forget_password.php"];
        NSString *post=nil;
        post=[NSString stringWithFormat:@"tel=%@&license=%@",owner.text,carLicense];
        NSLog(@"post:%@",post);
        NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
                NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSString *yourPassword;
                if (![reponseString isEqualToString:@""]) {
                    yourPassword=[reponseString substringFromIndex:25];
                    yourPassword=[yourPassword substringToIndex:yourPassword.length-3];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [appDelegate.loginViewController getYourPassword:yourPassword Owner:owner.text];
                        [appDelegate.navigationController popViewControllerAnimated:NO];
                    });
                    
                } else{
                    [appDelegate showNotification:@"验证信息有误！"];
                    return ;
                }
                NSLog(@"post check info successful res:%@,yourPassword:%@",reponseString,yourPassword);
                /*
                id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if(jsonObject==nil)
                {
                    
                }
          //      NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
                NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
                NSDictionary *dictionary;
                
          //      NSLog(@"cloud fueling count %ld",[arr count]);
                for(int i=0;i<[arr count]; i++)
                {
                    dictionary=[arr objectAtIndex:i];
                    yourPassword=[dictionary objectForKey:@"password"];
                 
           //         [appDelegate showNotification:[NSString stringWithFormat:@"你的密码%@",yourPassword]];
                 
          //          [appDelegate.navigationController popViewControllerAnimated:YES];
                    break;
                
                } */
                
                
                
            }
            else NSLog(@"post forget_password.php error!");
        }];
        
        
        
        
        
        return;
    }
    
    
    
    
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

-(void)viewDidLayoutSubviews
{
    [scrollView setContentSize:CGSizeMake(appDelegate.screenWidth , 600)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [self.view setTintColor:[UIColor whiteColor]];
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
    

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //details
    switch (flag) {
        case 0:
            [self setTitle:@"注册"];
            [password setSecureTextEntry:YES];
            [checkPassword setSecureTextEntry:YES];
            break;
        case 1:
            [label1 setText:@"旧密码"];
            [label2 setText:@"新密码"];
            [self setTitle:@"更改密码"];
            break;
        case 2:
            [label2 setText:@"车牌号"];
         //   password.text=@"京W00002";
            [password setSecureTextEntry:YES];
            [label3 setHidden:YES];
            [checkPassword setHidden:YES];
            [self setTitle:@"忘记密码"];
            break;
            
        default:
            break;
    }
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
    
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

@end
