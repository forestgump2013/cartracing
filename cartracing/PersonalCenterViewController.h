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
@class ForumViewController;
@class HelpViewController;
@class OwnerConcernedViewController;
@class PartnerManageViewController;
@class GarageManageViewController;
@class CarManageViewController;
@class LoginViewController;
@class CarOwnerRegisterViewController;
@class PeccancyViewController;
@class SetViewController;

@interface PersonalCenterViewController : UIViewController
{
    AppDelegate *appDelegate;
    CallBackViewController *callBackViewController;
    GarageManageViewController *garageManageViewController;
    
    NSInteger viewType;
}

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) CallBackViewController *callBackViewController;
@property(nonatomic,retain) ForumViewController *forumViewController;
@property(nonatomic,retain) HelpViewController *helpViewController;
@property(nonatomic,retain) PeccancyViewController *peccancyViewController;
@property(nonatomic,retain) OwnerConcernedViewController *ownerViewController;
@property(nonatomic,retain) PartnerManageViewController *partnerViewController;
@property(nonatomic,retain) GarageManageViewController *garageManageViewController;
@property(nonatomic,retain) CarManageViewController *carManageViewController;
@property(nonatomic,retain) LoginViewController *loginViewController;
@property(nonatomic,retain) CarOwnerRegisterViewController *carOwnerRegisterViewController;
@property(nonatomic,retain) SetViewController *setViewController;
@property(nonatomic,retain) UIView *loginView,*modifyPasswordView,*shareView;
@property(nonatomic,retain) IBOutlet UIButton *carManagerBtn,*setBtn,*callBackBtn,*helpBtn;
@property NSInteger viewType;
@property (strong, nonatomic) IBOutlet UIButton *typeButton;
@property(nonatomic,retain) IBOutlet UIImageView *carCloudImage;

-(void) leftOutMainView;
-(void) returnMainView;
//-(void) returnFro;
-(IBAction)loadCarManagementView:(id)sender;
-(IBAction)loadSetView:(id)sender;
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
