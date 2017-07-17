//
//  OwnerConcernedViewController.m
//  cartracing
//
//  Created by l on 10/16/15.
//
//

#import "OwnerConcernedViewController.h"
#import "Garage.h"
#import "AppDelegate.h"
#import "GarageSuggestViewController.h"
#import "YLSTextField.h"
//#import "MyQuartzView.h"
//#import "QRCodeReaderView.h"

@interface OwnerConcernedViewController ()

@end

@implementation OwnerConcernedViewController

@synthesize myGarages,garageTable,addBtn,appDelegate,addedGarageNum,myAlertView;
@synthesize output;

-(void)editTable
{
    [garageTable setEditing:!garageTable.editing];
    [addedGarageNum setEnabled:!addedGarageNum.enabled];
    if (addedGarageNum.enabled) {
        [addedGarageNum becomeFirstResponder];
        [editBtn setTitle:@"完成"];
    }else [editBtn setTitle:@"编辑"];
}

-(void)scanQRCode
{
    NSLog(@"scanQRCode is called!");
    // Start
    if (addedGarageNum.enabled) {
        [appDelegate showNotification:@"扫描"];
        [addedGarageNum resignFirstResponder];
        /*
        dispatch_async(dispatch_get_main_queue(), ^{
              [self initScanDevice];
        });*/
      //  [ self setupCapture];
        [self initScanDevice];
      
     //  [ _session startRunning ];
    }
}

-(void) loadData:(NSMutableArray *)data
{
    myGarages=data;
    
    NSLog(@"loadData garages%ld",[myGarages count]);
    [garageTable reloadData];
    
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
  //  myGarages=[NSMutableArray array];
    [self setTitle:@"我的汽修"];
    
    
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    _garageSuggestViewController=[[GarageSuggestViewController alloc] initWithNibName:@"GarageSuggestViewController" bundle:nil];
    // [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    editBtn=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editTable)];
    [self.navigationItem setRightBarButtonItem:editBtn];
    
    myAlertView=[[UIAlertView alloc] initWithTitle:@"添加新汽修" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
  //  qrCodeReaderView=[[QRCodeReaderView alloc] initWithFrame:<#(CGRect)#>]
  //  Garage *garage1=[[Garage alloc] initWithName:@"test1" Tel:@"111" Addr:@"bbb"];
  //  [myGarages addObject:garage1];
    
    [garageTable setBackgroundColor:[UIColor clearColor]];
    UIView *tableFootView=[[UIView alloc] init];
    [tableFootView setBackgroundColor:[UIColor clearColor]];
    tableFootView.layer.masksToBounds=YES;
    tableFootView.layer.cornerRadius=5.0f;
    [garageTable setTableFooterView:tableFootView];
    [garageTable setTableHeaderView:tableFootView];
 //   [garageTable setDataSource:self];
 //   [garageTable setDelegate:self];
 //   NSLog(@"owner view view didload is called");
  //  [garageTable reloadData];
  //  [self initScanDevice];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([garageTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [garageTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([garageTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [garageTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma table methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==garageTable) {
        NSLog(@"table numberOfRowsInSection is called %ld",[myGarages count]);
        return [myGarages count]+1;
    } return 0;
    
   // return [appDelegate.directRelatedGarages count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row;
    Garage *garage;
    NSString *identifier;
    identifier=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==Nil) {
        //  cell=[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    row=[indexPath row];
    if (row==0) {
        if (addedGarageNum==nil) {
            addedGarageNum=[[YLSTextField alloc] initWithFrame:CGRectMake(2, 2, cell.contentView.frame.size.width-40, cell.contentView.frame.size.height-4)];
            [addedGarageNum setBackgroundColor:[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f]];
            [addedGarageNum setPlaceholder:@"新汽修"];
            [addedGarageNum setBorderStyle:UITextBorderStyleRoundedRect];
            [addedGarageNum setKeyboardType:UIKeyboardTypeNumberPad];
            [addedGarageNum setEnabled:false];
            [addedGarageNum setTextColor:[UIColor whiteColor]];
          //  [addedGarageNum setTintColor:[UIColor whiteColor]];
            
      //      UIImageView *scanMarkView=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
      //      [scanMarkView setImage:[UIImage imageNamed:@"redcolor_btn.png"]];
            
            UIButton *scanBtn=[[UIButton alloc] initWithFrame:CGRectMake(5,0, 32, 32)];
            [scanBtn setBackgroundImage:[UIImage imageNamed:@"scan_mark.png"] forState:UIControlStateNormal];
             [scanBtn setBackgroundImage:[UIImage imageNamed:@"scan_mark.png"] forState:UIControlStateHighlighted];
         //   [scanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [scanBtn.titleLabel setText:@""];
            [scanBtn addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
            [addedGarageNum setLeftView:scanBtn];
            
            [addedGarageNum setLeftViewMode:UITextFieldViewModeAlways];
            //--------
            /*
            for (int i = (int)[addedGarageNum.gestureRecognizers count] - 1; i >= 0; --i)
            {
                [addedGarageNum removeGestureRecognizer:[addedGarageNum.gestureRecognizers objectAtIndex:i]];
            } */
         //   UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanQRCode)];
         //   [doubleTap setNumberOfTapsRequired:1];
        //    [scanMarkView addGestureRecognizer:doubleTap];
        }
        [cell.contentView addSubview:addedGarageNum];
        return cell;
    }
    garage=[myGarages objectAtIndex:row-1];
    [cell.textLabel setText:garage.name];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    NSLog(@"owner concerned garage %@",garage.name);
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
   // [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}


 -(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     NSInteger row=[indexPath row];
     if (row==0) {
         return UITableViewCellEditingStyleInsert;
     } else return UITableViewCellEditingStyleDelete; //UITableViewCellEditingStyleDelete;
     
 }

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if (row==0) {
        if ([addedGarageNum.text isEqualToString:@""]) {
            [appDelegate showNotification:@"输入汽修ID!"];
        }else{
            [myAlertView setTag:row];
            [myAlertView setTitle:@"添加汽修"];
            [myAlertView setMessage:[[NSString alloc] initWithFormat:@"汽修ID:%@",addedGarageNum.text]];
            [myAlertView show];
        }
    }else {
        Garage *garage=[myGarages objectAtIndex:row-1];
        
        [myAlertView setTag:row];
        [myAlertView setTitle:@"删除汽修"];
        [myAlertView setMessage:garage.shortname];
        [myAlertView show];
    }
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if (row==0) {
        return;
    }
    [appDelegate.leftNavigationController pushViewController:_garageSuggestViewController animated:YES];
    Garage *garage=[myGarages objectAtIndex:(row-1)];
    [_garageSuggestViewController setOwner:appDelegate.ownerTel Garage:garage.id_code];
}

-(void)addGarage:(Garage *)garage{
    
 //   NSString *garageId=addedGarageNum.text;//oneGarageNum.text;
 //   if ([garageId isEqualToString:@""]) {
 //       return;
  //  }
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/owner_add_garage.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"tel=%@&garage=%@",appDelegate.ownerTel ,garage.id_code];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
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
            NSLog(@"owner_add_garage  post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"get data:%@",reponseString);
            [appDelegate.relatedGarages insertObject:garage atIndex:[appDelegate.directRelatedGarages count]];
            [appDelegate.directRelatedGarages addObject:garage];
            
            dispatch_async(dispatch_get_main_queue(),^{
                [garageTable reloadData];
            });
            [appDelegate hideActivityViewIndicator];
            [appDelegate showNotification:@"添加成功!"];
        }
        else{
            NSLog(@"owner_add_garage post error!");
            [appDelegate hideActivityViewIndicator];
            [appDelegate showNotification:@"网络异常!"];
        }
    }];
    
  //  [oneGarageNum resignFirstResponder];

}

-(void)deleteGarage:(Garage *)garage
{
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/owner_delete_garage.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"tel=%@&garage=%@",appDelegate.ownerTel ,garage.id_code];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
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
            NSLog(@"owner_delete_garage  post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"get data:%@",reponseString);
        //    [appDelegate.relatedGarages insertObject:garage atIndex:[appDelegate.directRelatedGarages count]];
            [appDelegate.relatedGarages removeObject:garage];
        //    [appDelegate.directRelatedGarages addObject:garage];
            [appDelegate.directRelatedGarages removeObject:garage];
            dispatch_async(dispatch_get_main_queue(),^{
                [garageTable reloadData];
            });
            [appDelegate hideActivityViewIndicator];
            [appDelegate showNotification:@"删除完成!"];
        }
        else{
            NSLog(@"owner_delete_garage post error!");
            [appDelegate hideActivityViewIndicator];
            [appDelegate showNotification:@"网络异常!"];
        }
    }];
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self editTable];
        [addedGarageNum resignFirstResponder];
        [addedGarageNum setText:@""];
    } else if (buttonIndex==1) {
        [appDelegate showActivityViewIndicator];
        NSInteger row=myAlertView.tag;
        if (row>0) {
            Garage *garage=[myGarages objectAtIndex:row-1];
            [self deleteGarage:garage];
        } else{
            [self getNewGarageInfo];
        }
        //---
        [self editTable];
        [addedGarageNum resignFirstResponder];
        [addedGarageNum setText:@""];
    }
}

-(void)getNewGarageInfo;
{
    //get new garage info and refresh view.
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getGarageInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"id=%@",addedGarageNum.text];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
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
            
            NSLog(@"getGarageInfo post successful,result:%@",reponseString);
            if ([appDelegate stringIsNull:reponseString]) {
                NSLog(@"invalided garage id!");
                [appDelegate hideActivityViewIndicator];
                [appDelegate showNotification:@"无效的汽修ID!"];
                return ;
            }
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            
            NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
            NSDictionary *dictionary;
            NSString *garageId,*name,*shortname,*tel,*contact,*addr,*business;
            Garage *aGarage;
            //   NSLog(@"count %d:%d",[array count],[arr count]);
            for(int i=0;i<[arr count]; )
            {
                dictionary=[arr objectAtIndex:i];
                garageId=[dictionary objectForKey:@"id"];
                name=[dictionary objectForKey:@"name"];
                shortname=[dictionary objectForKey:@"shortname"];
                tel=[dictionary objectForKey:@"tel"];
                contact=[dictionary objectForKey:@"contact"];
                addr=[dictionary objectForKey:@"addr"];
                business=[dictionary objectForKey:@"business"];
                aGarage=[[Garage alloc] initWithShortName:shortname Name:name Tel:tel Contact:contact Business:business Addr:addr Flag:1];
                aGarage.id_code=garageId;
                break;
                
            }
            
            NSLog(@"get added garage info :%@",aGarage.name);
            [self addGarage:aGarage];
            /*
             //add new garge info
             [appDelegate.relatedGarages insertObject:aGarage atIndex:[appDelegate.directRelatedGarages count]];
             [appDelegate.directRelatedGarages addObject:aGarage];
             [self addGarage:nil];
             
             dispatch_async(dispatch_get_main_queue(),^{
             // [garageTitle setText:selfInfo.name];
             });
             */
        }
        else{
            NSLog(@"getGarageInfo post error!");
            [appDelegate hideActivityViewIndicator];
            [appDelegate showNotification:@"网络异常!"];
        }
    }];
    
}

- (void)setupCapture {
    dispatch_async(dispatch_get_main_queue(), ^{
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error;
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (deviceInput) {
            [session addInput:deviceInput];
            
            AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [session addOutput:metadataOutput]; // 这行代码要在设置 metadataObjectTypes 前
            metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
            
            AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            previewLayer.frame = self.view.frame;
            [self.view.layer insertSublayer:previewLayer atIndex:0];
            
     //       __weak typeof(self) weakSelf = self;
            [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                              object:nil
                                                               queue:[NSOperationQueue currentQueue]
                                                          usingBlock: ^(NSNotification *_Nonnull ) {
                                                              screenWidth=appDelegate.screenWidth;
                                                              CGRect rect = CGRectMake(40, 80, screenWidth - 80, screenWidth - 80);
                                                              //  CGRect rect1=CGRectMake(124/screenHeight, (screenWidth-220)/2/screenWidth, 220/screenHeight , 220/screenWidth);
                                                              CGRect intertRect=[previewLayer metadataOutputRectOfInterestForRect:rect];
                                                              CGRect layerRect=[previewLayer rectForMetadataOutputRectOfInterest:intertRect];
                                                              NSLog(@" %@, %@,  %@",NSStringFromCGRect(rect),NSStringFromCGRect(intertRect),NSStringFromCGRect(layerRect));
                                                              metadataOutput.rectOfInterest=intertRect;
                                                              
                                                              
                                                          //    metadataOutput.rectOfInterest = [previewLayer metadataOutputRectOfInterestForRect:weakSelf.scanRect]; // 如果不设置，整个屏幕都可以扫
                                                          }];
            
        //    QRScanView *scanView = [[QRScanView alloc] initWithScanRect:self.scanRect];
         //   [self.view addSubview:scanView];
             [appDelegate startScanQRCode];
            [session startRunning];
        } else {
            NSLog(@"%@", error);
        }
    });
}

-(void) initScanDevice
{
    //-----concerned code scan.
    // Device
    _device = [ AVCaptureDevice defaultDeviceWithMediaType : AVMediaTypeVideo ];
    // Input
    _input = [ AVCaptureDeviceInput deviceInputWithDevice : _device error : nil ];
    // Output
    output = [[ AVCaptureMetadataOutput alloc ] init ];
    
    [ output setMetadataObjectsDelegate : self queue : dispatch_get_main_queue ()];

    // Session
    _session = [[ AVCaptureSession alloc ] init ];
    [ _session setSessionPreset : AVCaptureSessionPresetHigh ];
    
    if ([ _session canAddInput : _input ])
    {
        [ _session addInput : _input ];
    }
    
    if ([ _session canAddOutput : output ])
    {
        [ _session addOutput : output];
    }
    
    [self checkAVAuthorizationStatus];
  //  output.rectOfInterest=CGRectMake(124/screenHeight, (screenWidth-220)/2/screenWidth, 220/screenHeight , 220/screenWidth);
    
    // Preview
    _preview =[ AVCaptureVideoPreviewLayer layerWithSession : _session ];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    _preview.frame = self.view .layer.bounds ;
  //  [ self.view.layer insertSublayer : _preview atIndex : 0 ];
    [self.view.layer addSublayer:_preview];
    
    /*
    [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification* _Nonnullnote   ){
        screenWidth=appDelegate.screenWidth;
        CGRect rect = CGRectMake(40, 80, screenWidth - 80, screenWidth - 80);
        //  CGRect rect1=CGRectMake(124/screenHeight, (screenWidth-220)/2/screenWidth, 220/screenHeight , 220/screenWidth);
        CGRect intertRect=[_preview metadataOutputRectOfInterestForRect:rect];
        CGRect layerRect=[_preview rectForMetadataOutputRectOfInterest:intertRect];
        NSLog(@" didchange %@, %@,  %@",NSStringFromCGRect(rect),NSStringFromCGRect(intertRect),NSStringFromCGRect(layerRect));
        output.rectOfInterest=intertRect;
        
    }]; */
    output.rectOfInterest=CGRectMake(0.27f, 0.12f, 0.42f, 0.75f);
    //{{0.27464789, 0.12499999}, {0.42253521, 0.75}}
    [appDelegate startScanQRCode];
    /*
    
    [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureSessionDidStartRunningNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification* _Nonnullnote   ){
        screenWidth=appDelegate.screenWidth;
        CGRect rect = CGRectMake(40, 80, screenWidth - 80, screenWidth - 80);
        //  CGRect rect1=CGRectMake(124/screenHeight, (screenWidth-220)/2/screenWidth, 220/screenHeight , 220/screenWidth);
        CGRect intertRect=[_preview metadataOutputRectOfInterestForRect:rect];
        CGRect layerRect=[_preview rectForMetadataOutputRectOfInterest:intertRect];
        NSLog(@"s startrun %@, %@,  %@",NSStringFromCGRect(rect),NSStringFromCGRect(intertRect),NSStringFromCGRect(layerRect));
        output.rectOfInterest=intertRect;
        
    }]; */
    
    [_session startRunning ];
    //  AVCaptureInputPortFormatDescriptionDidChangeNotification
    
}

- (void)checkAVAuthorizationStatus
{    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    NSString *tips = NSLocalizedString(@"AVAuthorization", @"您没有权限访问相机");
    if(status == AVAuthorizationStatusAuthorized) {
        // authorized        [self setupCamera];
        
        // 条码类型 AVMetadataObjectTypeQRCode
        
        //  output.metadataObjectTypes = @[ AVMetadataObjectTypeQRCode ] ;
        [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
        
        
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
        addedGarageNum.text=stringValue;
        [appDelegate stopScan];
         [_preview removeFromSuperlayer];
        
    }
}


@end
