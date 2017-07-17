//
//  PersonalCenterViewController.h
//  234
//
//  Created by l on 14-7-20.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@class CallBackViewController;
@class HelpViewController;
@class PartnerManageViewController;
@class GarageManageViewController;
@class CarManageViewController;
@class LoginViewController;
@class CarOwnerRegisterViewController;

@interface PersonalCenterViewController : UIViewController
{
    AppDelegate *appDelegate;
    CallBackViewController *callBackViewController;
    GarageManageViewController *garageManageViewController;
    
    NSInteger viewType;
}

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) CallBackViewController *callBackViewController;
@property(nonatomic,retain) HelpViewController *helpViewController;
@property(nonatomic,retain) PartnerManageViewController *partnerViewController;
@property(nonatomic,retain) GarageManageViewController *garageManageViewController;
@property(nonatomic,retain) CarManageViewController *carManageViewController;
@property(nonatomic,retain) LoginViewController *loginViewController;
@property(nonatomic,retain) CarOwnerRegisterViewController *carOwnerRegisterViewController;
@property(nonatomic,retain) UIView *loginView,*modifyPasswordView;
@property(nonatomic,retain) IBOutlet UIButton *carManagerBtn,*loginBtn,*callBackBtn,*helpBtn,*unloginBtn,*shareBtn;
@property NSInteger viewType;
@property (strong, nonatomic) IBOutlet UIButton *typeButton;
@property(nonatomic,retain) IBOutlet UIImageView *carCloudImage;

-(void) leftOutMainView;
-(void) returnMainView;
//-(void) returnFro;
-(IBAction)loadCarManagementView:(id)sender;
-(IBAction)postInfo:(id)sender;
-(IBAction)loadCallBackView:(id)sender;
-(IBAction)loadHelpView:(id)sender;
-(IBAction)shareInfo:(id)sender;
-(IBAction)loadLoginView:(id)sender;
-(IBAction)unLogin:(id)sender;
-(IBAction)typeFunction:(id)sender;

-(IBAction)loadGarageManageView:(id)sender;

-(void) postCarInfo;
-(void) postMaintainInfo;
-(void) postFuelingInfo;
-(void) postRespairInfo;
-(void) updateView;

@end
