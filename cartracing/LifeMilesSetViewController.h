//
//  LifeMilesSetViewController.h
//  234
//
//  Created by l on 14-6-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kTableViewRowHeight 100;
@class  MaintainItem;
@class AppDelegate;
@class CarManageViewController;
@class Car;

@interface LifeMilesSetViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *maintainItems;
    IBOutlet UITableView *tableView;
    AppDelegate *appDelegate;
    CarManageViewController *carManagerViewController;
    sqlite3 *database;
    Car *oneCar;
}

@property(nonatomic, retain) NSMutableArray *maintainItems;
@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) AppDelegate *appDelegate;
@property(nonatomic, retain) CarManageViewController *carManagerViewController;
@property sqlite3 *database;
@property(nonatomic, retain) Car *oneCar;



-(IBAction) finishLifeMilesSet:(id)sender;
-(IBAction)cancelAddNewCar:(id)sender;
-(IBAction) closeSoftKeyBoard:(id)sender;
-(void) viewTapped:(UITapGestureRecognizer *)tapGr;


@end
