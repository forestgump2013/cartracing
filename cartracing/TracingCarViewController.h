//
//  TracingCarViewController.h
//  234
//
//  Created by l on 14-6-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "sqlite3.h"
@class  AppDelegate;
@class MaintenanceViewController;
@class FuelingViewController;
@class RepairViewController;
//@class MaintainItemInitViewController;
@class Car;
@class Garage;
@class MoveLabel;
@class MaintainItem;
@class RoundCornorView;
@class MaintainRecordViewController;
@class OilConsumeViewController;
@class CarBrandViewController;
@class SpinnerViewController;
@class NotificationLabel;
@class DefaultTableViewCell;
@class CreateNewCarViewController;

@interface TracingCarViewController : UIViewController
   <UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>{
       AppDelegate *appDelegate;
       Car *currrentCar;
       
   
       UIView *milesInputView;
    //   UIView *maintainView;
    //   UIView *fuelingView,*respairView;
     //  UIView *registerNewCarView;
       IBOutlet MoveLabel *moveLabel;
       NSMutableArray *milesNumbers;
       
       IBOutlet UITextField *aCarMiles;
    //   IBOutlet UITableView *maintainItemsTable,*maintainRecordsTable;
       IBOutlet UITextField *tempMiles;
       IBOutlet UIButton *functionBtn;
       
       IBOutlet UILabel *mItemName;
       IBOutlet UITextField *mItemLatestMiles;
       IBOutlet UITextField *mItemCost;
       IBOutlet UIButton *finishMtBtn;  
       sqlite3 *database;
       NSMutableArray *maintainRecords;
       NSArray *listData;
       Boolean leftExpend,chooseMitems,pointed,showFunctionView,canMoveAway;
       NSNumberFormatter *numberFormatter;
       NSDateFormatter *dateFormatter;       
       NSCharacterSet *characterSet;
       UITapGestureRecognizer *showOilConsumeViewTap;
       NSInteger currentGarageIndex;
       
}
@property(nonatomic, retain) AppDelegate *appDelegate;
@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic, retain) Car *currentCar;
@property(nonatomic, retain) Garage *currentGarage;
@property(nonatomic,retain) MoveLabel *moveLabel;


@property(nonatomic, retain) UIView *milesInputView,*eCardView;

@property(nonatomic, retain) UIView *maintainView;
@property(nonatomic,retain) MaintenanceViewController *maintenanceViewController;
@property(nonatomic,retain) FuelingViewController *fuelingViewController;
@property(nonatomic,retain) RepairViewController *repairViewController;

@property(nonatomic,retain)  CreateNewCarViewController *createNewCarViewController;
@property(nonatomic, retain) UIView *itemInitMaintainView;
@property(nonatomic, retain) UIView *fuelingView,*respairView;
@property(nonatomic, retain) UIView *registerNewCarView;
@property(nonatomic, retain) IBOutlet UIScrollView *maintainScrollView,*maintainItemSetScrollView,*fuelingScrollView,*respairScrollView,*registerNewCarScrollView,*ecardScrollView;
@property(nonatomic,retain) UIAlertView *reComputeOilConsumeAlert,*milesAlertView;

@property(nonatomic, retain) UITextField *aCarLicense;
@property(nonatomic, retain) UITextField *aCarMiles;
@property(nonatomic, retain) UITextField *tempMiles;
@property(nonatomic, retain) UICollectionView *maintainItemsTable;
@property(nonatomic, retain) IBOutlet UIView *maintainScrollViewContentView;
@property(nonatomic, retain) DefaultTableViewCell *titleView;

@property(nonatomic, retain) IBOutlet UILabel *currentCarMiles;
@property (weak, nonatomic) IBOutlet UILabel *currentMilesBoard;

@property(nonatomic,retain) UILabel *mItemName;
@property(nonatomic,retain) UITextField *mItemLatestMiles;
@property (weak, nonatomic) IBOutlet UITextField *mItemNote;
@property(nonatomic,retain) UIButton *finishMtBtn;

@property(nonatomic,retain)IBOutlet UILabel *itemInitItemName;
@property(nonatomic,retain)IBOutlet UITextField *itemInitLatestMaintainMiles,*addMaintainItemName;
@property(nonatomic,retain) IBOutlet UITextField *itemInitMaintainLifeMiles;
@property(nonatomic,retain) IBOutlet UITextField *itemInitLatestMaintainDate;
@property(nonatomic,retain) IBOutlet  UITextField *itemInitLatestMaintainDateDiv;
@property(nonatomic,retain) IBOutlet UIToolbar *accessoryView;
@property(nonatomic,retain) IBOutlet UIDatePicker *customInput;

//concerned ecard info
@property(nonatomic,retain) IBOutlet UILabel *ecGarageName,*ecGarageContact,*ecGarageAddr,*ecGarageTel,*ecGarageBusiness;

//@property (nonatomic,retain)  NotificationLabel *infoBoard;
@property (nonatomic,retain) UIButton *functionBtn;
@property(nonatomic, retain) NSArray *listData;
@property(nonatomic, retain) NSMutableArray *maintainRecords,*respairSubItems;

@property(nonatomic,retain) IBOutlet UIButton *maintainCancelBtn,*maintainFinishBtn,*advertiseBoard;

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
@property (retain, nonatomic) IBOutlet UIButton *oneCarAreaName,*oneCarCheckYearUnit,*oneCarInsuranceYearUnit;
@property (retain,nonatomic) IBOutlet UITextField *oneCarLicense;
@property(nonatomic,retain) IBOutlet UITextField *oneCarMiles;
@property(nonatomic,retain) IBOutlet UIImageView *oneCarBrandMark,*slideDownMark;
@property(nonatomic,retain) IBOutlet UITextField *inspectDay,*insuranceDay,*inspectIntertal,*insuranceInterval;
@property (weak, nonatomic) IBOutlet UITextField *oneCarOilBoxVolume;
//@property(nonatomic,retain) IBOutlet UIDatePicker *dateInputPicker;

@property(nonatomic,retain) NSMutableArray *keys,*lists;
@property(nonatomic,retain) SpinnerViewController *areaViewController;
@property(nonatomic,retain) CarBrandViewController *carBrandViewController;
@property(nonatomic,retain) MaintainRecordViewController *maintainRecordViewController;
@property(nonatomic,retain) OilConsumeViewController *oilConsumeViewController;

-(void) refreshMilesView;
-(void) refreshView;
-(void) segmentControllSet;
-(void) startMoveLabel:(NSString*)txt;
//-(void) showGarageInfo;
-(void) showNotitationWithInfo:(NSString*) info;
-(void) showCarsTableView;
-(IBAction)removeCarsTableView:(id)sender ;
-(void) setMilesNumber;
-(void) changeGarageIndex;
-(NSInteger) getMilesNumber; 

-(IBAction)commitNewCarData:(id)sender;

-(void)updateCurrentMiles;
-(IBAction)cancelMilesView:(id)sender;
-(IBAction)returnMilesView:(id)sender;
-(IBAction)showECardView:(id)sender;
-(IBAction)callContact:(id)sender;
-(IBAction)hiddeECardView:(id)sender;
-(BOOL) isEcardShow;
-(IBAction)returnMaintainView:(id)sender;
-(void)finishMaintainDateSet;
-(IBAction)cancelMaintainItemInitialization:(id)sender;
//-(IBAction)finishBatchMaintain:(id)sender;
-(IBAction)backgroundClick:(id)sender;
-(void)reLocationRegisterNewCarView;
-(IBAction)drawMenuView:(id)sender;
-(IBAction)switchFunction:(id)sender;
-(IBAction)functionOperation:(id)sender;
-(void) finishFunctionOprationWithMiles:(NSInteger)newMiles;

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
-(void) setRegisternewCarView;
-(void) loadCreateNewCarView;
-(IBAction)returnRegisterNewCarView:(id)sender;
-(IBAction)loadCarBrandView:(id)sender;
-(IBAction)loadCarCheckYearUnitView:(id)sender;
-(IBAction)loadCarInsuranceYearUnitView:(id)sender;
-(IBAction)showAreaList:(id)sender;
-(IBAction)clearSubViewsOnRegisterView:(id)sender;
-(void) initEcardView;
-(void) temporaryCustomGarage;
-(void) initDataBase;
-(void) selectKeys;
-(void) selectBrandWithKey:(NSString*) key;
-(void) setCanMoveAway:(Boolean) flag;
-(Boolean) isCanMoveAway;

-(void) testTimer;


@end
