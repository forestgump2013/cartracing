//
//  CarOwnerRegisterViewController.h
//  234
//
//  Created by l on 3/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@class LoginViewController;

@interface CarOwnerRegisterViewController : UIViewController

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) LoginViewController *loginViewController;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITextField *password,*checkPassword,*owner;
@property(nonatomic,retain) IBOutlet UILabel *label1,*label2,*label3;
@property(nonatomic,retain) IBOutlet UIButton *button;
@property NSInteger flag;
-(IBAction)commitRegisterData:(id)sender;

-(void) setWithFlag:(NSInteger) f;

@end
