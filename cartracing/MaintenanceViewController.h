//
//  MaintenanceViewController.h
//  cartracing
//
//  Created by l on 5/10/16.
//
//

#import <UIKit/UIKit.h>

@class MaintainRecord;

@interface MaintenanceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

-(void) clearMaintainRecords;
-(void) addMaintainRecord:(MaintainRecord*) record;
-(BOOL) isNullRecords;

-(IBAction)forwardStep:(id)sender;
-(IBAction)backwardStep:(id)sender;
@end
