//
//  OwnerConcernedViewController.h
//  cartracing
//
//  Created by l on 10/16/15.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class AppDelegate;
@class GarageSuggestViewController;
@class Garage;
@class YLSTextField;
@class QRCodeReaderView;

@interface OwnerConcernedViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate>
{
    UIBarButtonItem *editBtn;
    QRCodeReaderView *qrCodeReaderView;
    CGFloat screenWidth,ScreenHeight;
}

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) GarageSuggestViewController *garageSuggestViewController;
@property(nonatomic,retain) NSMutableArray *myGarages;
@property(nonatomic,retain) IBOutlet UITableView *garageTable;
@property(nonatomic,retain)  YLSTextField *addedGarageNum;
@property(nonatomic,retain) IBOutlet UIButton *addBtn;
@property(nonatomic,retain) UIAlertView *myAlertView;

//concerned scancode
@property ( nonatomic,retain  ) AVCaptureDevice * device;
@property ( nonatomic,retain  ) AVCaptureDeviceInput * input;
@property ( nonatomic,retain ) AVCaptureMetadataOutput * output;
@property ( nonatomic,retain  ) AVCaptureSession * session;
@property ( nonatomic,retain  ) AVCaptureVideoPreviewLayer * preview;

-(void)editTable;
-(void) loadData:(NSMutableArray *) data;

-(void)addGarage:(Garage*)garage;
-(void) deleteGarage:(Garage*)garage;
-(void) scanQRCode;

@end
