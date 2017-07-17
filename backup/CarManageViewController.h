//
//  CarManageViewController.h
//  234
//
//  Created by l on 14-7-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@class AppDelegate;
@class  LifeMilesSetViewController;
@class  AreaViewController;
@class CarsTableView;
@class Car;

@interface CarManageViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>{
    NSMutableArray *cars,*keys,*lists;
    AppDelegate *appDelegate;
    IBOutlet UITextField *oneCarLicense;
   // IBOutlet UITextField *oneCarMiles;
   // IBOutlet UIImageView *oneCarBrandMark;
    IBOutlet UIButton *addMaintainItemBtn;
    IBOutlet UITableView *maintainItemsTable;
    
  //   UIView *registerNewCarView;
    sqlite3 *database,*carBrandDataBase;
    LifeMilesSetViewController *lifeMilesSetViewController;
   // AreaViewController *areaViewController;
    UINavigationController *carNavigationController;
    NSCharacterSet *characterSet;
    Boolean pointed;
    NSInteger selectedRow;
    NSIndexPath *selectedIndexPath;
}

@property(nonatomic,retain) NSMutableArray *cars,*keys,*lists;
@property(nonatomic,retain) AppDelegate *appDelegate;
//@property(nonatomic, retain) UIView *registerNewCarView;
@property(nonatomic, retain) LifeMilesSetViewController *lifeMilesSetViewController;
@property(nonatomic, retain) AreaViewController *areaViewController;
@property(nonatomic, retain) UINavigationController *carNavigationController;
@property(nonatomic,retain) UITextField *oneCarLicense;
@property(nonatomic,retain) UITextField *oneCarMiles;
@property(nonatomic,retain) UIImageView *oneCarBrandMark;
@property (weak, nonatomic) IBOutlet UITextField *oneCarOilBoxVolume;
@property(nonatomic,retain) UIButton *oneCarBrandName;
@property (weak, nonatomic) IBOutlet UIButton *deleteCarBtn;
@property (weak, nonatomic) IBOutlet UILabel *oneCarBrandNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *oneCarAreaName;
@property(nonatomic,retain) UITableViewCell *titleView;
@property(nonatomic,retain) CarsTableView *carsTable;
@property(nonatomic,retain) UITableView *maintainItemsTable;
@property(nonatomic,retain) NSMutableArray *editingCarMaintainItems,*heightArray;
@property(nonatomic,retain) Car *editCar,*deletedCar;
@property(nonatomic,retain) UIAlertView *myAlertView;
@property(nonatomic,retain) NSDictionary *brandDictionary;

@property BOOL isEdited;
@property sqlite3 *database,*carBrandDataBase;
//-(IBAction)loadAddCarView:(id)sender;
//-(IBAction)commitNewCarData:(id)sender;
-(IBAction)loadAddMaintainItemView:(id)sender;
//-(IBAction)showAreaList:(id)sender;
-(IBAction)tableEdit:(id)sender;
-(IBAction)updateMaintainItems:(id)sender;
-(IBAction)checkBeforeReturn:(id)sender;


-(void) refreshEditViewWithEditCar:(Car*) aCar;
-(void) updateEditStateWithFlag:(BOOL) flag;
//-(void) showAddCarView;
//-(void) returnCarManageView:(id)sender;
//-(void) backRegisterNewCarView;
//-(void) returnKeyBoard;
-(void) returnMainMenu;
-(void) loadCarsTableView;
-(IBAction)takeAwayCarsTable:(id)sender;

-(IBAction)deleteEditedCar:(id)sender;
-(void)restoreOneCar:(Car*) aCar;
-(void)updateCarInfo;


//-(void) initBrandDictionary;

//-(void) initDataBase;
//-(void) selectKeys;
//-(void) selectBrandWithKey:(NSString*) key;
//-(IBAction)ttt:(id)sender;
@end
