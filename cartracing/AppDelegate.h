//
//  AppDelegate.h
//  234
//
//  Created by l on 14-6-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CommonCrypto/CommonDigest.h>

#import "sqlite3.h"
#import "WXApi.h"
//#import "JPUSHService.h"
#define kFileName @"data.sqlite3"
#define kArchiveFileName @"archive"
#define kCarIdKey @"CarIdKey"
#define kOwnerTel @"OwnerTel";
@class TracingCarViewController;
@class CreateNewCarViewController;
@class LoginViewController;
@class CarManageViewController;
@class PersonalCenterViewController;
@class MaintainItemInitViewController;
@class CarsTableView;
@class MaintainItem;
@class MaintainRecord;
@class FuelingItem;
@class RespairItem;
@class Car;
@class Garage;
@class NotificationLabel;
@class SpinnerViewController;
@class MovingInformation;
@class MyQuartzView;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITextFieldDelegate,NSURLConnectionDataDelegate,WXApiDelegate,UIScrollViewDelegate,NSXMLParserDelegate,AVCaptureMetadataOutputObjectsDelegate>{
  
    PersonalCenterViewController *personalCenterViewController;
    UINavigationController *navigationController,*leftNavigationController,*rightNavigationController;
    NSInteger parseCount;
  //  NSInteger currentCarMiles;
    NSString *currentCarMaintainInfo,*currentCarFuelingInfo,*currentCarRespairInfo;
    sqlite3 *database,*carBrandDataBase;
    NSMutableArray *maintainItems;
    NSMutableArray *fuelingItems,*respairItems;
  //  NSNumberFormatter *numberFormatter;
    NSDictionary *brandDictionary;
  //  NSInteger memberType;
  //  NSString *ownerTel,*garageTel,*weatherInfo;
    NSString *loginDate;
  //  CGFloat oilPrice;
    NSUserDefaults *defaults;
   
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TracingCarViewController *tracingCarViewController;
@property(nonatomic,retain) CreateNewCarViewController *createNewCarViewController;
@property (nonatomic,retain) LoginViewController *loginViewController;
@property(nonatomic,retain) MaintainItemInitViewController *maintainItemInitViewController;
@property (strong, nonatomic) NotificationLabel *notificationInfo;
@property(nonatomic,retain) MovingInformation *movingInfo;
@property(nonatomic,retain) MyQuartzView *myQuartzView;
@property(nonatomic,retain) NSString *currentElementName, *currentVal;
@property(nonatomic,retain) UIImageView *scanLine;
@property(nonatomic,retain) CABasicAnimation *slowDownAnimation;
@property(nonatomic,retain) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) PersonalCenterViewController *personalCenterViewController;
@property (nonatomic,retain) CarsTableView *carsTableView;
@property NSInteger currentCarId,memberType,scanOperationFlag;
@property CGFloat currentOilPrice,screenWidth,screenHeight;
@property BOOL getDataFromCloud;
@property(nonatomic,retain) NSString *serverAddr;
@property(nonatomic,retain)  NSDateFormatter *dateFormatter;
@property(nonatomic,retain) NSNumberFormatter *numberFormater;
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

@property (nonatomic,retain)  NSString *loginDate,*ownerTel,*garageTel,*dateInfo,*city,*province,*carLimitInfo;
@property(nonatomic,retain) NSMutableString *weatherInfo,*oilPriceInfo;
@property (nonatomic,retain) Car *currentCar;
@property (nonatomic,retain) Garage *customGarage;
@property (retain,nonatomic) NSMutableArray *maintainItems,*maintainRecords;
@property (retain,nonatomic) NSMutableArray *cars,*deletedCars,*relatedGarages,*directRelatedGarages;
@property(retain,nonatomic) NSArray *areaCodeArray,*carCheckYearUnits,*itemDetails;
@property (retain,nonatomic) NSMutableArray *fuelingItems,*respairItems;
@property (retain,nonatomic) UINavigationController *navigationController,*leftNavigationController,*autoNavigationController;
@property sqlite3 *database,*carBrandDataBase;
@property(nonatomic,retain)  NSLock *lock;
@property (strong,nonatomic) NSDictionary *brandDictionary;
@property(nonatomic,retain) UITextField *currentInputDate;
@property(nonatomic,retain) MaintainItem *currentEditItem;
@property(nonatomic,retain) SpinnerViewController *spinnerView;

//concerns scan code
@property(nonatomic,retain) AVCaptureSession *scanSession;
@property(nonatomic,retain) AVCaptureVideoPreviewLayer *scanPreviewLayer;
@property(nonatomic,retain) UIButton *scanBackBtn;
@property(nonatomic,retain) UILabel *scanTitle;
-(NSString *) dataFilePath;
-(NSString *) archiveFilePath;
-(void) initDataBase;
-(void) dropAllTables;
-(void) clearDataBase;
-(void) initBrandDictionary;
-(void) lazyLoadOperations;
-(NSString*) getMarkWithBrand:(NSString*) brand;
-(void) dropTableWithName:(NSString*) tableName;
-(void) insertNewCar:(Car*)car;
-(NSInteger) getNewCarId;
-(void) getAllCars;
-(void) getRelatedGarages;
-(void) updateDatabase;
-(void) initMaintainItems;
-(void) insertMaintainItem:(MaintainItem *)mItem ;
-(void) insertmaintainRecord:(MaintainRecord*) record;
-(void) initGlobalData;
-(void) saveCurrentCarInfo;
-(void) showNotification:(NSString*) info;
-(void) setDateInputView:(UITextField*) textField;
-(void) showSpinnerView;
-(void) takeOffSpinnerView;
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
-(void) loadMaintainItemInitView:(BOOL)flag ItemIndex:(NSInteger)index;

-(void) loadFunctionViewController:(UIViewController*) viewController;
-(void) removeFunctionViewController:(UIViewController*) viewController;

-(IBAction)returnMaintainItemInitView:(id)sender;
-(IBAction)finishMaintainItemInitialization:(id)sender;
-(BOOL)showMaintainItemInitView;
-(BOOL) showCarsTableView;

-(void) loadCarsTableView;
-(void) takeAwayCarsTableView;

-(void) insertFuelingRecord:(FuelingItem *) fItem;
-(void) updateFuelingRecord:(FuelingItem *) fItem;
-(void) updateOilPrice:(CGFloat) newOilPrice;
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

-(void) showActivityViewIndicator;
-(void) hideActivityViewIndicator;
-(BOOL) stringIsNull:(id)object;

-(void) selectAllCarBrand;

-(void) sendTextToWeiXin:(NSString*) msg;
-(void) setupCapture;
-(void) startScanQRCode;
-(void) stopScan;
-(void) setMyScanOperationFlag:(NSInteger)flag;
-(NSString*) getEndDate:(NSString*) startDate life: (NSInteger) lifeDays;

-(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

-(void) testTimer;


@end
