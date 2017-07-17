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
#import "SpinnerViewController.h"
#import "TracingCarViewController.h"
//.#import "MyQuartzView.h"
#import "PartnerManageViewController.h"

@implementation GarageRegisterController
@synthesize appDelegate;
@synthesize garageTel,scrollView;
@synthesize garageContact,garageRegisterDate,garageValidateTime;
@synthesize garageBusiness,garagePayCost,garagePayMode;
@synthesize garageName;
@synthesize garageShortName;
@synthesize garageAddr;
@synthesize workerTel,scanGarageCodeBtn,garageIntroducer;

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
    if (![garageShortName.text isEqualToString:@""]) {
       
          appDelegate.customGarage.shortname=garageShortName.text;
    }
    if (![garageName.text isEqualToString:@""]) {
        appDelegate.customGarage.name=garageName.text;
    }
    
    if (![garageBusiness.text isEqualToString:@""]) {
         NSLog(@"gaga besi");
        appDelegate.customGarage.business=garageBusiness.text;
    }
    
    if (![garageContact.text isEqualToString:@""]) {
        appDelegate.customGarage.contact=garageContact.text;
    }
    
    if (![garageAddr.text isEqualToString:@""]) {
        appDelegate.customGarage.addr=garageAddr.text;
    }
    
    if (![garageTel.text isEqualToString:@""]) {
        appDelegate.customGarage.tel=garageTel.text;
    }
  
    [appDelegate.tracingCarViewController temporaryCustomGarage];
}

-(IBAction)takeOffKeyboard:(id)sender
{
    [garageName resignFirstResponder];
    [garageShortName resignFirstResponder];
    [garageTel resignFirstResponder];
    [garageAddr resignFirstResponder];
    [garageContact resignFirstResponder];
    [garageBusiness resignFirstResponder];
    [workerTel resignFirstResponder];
    [garageRegisterDate resignFirstResponder];
    [garageValidateTime resignFirstResponder];
    [scanGarageCodeBtn resignFirstResponder];
    [garagePayCost resignFirstResponder];
   // [garagePayMode resignFirstResponder];
    [garageIntroducer resignFirstResponder];
    [appDelegate takeOffSpinnerView];
}

-(void) addUncheckedGarage:(Garage*)garage
{
    PartnerManageViewController *topViewController=(PartnerManageViewController*)[appDelegate.leftNavigationController topViewController];
    [topViewController addUnCheckedGarage:garage];
}

-(void)commitRegisterInfo
{
    [self returnMainView:nil];
    //check info.
    if ([garageName.text isEqualToString:@""] || [garageShortName.text isEqualToString:@""]||
        [garageTel.text isEqualToString:@""] || [garageContact.text isEqualToString:@""]||
        [garageAddr.text isEqualToString:@""] || [garageBusiness.text isEqualToString:@""]) {
        [appDelegate showNotification:@"填入注册必要信息！"];
        return;
    }
    if ([garageRegisterDate.text isEqualToString:@""] || [garageValidateTime.text isEqualToString:@""]) {
        [appDelegate showNotification:@"填入时间信息！"];
        return;
    }
    if ([garagePayCost.text isEqualToString:@""] ) {
        [appDelegate showNotification:@"填入金额信息！"];
        return;
    }
    if ([scanGarageCodeBtn.text isEqualToString:@""] || [workerTel.text isEqualToString:@""]) {
        [appDelegate showNotification:@"填入身份认证信息！"];
        return;
    }
    
    
    //  commit register info
    NSString *password=@"";
    password=[scanGarageCodeBtn.text substringFromIndex:scanGarageCodeBtn.text.length-4];
    NSInteger validated_days=(NSInteger)([garageValidateTime.text intValue]*30);
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/garage_register.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"tel=%@&contact=%@&password=%@&name=%@&shortname=%@&addr=%@&business=%@&register_date=%@&validated_days=%d&garage_code=%@&workerTel=%@&level=%@&pay_cost=%@&pay_mode=%@&introducer=%@",garageTel.text,garageContact.text,password,garageName.text,garageShortName.text,garageAddr.text,garageBusiness.text,garageRegisterDate.text,(int)validated_days,scanGarageCodeBtn.text ,workerTel.text,@"1",garagePayCost.text,garagePayMode.titleLabel.text,garageIntroducer.text];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
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
            NSLog(@"garage_register post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"garage_register response:%@",reponseString);
            Garage *garage=[[Garage alloc] initWithShortName:garageShortName.text Name:garageName.text Tel:garageTel.text Contact:garageContact.text Business:garageBusiness.text Addr:garageAddr.text Flag:1];
            [self addUncheckedGarage:garage];
            
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
    [garageRegisterDate resignFirstResponder];
    [garageValidateTime resignFirstResponder];
    [scanGarageCodeBtn resignFirstResponder];
    [garagePayCost resignFirstResponder];
  //  [garagePayMode resignFirstResponder];
    [garageIntroducer resignFirstResponder];
}

-(void)dateChange
{
    [garageRegisterDate setText:[_dateFormatter stringFromDate:_datePicker.date]];
}

-(IBAction)showPayModes:(id)sender
{
    [appDelegate.spinnerView initWithData:payModes Frame:CGRectMake(garagePayMode.frame.origin.x, garagePayMode.frame.origin.y, 80, 45*[payModes count]) Button:garagePayMode];
    [appDelegate showSpinnerView];
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
    
    //----------------------------
    UIBarButtonItem *commitBtn=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitRegisterInfo)];
    [self.navigationItem setRightBarButtonItem:commitBtn];
    
    [_datePicker addTarget:self action:@selector(dateChange) forControlEvents:UIControlEventValueChanged];
    _dateFormatter=[[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"YYYY/MM/dd"];
    [garageRegisterDate setInputView:_datePicker];
    [garageRegisterDate setText:[_dateFormatter stringFromDate:[NSDate date]]];
    [garageName setTintColor:[UIColor whiteColor]];
    [garageShortName setTintColor:[UIColor whiteColor]];
    payModes=[[NSArray alloc] initWithObjects:@"现金",@"网银", nil];
    //-------------
    UIButton *scanBtn=[[UIButton alloc] initWithFrame:CGRectMake(5,0, 30, 30)];
    [scanBtn setBackgroundImage:[UIImage imageNamed:@"scan_mark.png"] forState:UIControlStateNormal];
    [scanBtn setBackgroundImage:[UIImage imageNamed:@"scan_mark.png"] forState:UIControlStateHighlighted];
    //   [scanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [scanBtn.titleLabel setText:@""];
    [scanBtn addTarget:self action:@selector(initScanDevice) forControlEvents:UIControlEventTouchUpInside];
    [scanGarageCodeBtn setLeftView:scanBtn];
    [scanGarageCodeBtn setLeftViewMode:UITextFieldViewModeAlways];
    
    /*  UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initScanDevice)];
       [doubleTap setNumberOfTapsRequired:2];
      [doubleTap setNumberOfTouchesRequired:1];
    
       [scanGarageCodeBtn addGestureRecognizer:doubleTap]; */
 //   [scrollView setContentSize:CGSizeMake(appDelegate.screenWidth, appDelegate.screenHeight+400)];
    NSLog(@"***scrollview contentsize:%f,%f",scrollView.contentSize.width,scrollView.contentSize.height);
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  //  [scrollView setContentSize:CGSizeMake(appDelegate.screenWidth, appDelegate.screenHeight+400)];
   // [scrollView setContentOffset:CGPointMake(0, 0)];
 
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   //    [self initPlaceHolder];
}

-(void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [scrollView setContentSize:CGSizeMake(appDelegate.screenWidth, appDelegate.screenHeight+400)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [appDelegate takeOffSpinnerView];
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
    /*
    if(textField==garageName)
    {
        [self moveView:100];
    }
    */
}

-(void) initScanDevice
{
    [scanGarageCodeBtn resignFirstResponder];
    //-----concerned code scan.
    // Device
    _device = [ AVCaptureDevice defaultDeviceWithMediaType : AVMediaTypeVideo ];
    // Input
    _input = [ AVCaptureDeviceInput deviceInputWithDevice : self . device error : nil ];
    // Output
    _output = [[ AVCaptureMetadataOutput alloc ] init ];
    
    [ _output setMetadataObjectsDelegate : self queue : dispatch_get_main_queue ()];
  //  CGFloat screenHeight=self.view.bounds.size.height;
  //  CGFloat screenWidth=self.view.bounds.size.width;
    //  output.rectOfInterest=CGRectMake(124/screenHeight, (screenWidth-220)/2/screenWidth, 220/screenHeight , 220/screenWidth);
    
    // Session
    _session = [[ AVCaptureSession alloc ] init ];
    [ _session setSessionPreset : AVCaptureSessionPresetHigh ];
    
    if ([ _session canAddInput : _input ])
    {
        [ _session addInput : _input ];
    }
    
    if ([ _session canAddOutput : _output ])
    {
        [ _session addOutput : _output];
    }
    
    [self checkAVAuthorizationStatus];
    //  output.rectOfInterest=CGRectMake(124/screenHeight, (screenWidth-220)/2/screenWidth, 220/screenHeight , 220/screenWidth);
    
    // Preview
    _preview =[ AVCaptureVideoPreviewLayer layerWithSession : _session ];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    _preview.frame = self.view .layer.bounds ;
    //  [ self.view.layer insertSublayer : _preview atIndex : 0 ];
    [self.view.layer addSublayer:_preview];
   
 //   CGRect rect = CGRectMake(40, 100,  appDelegate.screenWidth - 80, appDelegate.screenWidth - 80);
   
   // CGRect intertRect=[_preview metadataOutputRectOfInterestForRect:rect];
  //  CGRect layerRect=[_preview rectForMetadataOutputRectOfInterest:intertRect];
    //  NSLog(@"%@,  %@",NSStringFromCGRect(rect1),NSStringFromCGRect(layerRect));
  //  _output.rectOfInterest=intertRect;
    

    
 //   [self.view addSubview:appDelegate.myQuartzView];
    [appDelegate  startScanQRCode];
  
    
    [_session startRunning ];
}

- (void)checkAVAuthorizationStatus
{    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    NSString *tips = NSLocalizedString(@"AVAuthorization", @"您没有权限访问相机");
    if(status == AVAuthorizationStatusAuthorized) {
        // authorized        [self setupCamera];
        
        // 条码类型 AVMetadataObjectTypeQRCode
        
        //  output.metadataObjectTypes = @[ AVMetadataObjectTypeQRCode ] ;
        [_output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
        
        
    } else {
        NSLog(@"%@",tips);
        //[SVProgressHUD showWithStatus:tips];
        [appDelegate showNotification:tips];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
-(void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count ] > 0 )
        
    {
        // 停止扫描
        [_session stopRunning ];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        stringValue = metadataObject. stringValue ;
        [scanGarageCodeBtn setText:stringValue];
        [appDelegate stopScan];
        [_preview removeFromSuperlayer];
        
    }
}

-(void) initPlaceHolder
{
    /*
      NSLog(@" ****  fondationVersionNumber %f",floor(NSFoundationVersionNumber));
    
    if (floor(NSFoundationVersionNumber)<NSFoundationVersionNumber10_9){
        return;
    } */
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"联系人" attributes:dict];
    [garageContact setAttributedPlaceholder:attribute];
    
    NSAttributedString *attribute1 = [[NSAttributedString alloc] initWithString:@"有效期  月" attributes:dict];
    [garageValidateTime setAttributedPlaceholder:attribute1];
    
    NSAttributedString *attribute2=[[NSAttributedString alloc] initWithString:@"业务员" attributes:dict];
    [workerTel setAttributedPlaceholder:attribute2];
    
    
  //  [garageContact setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}




@end
