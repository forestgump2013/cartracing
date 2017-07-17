//
//  GarageViewController.h
//  234
//
//  Created by l on 8/1/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

@interface GarageRegisterController : UIViewController
<UITextFieldDelegate>
{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *garageTel;
@property (weak, nonatomic) IBOutlet UITextField *garageContact,*garageRegisterDate,*garageValidateTime;
@property (weak, nonatomic) IBOutlet UITextField *garageBusiness;
@property (weak, nonatomic) IBOutlet UITextField *garageName;
@property (weak, nonatomic) IBOutlet UITextField *garageShortName;
@property (weak, nonatomic) IBOutlet UITextField *garageAddr;
@property (weak, nonatomic) IBOutlet UITextField *workerTel;
@property(nonatomic,retain) IBOutlet UITextField *scanGarageCodeBtn;

-(IBAction)returnMainView:(id)sender ;
-(IBAction)commitRegisterInfo:(id)sender;
-(IBAction)customGarageInfo:(id)sender;
-(void) moveView:(NSInteger) dis;

@end
