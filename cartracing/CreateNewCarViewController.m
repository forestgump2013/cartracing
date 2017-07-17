//
//  NewCarViewController.m
//  cartracing
//
//  Created by l on 5/30/16.
//
//

#import "AppDelegate.h"
#import "TracingCarViewController.h"
#import "CreateNewCarViewController.h"
#import "SpinnerViewController.h"
#import "CarBrandViewController.h"
#import "Car.h"
#import "MaintainItem.h"

@interface CreateNewCarViewController ()

@property(nonatomic,retain) AppDelegate *appDelegate;
//concerned register new car
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *oneCarBrandNameButton;
@property (retain, nonatomic) IBOutlet UIButton *oneCarAreaName,*oneCarCheckYearUnit,*oneCarInsuranceYearUnit;
@property (retain,nonatomic) IBOutlet UITextField *oneCarLicense;
@property(nonatomic,retain) IBOutlet UITextField *oneCarMiles;
@property(nonatomic,retain) IBOutlet UIImageView *oneCarBrandMark;
@property(nonatomic,retain) IBOutlet UITextField *inspectDay,*insuranceDay;
@property (weak, nonatomic) IBOutlet UITextField *oneCarOilBoxVolume;

@property(nonatomic,retain) NSMutableArray *keys,*lists;
@property(nonatomic,retain) SpinnerViewController *areaViewController;
@property(nonatomic,retain) CarBrandViewController *carBrandViewController;

@property(nonatomic,retain) NSCharacterSet *characterSet;
@property sqlite3 *carBrandDataBase;
@end

@implementation CreateNewCarViewController

@synthesize appDelegate,scrollView;
@synthesize  oneCarBrandNameButton,oneCarAreaName,oneCarCheckYearUnit,oneCarInsuranceYearUnit,oneCarLicense;
@synthesize oneCarMiles,oneCarBrandMark,oneCarOilBoxVolume;
@synthesize insuranceDay,inspectDay;
@synthesize areaViewController,carBrandViewController,characterSet,carBrandDataBase,keys,lists;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    [self  setTitle:@"添加新车"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(addNewCar)];
    
    NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    [rightItem setTitleTextAttributes:fontDic forState:UIControlStateNormal];
    [rightItem setTitleTextAttributes:fontDic forState:UIControlStateHighlighted];
    [self.navigationItem setRightBarButtonItem:rightItem];
    //.
    UIBarButtonItem *returnButtonItem=[[UIBarButtonItem alloc] init];
    [returnButtonItem setTitle:@"返回"];
  //     NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    [returnButtonItem setTitleTextAttributes:fontDic forState:UIControlStateNormal];
  //  [self.navigationItem setBackBarButtonItem:returnButtonItem];
  //....
    [appDelegate setDateInputView:inspectDay];
    [appDelegate setDateInputView:insuranceDay];
    
    //concerns View Controller.
    carBrandViewController=[[CarBrandViewController alloc] initWithNibName:@"CarBrandViewController" bundle:nil];
    carBrandViewController.brandDictionary=appDelegate.brandDictionary;
    areaViewController=[[SpinnerViewController alloc] initWithNibName:@"SpinnerViewController" bundle:nil];
    characterSet=[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ·"];
    [NSThread detachNewThreadSelector:@selector(initDataBase) toTarget:self withObject:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    [oneCarCheckYearUnit.layer setCornerRadius:5.0f];
    [oneCarInsuranceYearUnit.layer setCornerRadius:5.0f];
    [oneCarAreaName.layer setCornerRadius:5.0f];
    [oneCarBrandNameButton.layer setCornerRadius:5.0f];
    [oneCarBrandMark.layer setCornerRadius:5.0f];
  // [oneCarBrandMark.layer setBorderWidth:2.0f];
  //  [oneCarBrandMark.layer setContentsScale:1.2f];
 //   [oneCarBrandMark.layer setBorderColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f].CGColor];
    
  
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [oneCarBrandMark.layer setContentsScale:1.2f];
    //.
    [oneCarBrandNameButton.titleLabel setText:@"选择品牌"];
    [oneCarBrandNameButton.titleLabel setNumberOfLines:2];
    [oneCarBrandNameButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
    [oneCarBrandNameButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping ];
    [oneCarLicense setText:@""];
    [oneCarMiles setText:@""];
    //[oneCarBrandNameButton.titleLabel setm]
    [oneCarOilBoxVolume setText:@"70"];
    [scrollView setContentOffset:CGPointMake(0, 0)];
 //   self.navigationController.navigationBar.hidden=YES;
    if ([appDelegate.cars count]==0) {
        self.navigationItem.hidesBackButton = YES;
    }   self.navigationItem.hidesBackButton = NO;
    
}

-(void)viewDidLayoutSubviews
{
    
    [scrollView setContentSize:CGSizeMake(appDelegate.screenWidth, appDelegate.screenHeight+400)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -methods

-(void) setBrandName:(NSString *)brandName markName:(NSString *)markName
{
    
    NSLog(@"brandname:%@",brandName);
    [oneCarBrandNameButton.titleLabel setText:brandName];
    [oneCarBrandNameButton setTitle:brandName forState:UIControlStateNormal];
    [oneCarBrandMark setImage:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.png",markName]]];
}

-(IBAction)forwardStep:(id)sender
{
    [appDelegate removeFunctionViewController:self];
    [self addNewCar];
}

-(IBAction)backwordStep:(id)sender
{
    [appDelegate removeFunctionViewController:self];
    [appDelegate.tracingCarViewController refreshView];
}

-(void) addNewCar
{
    
    if ([oneCarBrandNameButton.titleLabel.text isEqualToString:@"选择品牌"]) {
        // [self showNotitationWithInfo:@"品牌！"];
        [appDelegate showNotification:@"汽车品牌!"];
        return;
    }
    if ([oneCarLicense.text isEqualToString:@""]) {
        //  [self showNotitationWithInfo:@"车牌号码！"];
        [appDelegate showNotification:@"车牌号码!"];
        return;
    }
    if ([oneCarMiles.text isEqualToString:@""]) {
        // [self showNotitationWithInfo:@"初始里程！"];
        [appDelegate showNotification:@"初始里程！"];
        return;
    }
    NSString *tLicense=[NSString stringWithFormat:@"%@%@",oneCarAreaName.titleLabel.text,oneCarLicense.text];
    tLicense=[tLicense uppercaseString];
    
    NSString *milesStr=[oneCarMiles.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *carInspectDay,*carInsuranceDay;
    NSInteger carInspectInterval=0,carInsuranceInterval=0;
    carInspectDay=inspectDay.text;
    carInsuranceDay=insuranceDay.text;
    
    
    if (![oneCarCheckYearUnit.titleLabel.text isEqualToString:@"年限"]) {
        carInspectInterval=oneCarCheckYearUnit.tag+1;
    }
    if (![oneCarInsuranceYearUnit.titleLabel.text isEqualToString:@"年限"]) {
        carInsuranceInterval=oneCarCheckYearUnit.tag+1;
    }
    if (![carInspectDay isEqualToString:@""] && carInspectInterval==0) {
        [appDelegate showNotification:@"填入车检时间间隔！"];
        return;
    }
    
    if (![carInsuranceDay isEqualToString:@""] && carInsuranceInterval==0) {
        [appDelegate showNotification:@"填入车险时间间隔！"];
        return;
    }
    
    
    Car *newCar=[[Car alloc] initTempCar:[milesStr intValue] license:tLicense];
    [newCar setBrandName:oneCarBrandNameButton.titleLabel.text];
    [newCar setOilBoxVolume:[oneCarOilBoxVolume.text doubleValue]];
    newCar.car_id=[appDelegate getNewCarId];
    
    [appDelegate initMaintainItems];
    //concerned car insurance and inspection
    MaintainItem *item=[[MaintainItem alloc] initWithCarId:newCar.car_id ItemId:100 itemName:@"车检" lifeTime: carInspectInterval*12 latestMaintinDate:carInspectDay];
    [appDelegate.maintainItems addObject:item];
    /*
    if (carInspectInterval>0) {
      //  newCar.inspectDay=carInspectDay;
      //  newCar.inspectInterval=carInspectInterval;
         //   [appDelegate.maintainItems insertObject:item atIndex:0];
       //  [appDelegate insertMaintainItem:item ];
        
    } */
    MaintainItem *item1=[[MaintainItem alloc] initWithCarId:newCar.car_id ItemId:101 itemName:@"车险" lifeTime: carInsuranceInterval*12 latestMaintinDate:carInsuranceDay];
    [appDelegate.maintainItems addObject:item1];
    /*
    if (carInsuranceInterval>0) {
     //   newCar.insuranceDay=carInsuranceDay;
     //   newCar.insuranceInterval=carInsuranceInterval;
        
        
      //   [appDelegate insertMaintainItem:item];
        
    } */
    
    
    [newCar initNewCarInfo];
    [appDelegate insertNewCar:newCar];
    appDelegate.currentCar=newCar;
    
    for (int i=0; i<[appDelegate.maintainItems count]; i++) {
        MaintainItem *item=[appDelegate.maintainItems objectAtIndex:i];
        [item setCarId:newCar.car_id];
        [appDelegate insertMaintainItem:item];
    }
    
  //  [self refreshView];
    [appDelegate.tracingCarViewController refreshView];
    /*
    [appDelegate updateMaintainCloudInfoWithBuffer:appDelegate.maintainItems Car:appDelegate.currentCar];
    
    [UIView animateWithDuration:1.0 animations:^{
        registerNewCarView.center=CGPointMake(registerNewCarView.center.x-appDelegate.screenWidth, registerNewCarView.center.y);
    }]; */
  //  [appDelegate.navigationController popToRootViewControllerAnimated:YES];
    [oneCarMiles resignFirstResponder];
    [oneCarLicense resignFirstResponder];
    [oneCarOilBoxVolume resignFirstResponder];
    [inspectDay resignFirstResponder];
    [insuranceDay resignFirstResponder];
    
    //reset data.
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [appDelegate.navigationController popViewControllerAnimated:YES];
}

-(IBAction)loadCarsBrandView:(id)sender
{
    
    carBrandViewController.title=@"选择品牌";
    carBrandViewController.keys=keys;
    carBrandViewController.lists=lists;
    [carBrandViewController setLevel:0];
    carBrandViewController.carBrandDataBase=carBrandDataBase;
    carBrandViewController.nav=appDelegate.navigationController;
    [appDelegate.navigationController pushViewController:carBrandViewController animated:YES];
}

-(IBAction)showAreaList:(id)sender
{
    CGRect frame=CGRectMake((appDelegate.screenWidth-100)/2, oneCarAreaName.frame.origin.y-40, 100, 160);
    [areaViewController initWithData:appDelegate.areaCodeArray Frame:frame Button:oneCarAreaName];
    [self.view addSubview:areaViewController.view];
}


-(IBAction)loadCarCheckYearUnitView:(id)sender
{
    CGRect frame=CGRectMake(oneCarCheckYearUnit.frame.origin.x, oneCarCheckYearUnit.frame.origin.y-40, 70, 160);
    [areaViewController initWithData:appDelegate.carCheckYearUnits Frame:frame Button:oneCarCheckYearUnit];
    [self.view addSubview:areaViewController.view];
    
}

-(IBAction)loadCarInsuranceYearUnitView:(id)sender
{
    CGRect frame=CGRectMake(oneCarInsuranceYearUnit.frame.origin.x, oneCarInsuranceYearUnit.frame.origin.y-40, 70, 160);
    [areaViewController initWithData:appDelegate.carCheckYearUnits Frame:frame Button:oneCarInsuranceYearUnit];
    [self.view addSubview:areaViewController.view];
}

-(IBAction)clearSubView:(id)sender
{
    [areaViewController.view removeFromSuperview];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    [appDelegate setCurrentInputDate:textField];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==oneCarLicense) {
      //  NSLog(@"string:%@",string);
        if([string rangeOfCharacterFromSet:[characterSet invertedSet]].location!=NSNotFound)
            return NO;
        NSString *newString=[textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString] ];
        if(newString.length==1)
        {
            if(!pointed)
            {
                pointed=true;
                newString=[newString stringByAppendingString:@"·"];
            } else
            {
                newString=@"";
                pointed=false;
            }
            
        }else{
            if (!pointed) {
                pointed=true;
                NSMutableString *tempStr=[[NSMutableString alloc] initWithFormat:@"%@",newString ];
                [tempStr insertString:@"·" atIndex:1];
                newString=(NSString*)tempStr;
            }
        }
     //   NSLog(@"newString:%@",newString);
        
        [textField setText:[newString substringToIndex:MIN(newString.length , 7)] ];
        return NO;
    }
    return NO;
}

// concerned register new car.
-(void) initDataBase
{
    NSString *carBrandDataBasePath=[[NSBundle mainBundle] pathForResource:@"carBrand" ofType:@"db"];
    if(sqlite3_open([carBrandDataBasePath UTF8String], &carBrandDataBase) !=SQLITE_OK)
    {
        sqlite3_close(carBrandDataBase);
        NSAssert(0,@"Failed to open carbranddatabase");
    }
    keys=[NSMutableArray array];
    lists=[NSMutableArray array];
    [self selectKeys];
}

-(void) selectKeys
{
    NSString *query=@"select letter from car_brand_table  group by letter";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(carBrandDataBase, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        char *str;
        NSString *letter;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            str=(char*)sqlite3_column_text(statement, 0);
            letter=[[NSString alloc] initWithUTF8String:str];
            //     NSLog(letter);
            [keys addObject:letter];
            [self selectBrandWithKey:letter];
        }
    }
    
    
}

-(void) selectBrandWithKey:(NSString * ) key
{
    
    NSString *query=[[NSString alloc] initWithFormat:@"select brand from car_brand_table where letter='%@' group by brand",key];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(carBrandDataBase, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        NSMutableArray *subList=[NSMutableArray array];
        char *str;
        NSString *brand;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            str=(char*)sqlite3_column_text(statement, 0);
            brand=[[NSString alloc] initWithUTF8String:str];
            //     NSLog(brand);
            [subList addObject:brand];
        }
        [lists addObject:subList];
    }
    
}

@end
