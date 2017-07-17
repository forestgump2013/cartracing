//
//  TracingCarViewController.h
//  234
//
//  Created by l on 14-6-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "sqlite3.h"
@class  AppDelegate;
@class Car;
@class MoveLabel;
@class MaintainItem;
@class CarsTableView;
@class MaintainRecordViewController;
@class OIlConsumeViewController;
@class CarBrandViewController;
@class SpinnerViewController;
@class NotificationLabel;

@interface TracingCarViewController : UIViewController
   <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>{
    AppDelegate *appDelegate;
       Car *currrentCar;
       
   
       UIView *milesInputView;
       UIView *maintainView;
     //  UIView *batchMaintainView;
       UIView *fuelingView,*respairView;
       UIView *registerNewCarView;       
       IBOutlet MoveLabel *moveLabel;
       NSMutableArray *milesNumbers;
       
    IBOutlet UITextField *aCarMiles;
       UITableViewCell *titleView;     
       CarsTableView *carsTableView;
//   IBOutlet UILabel *currentCarMiles;
    IBOutlet UITableView *maintainItemsTable,*maintainRecordsTable;
    IBOutlet UITextField *tempMiles;
       IBOutlet UIButton *functionBtn;
       
       IBOutlet UILabel *mItemName;
       IBOutlet UITextField *mItemLatestMiles;
   //    IBOutlet UITextField *mItemLifeMiles;
       IBOutlet UITextField *mItemCost;
       IBOutlet UIButton *finishMtBtn;  
       sqlite3 *database;
    NSMutableArray *maintainRecords;
    NSArray *listData;
       Boolean leftExpend,chooseMitems,pointed,showFunctionView;
       NSNumberFormatter *numberFormatter;
       NSDateFormatter *dateFormatter;       
       NSCharacterSet *characterSet;
       UITapGestureRecognizer *showOilConsumeViewTap;
       
}
@property(nonatomic, retain) AppDelegate *appDelegate;
@property(nonatomic, retain) Car *currentCar;
@property(nonatomic,retain) MoveLabel *moveLabel;
@property (weak, nonatomic) IBOutlet UILabel *garageInfo;


@property(nonatomic, retain) UIView *milesInputView,*eCardView;
@property(nonatomic, retain) UIView *maintainView;
@property(nonatomic, retain) UIView *itemInitMaintainView;
@property(nonatomic, retain) UIView *fuelingView,*respairView;
@property(nonatomic, retain) UIView *registerNewCarView;
@property(nonatomic, retain) IBOutlet UIScrollView *maintainScrollView,*maintainItemSetScrollView,*fuelingScrollView,*respairScrollView,*registerNewCarScrollView;
@property(nonatomic,retain) UIAlertView *reComputeOilConsumeAlert;

@property(nonatomic, retain) UITextField *aCarLicense;
@property(nonatomic, retain) UITextField *aCarMiles;
@property(nonatomic, retain) UITextField *tempMiles;
@property(nonatomic, retain) UITableView *maintainItemsTable,*maintainRecordsTable;
@property(nonatomic, retain) IBOutlet UIView *maintainScrollViewContentView;
@property(nonatomic, retain) UITableViewCell *titleView;
@property(nonatomic, retain) CarsTableView *carsTableView;
@property(nonatomic, retain) IBOutlet UILabel *currentCarMiles;
//@property (weak, nonatomic) IBOutlet UILabel *milesBackground;
@property (weak, nonatomic) IBOutlet UILabel *currentMilesBoard;

@property(nonatomic,retain) UILabel *mItemName;
@property(nonatomic,retain) UITextField *mItemLatestMiles;
//@property(nonatomic,retain) UITextField *mItemLifeMiles;
//@property(nonatomic,retain) UITextField *mItemCost;
@property (weak, nonatomic) IBOutlet UITextField *mItemNote;
@property(nonatomic,retain) UIButton *finishMtBtn;
// concerned initialization of maintain Items 

@property(nonatomic,retain)IBOutlet UILabel *itemInitItemName;
@property(nonatomic,retain)IBOutlet UITextField *itemInitLatestMaintainMiles,*addMaintainItemName;
@property(nonatomic,retain) IBOutlet UITextField *itemInitMaintainLifeMiles;
@property(nonatomic,retain) IBOutlet UITextField *itemInitLatestMaintainDate;
@property(nonatomic,retain) IBOutlet  UITextField *itemInitLatestMaintainDateDiv;
@property(nonatomic,retain)IBOutlet UIToolbar *accessoryView;
@property(nonatomic,retain) IBOutlet UIDatePicker *customInput;

//@property (nonatomic,retain)  NotificationLabel *infoBoard;
@property (nonatomic,retain) UIButton *functionBtn;
@property(nonatomic, retain) NSArray *listData;
@property(nonatomic, retain) NSMutableArray *maintainRecords,*respairSubItems;

@property(nonatomic,retain) IBOutlet UIButton *maintainCancelBtn,*maintainFinishBtn;

@property (weak, nonatomic) IBOutlet UITextField *fuelingMiles;
@property (weak, nonatomic) IBOutlet UISlider *fuelingLeftPercent;
@property (weak ,nonatomic) IBOutlet UILabel *fuelingleftPercentLabel;
@property CGFloat fuelingVolue,fuelingCost;
@property (weak, nonatomic) IBOutlet UIButton *fuelingLastOilConsumption;
@property (weak, nonatomic) IBOutlet UITextField *fuelingOilCost;
@property (weak, nonatomic) IBOutlet UITextField *fuelingOilPrice;
@property (weak, nonatomic) IBOutlet UITextField *fuelingOilVolume;
@property (weak, nonatomic) IBOutlet UIButton *fuelingDateBtn;
//@property (weak, nonatomic) IBOutlet UIButton *fuelingDoneBtn;
//@property (weak, nonatomic) IBOutlet UIButton *fuelingCancelBtn;
@property (weak, nonatomic) IBOutlet UITextView *respairItemsNames;
@property (weak, nonatomic) IBOutlet UITableView *respairSubItemsTable;
@property (weak,nonatomic) IBOutlet UIButton *addRespairSbuItemBtn;
@property (weak, nonatomic) IBOutlet UILabel *repairCost;
@property (weak, nonatomic) IBOutlet UITextField *respairMiles;





@property sqlite3 *database,*carBrandDataBase;
@property Boolean leftExpend,chooseMitems;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

//concerned register new car
@property (weak, nonatomic) IBOutlet UIButton *oneCarBrandNameButton;
@property (retain, nonatomic) IBOutlet UIButton *oneCarAreaName,*oneCarCheckYearUnit;
@property (retain,nonatomic) IBOutlet UITextField *oneCarLicense;
@property(nonatomic,retain) IBOutlet UITextField *oneCarMiles;
@property(nonatomic,retain) IBOutlet UIImageView *oneCarBrandMark;
@property(nonatomic,retain) IBOutlet UITextField *inspectDay,*insuranceDay,*inspectIntertal,*insuranceInterval;
@property (weak, nonatomic) IBOutlet UITextField *oneCarOilBoxVolume;
//@property(nonatomic,retain) IBOutlet UIDatePicker *dateInputPicker;

@property(nonatomic,retain) NSMutableArray *keys,*lists;
@property(nonatomic,retain) SpinnerViewController *areaViewController;
@property(nonatomic,retain) CarBrandViewController *carBrandViewController;
@property(nonatomic,retain) MaintainRecordViewController *maintainRecordViewController;
@property(nonatomic,retain) OIlConsumeViewController *oilConsumeViewController;

-(void) refreshMilesView;
-(void) refreshView;
-(void) segmentControllSet;
-(void) startMoveLabel:(NSString*)txt;
-(void) showGarageInfo;
-(void) showNotitationWithInfo:(NSString*) info;
-(void) showCarsTableView;
-(IBAction)removeCarsTableView:(id)sender ;
-(void) setMilesNumber;
-(NSInteger) getMilesNumber; 

-(IBAction)commitNewCarData:(id)sender;

-(void)updateCurrentMiles;
-(IBAction)cancelMilesView:(id)sender;
-(IBAction)returnMilesView:(id)sender;
-(IBAction)showECardView:(id)sender;
-(IBAction)hiddeECardView:(id)sender;

-(IBAction)returnMaintainView:(id)sender;
-(void)finishMaintainDateSet;
-(IBAction)finishMaintainItemInitialization:(id)sender;
-(IBAction)cancelMaintainItemInitialization:(id)sender;
//-(IBAction)finishBatchMaintain:(id)sender;
-(IBAction)backgroundClick:(id)sender;
-(void)reLocationRegisterNewCarView;
-(IBAction)loadCarManageView:(id)sender;
//-(void) loadPersonalCenterView:(id)sender;
-(IBAction)switchFunction:(id)sender;
-(IBAction)functionOperation:(id)sender;
-(void) cancelTableViewSelectedState;


-(void) updateMaintainItems;
-(void)loadMaintainView: (MaintainItem*)item;
-(void) loadInitMaintainItemViewWithItemIndex:(NSInteger) index;
-(IBAction)loadMaintainRecordView:(id)sender;
-(IBAction)maintainViewKeyboard:(id)sender;
-(IBAction)respairViewCancelKeyboard:(id)sender;
-(IBAction)cancelMaintainView:(id)sender;
-(IBAction)prepareRecomputeOilConsume:(id)sender;
-(void) insertFuelingRecord;
-(void) showOilConsumeView;
-(void) reComputeOilConsume;
-(IBAction)oilLeftSliderChange:(id)sender;
-(IBAction)finishFueling:(id)sender;
-(IBAction)computeLastFuelingWear:(id)sender;
-(IBAction)cancelFuelingView:(id)sender;
-(NSInteger) getMonth:(NSString *) date;

-(IBAction)finishRespairRecord:(id)sender;

-(IBAction)cancelRespairView:(id)sender;
-(IBAction)addRespairSubItem:(id)sender;
-(IBAction)testOperation:(id)sender;

-(void)showRegisterNewCar;
//-(BOOL) isShowRegisterNewCarView;
-(void) setRegisternewCarView;
-(IBAction)returnRegisterNewCarView:(id)sender;
-(IBAction)loadCarBrandView:(id)sender;
-(IBAction)loadCarCheckYearUnitView:(id)sender;
-(IBAction)showAreaList:(id)sender;
//-(IBAction) commitNewCarData:(id)sender;
-(void) initDataBase;
-(void) selectKeys;
-(void) selectBrandWithKey:(NSString*) key;

-(void) testTimer;


@end
