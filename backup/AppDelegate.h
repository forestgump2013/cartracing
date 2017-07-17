//
//  AppDelegate.h
//  234
//
//  Created by l on 14-6-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "sqlite3.h"
#import "WXApi.h"
#define kFileName @"data.sqlite3"
#define kArchiveFileName @"archive"
#define kCarIdKey @"CarIdKey"
#define kOwnerTel @"OwnerTel";
@class TracingCarViewController;
@class LoginViewController;
@class CarManageViewController;
@class PersonalCenterViewController;
@class CarsTableView;
@class MaintainItem;
@class MaintainRecord;
@class FuelingItem;
@class RespairItem;
@class Car;
@class Garage;
@class NotificationLabel;
@class SpinnerViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITextFieldDelegate,NSURLConnectionDataDelegate,WXApiDelegate,UIScrollViewDelegate>{
    TracingCarViewController *tracingCarViewController;
    LoginViewController *loginViewController;
  //  CarManageViewController *carManageViewController;
    PersonalCenterViewController *personalCenterViewController;
    UINavigationController *navigationController,*leftNavigationController,*rightNavigationController;
    NSInteger currentCarId;
  //  NSInteger currentCarMiles;
    NSString *currentCarMaintainInfo,*currentCarFuelingInfo,*currentCarRespairInfo;
    Car *currentCar;
  //  Garage *garage;
    sqlite3 *database,*carBrandDataBase;
    NSMutableArray *maintainItems;
  //  NSMutableArray *waitedMaintainItems;
 //   NSMutableArray *cars;
    NSMutableArray *fuelingItems,*respairItems;
    NSNumberFormatter *numberFormatter;
    NSDictionary *brandDictionary;
    NSInteger memberType;
    NSString *ownerTel,*garageTel,*weatherInfo;
    NSString *loginDate;
    CGFloat oilPrice;
    NSUserDefaults *defaults;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TracingCarViewController *tracingCarViewController;
@property (nonatomic,retain) LoginViewController *loginViewController;
@property (strong, nonatomic) NotificationLabel *notificationInfo;
@property (strong, nonatomic) PersonalCenterViewController *personalCenterViewController;
@property (nonatomic,retain) CarsTableView *carsTableView;
@property NSInteger currentCarId,memberType;
@property CGFloat oilPrice,screenWidth,screenHeight;
@property BOOL getDataFromCloud;
// maintian item init view.
@property(nonatomic,retain) UIView *maintainItemInitView;
@property(nonatomic,retain)IBOutlet UILabel *itemInitItemName;
@property(nonatomic,retain)IBOutlet UITextField *itemInitLatestMaintainMiles,*addMaintainItemName;
@property(nonatomic,retain) IBOutlet UITextField *itemInitMaintainLifeMiles;
@property(nonatomic,retain) IBOutlet UITextField *itemInitLatestMaintainDate;
@property(nonatomic,retain) IBOutlet  UITextField *itemInitLatestMaintainDateDiv;
@property(nonatomic,retain)IBOutlet UIToolbar *accessoryView;
@property(nonatomic,retain) IBOutlet UIDatePicker *customInput;
@property(nonatomic, retain) IBOutlet UIScrollView *maintainItemSetScrollView;

@property (nonatomic,retain)  NSString *loginDate,*ownerTel,*garageTel,*dateInfo,*weatherInfo,*city,*carLimitInfo;
@property (nonatomic,retain) Car *currentCar;
@property (nonatomic,retain) Garage *garage;
@property (retain,nonatomic) NSMutableArray *maintainItems,*maintainRecords;
//@property (retain,nonatomic) NSMutableArray *waitedMaintainItems;
@property (retain,nonatomic) NSMutableArray *cars,*deletedCars;
@property(retain,nonatomic) NSArray *areaCodeArray,*carCheckYearUnits,*itemDetails;
@property (retain,nonatomic) NSMutableArray *fuelingItems,*respairItems;
@property (retain,nonatomic) UINavigationController *navigationController,*leftNavigationController,*rightNavigationController;
@property sqlite3 *database,*carBrandDataBase;
@property (strong,nonatomic) NSDictionary *brandDictionary;
@property(nonatomic,retain) UITextField *currentInputDate;
@property(nonatomic,retain) MaintainItem *currentEditItem;
@property(nonatomic,retain) SpinnerViewController *spinnerView;
-(NSString *) dataFilePath;
-(NSString *) archiveFilePath;
-(void) initDataBase;
-(void) dropAllTables;
-(void) clearDataBase;
-(void) initBrandDictionary;
-(NSString*) getMarkWithBrand:(NSString*) brand;
-(void) dropTableWithName:(NSString*) tableName;
-(void) insertNewCar:(Car*)car;
-(NSInteger) getNewCarId;
-(void) getAllCars;
-(void) updateDatabase;
-(void) initMaintainItems;
-(void) insertMaintainItem:(MaintainItem *)mItem ;
-(void) insertmaintainRecord:(MaintainRecord*) record;
-(void) initGlobalData;
-(void) saveCurrentCarInfo;
-(void) showNotification:(NSString*) info;
-(void) showSpinnerView;
-(void) showWelcomeView;
-(void) removeWelcomeView;
-(TracingCarViewController *) getTracingCarViewController;
-(void) reSetCurrentCarWithCar:(Car*) aCar;
-(void) updateCurrentCarInfo;
-(void) updateCarInfo:(Car*)aCar;
-(void) updateMaintainInfo;
-(void) updateSignalMaintainItemWithMaintianItem:(MaintainItem*)item;
-(void) updateMaintainItemInfoOfCar:(Car*) aCar WithBuffer:(NSMutableArray*) buffer;
-(void) selectCurrentCarInfo;
-(void) selectMaintainTableWithCarId:(NSInteger) Carid  ToBuffer:(NSMutableArray*)buffer;
-(void) selectMaintainRecordsWithItemId:(NSInteger)id toBuffer:(NSMutableArray*) recordsBuffer;
-(void) selectMaintainAllRecordsToBuffer:(NSMutableArray*) recordsBuffer;
-(IBAction)loadMaintainItemInitView:(id)sender;
-(IBAction)returnMaintainItemInitView:(id)sender;
-(IBAction)finishMaintainItemInitialization:(id)sender;
-(BOOL)showMaintainItemInitView;
-(BOOL) showCarsTableView;

-(void) loadCarsTableView;
-(void) takeAwayCarsTableView;

-(void) insertFuelingRecord:(FuelingItem *) fItem;
-(void) updateFuelingRecord:(FuelingItem *) fItem;
-(BOOL) checkFuelingMiles:(NSInteger) miles;
-(void) selectFuelingItems;
-(void) selectAllFuelingItems;
-(void) insertRespairRecord:(RespairItem *) rItem;
-(void) selectRespairItems;
-(void) legalNumberFormatter;
-(void) deleteOneCar:(NSInteger) car_id;
-(void) restoreOneCar:(Car*) aCar;
-(void) dataToView;
-(void) unlogin;
-(void) loginWithTel:(NSString *) tel  Type:(NSInteger) type Garage:(Garage*) ga;
-(void) getUsefulInfo; // date ,city ,weather carLimit
//-(NSString*)getLimitInfo:(NSString*)city;
-(NSString*) dataToCloud;
-(void) updateCloudInfoWithCar:(Car*) aCar;
-(void) updateMaintainCloudInfoWithBuffer:(NSMutableArray*) tMaintainItems Car:(Car*) aCar;
-(void) postMaintainRecordsOfCar:(Car*) aCar Buffer:(NSMutableArray*) array;
-(void) postFuelingRecordOfCar:(Car*) aCar Record:(FuelingItem*) item;
-(void) postRepairRecordOfCar:(Car*) aCar Record:(RespairItem*) item;
-(NSString*) carsJson;
-(NSString*) fuelingJson;
-(NSString*) respairJson;

-(void) selectAllCarBrand;

-(void) sendTextToWeiXin:(NSString*) msg;

-(void) testTimer;


@end
