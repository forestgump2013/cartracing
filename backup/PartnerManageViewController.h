//
//  PartnerManageViewController.h
//  cartracing
//
//  Created by l on 7/9/15.
//
//

#import <UIKit/UIKit.h>

@class GarageRegisterController;
@class AppDelegate;

@interface PartnerManageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
}

@property(retain,nonatomic) GarageRegisterController *garageRegisterController;
@property(retain,nonatomic) AppDelegate *appDelegate;
@property(retain,nonatomic) IBOutlet UITableView *checkedGaragesTable;
@property(retain,nonatomic) NSMutableArray *checkGarages;

-(void)loadGarageRegisterViewController;
-(void) getNeedCheckGarages;

@end
