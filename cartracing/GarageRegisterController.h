//
//  GarageViewController.h
//  234
//
//  Created by l on 8/1/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class AppDelegate;

@interface GarageRegisterController : UIViewController
<UITextFieldDelegate,AVCaptureMetadataOutputObjectsDelegate>
{
 //   AppDelegate *appDelegate;
    NSArray *payModes;
}
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *garageTel;
@property (weak, nonatomic) IBOutlet UITextField *garageContact,*garageRegisterDate,*garageValidateTime;
@property (weak, nonatomic) IBOutlet UITextField *garageBusiness,*garagePayCost;
@property(nonatomic,retain) IBOutlet UIButton *garagePayMode;
@property (weak, nonatomic) IBOutlet UITextField *garageName;
@property (weak, nonatomic) IBOutlet UITextField *garageShortName;
@property (weak, nonatomic) IBOutlet UITextField *garageAddr;
@property (weak, nonatomic) IBOutlet UITextField *workerTel;
@property(nonatomic,retain) IBOutlet UITextField *scanGarageCodeBtn,*garageIntroducer;
@property(nonatomic,retain)  NSDateFormatter *dateFormatter;
@property(nonatomic,retain) IBOutlet UIDatePicker *datePicker;

//concerned scancode
@property ( nonatomic,retain  ) AVCaptureDevice * device;
@property ( nonatomic,retain  ) AVCaptureDeviceInput * input;
@property ( nonatomic,retain ) AVCaptureMetadataOutput * output;
@property ( nonatomic,retain  ) AVCaptureSession * session;
@property ( nonatomic,retain  ) AVCaptureVideoPreviewLayer * preview;

-(IBAction)returnMainView:(id)sender ;
-(IBAction)showPayModes:(id)sender;
-(void)commitRegisterInfo;
-(IBAction)takeOffKeyboard:(id)sender;
-(IBAction)customGarageInfo:(id)sender;
-(void) moveView:(NSInteger) dis;
-(void) dateChange;

@end
