//
//  LoginViewController.h
//  234
//
//  Created by l on 8/4/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@class CarOwnerRegisterViewController;

@interface LoginViewController : UIViewController
{
    UIView *registerView;
    AppDelegate *appDelegate;
    NSInteger waitLevel;
    NSString *ownerTel;
    NSLock *lock;
}
@property (weak, nonatomic) IBOutlet UITextField *owner;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *rTel;
@property (weak, nonatomic) IBOutlet UITextField *rPassword;
@property (weak, nonatomic) IBOutlet UITextField *rGarage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *msgBoard;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) AppDelegate *appDelegate;
//@property(nonatomic,retain) UINavigationController *container;
@property(nonatomic,retain) CarOwnerRegisterViewController *carOwnerRegisterViewController;

-(IBAction)login:(id)sender;
-(BOOL) checkIdentification;
-(void)getCloudData;
-(void) dealWithData;
-(void)getMaintainInfo;
-(void) getmaintainRecordInfo;
-(void)getFuelingInfo;
-(void)getRespairInfo;
-(IBAction)registerView:(id)sender;
-(IBAction)forgetPasswordView:(id)sender;
-(IBAction)finishRegister:(id)sender;
-(IBAction)testUse:(id)sender;
-(IBAction)popMyself:(id)sender;
-(void) getYourPassword:(NSString*)pass Owner:(NSString*) yourTel;
-(void) getCarInfo;
-(void) waitWait;
@end
