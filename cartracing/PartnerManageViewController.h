//
//  PartnerManageViewController.h
//  cartracing
//
//  Created by l on 7/9/15.
//
//

#import <UIKit/UIKit.h>
//#import <AVFoundation/AVFoundation.h>

@class GarageRegisterController;
@class AppDelegate;
@class Garage;

@interface PartnerManageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSInteger indicator;
    NSString *buttonTitle;
}

@property(retain,nonatomic) GarageRegisterController *garageRegisterController;
@property(retain,nonatomic) AppDelegate *appDelegate;
@property(retain,nonatomic) IBOutlet UIButton *unCheckedBtn,*checkedBtn;
@property(retain,nonatomic) IBOutlet UITableView *checkedGaragesTable;
@property(retain,nonatomic) IBOutlet UILabel *selfInfoLabel;
@property(retain,nonatomic) NSMutableArray *checkGarages,*passedGarages;
@property(retain,nonatomic) UIAlertView *checkAlert,*detailAlert;



-(void)loadGarageRegisterViewController;
-(void) getNeedCheckGarages;
-(void) getAllGarages;
-(void) checkGarageWithIndex:(NSInteger) index;
-(void) addUnCheckedGarage:(Garage*) garage;
-(IBAction)showGarages:(id)sender;

@end
