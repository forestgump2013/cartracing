//
//  RepairViewController.h
//  cartracing
//
//  Created by l on 5/18/16.
//
//

#import <UIKit/UIKit.h>

@interface RepairViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

-(void) finishRepairRecord;
-(IBAction)addRepairSubItem:(id)sender;

-(IBAction)forwardStep:(id)sender;
-(IBAction)backwardStep:(id)sender;

@end
