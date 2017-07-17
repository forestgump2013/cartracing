//
//  NewCarViewController.h
//  cartracing
//
//  Created by l on 5/30/16.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface CreateNewCarViewController : UIViewController<UITextFieldDelegate>{
    Boolean pointed;
}

-(void)addNewCar;
-(IBAction)loadCarsBrandView:(id)sender;
-(IBAction)showAreaList:(id)sender;
-(IBAction)loadCarCheckYearUnitView:(id)sender;
-(IBAction)loadCarInsuranceYearUnitView:(id)sender;
-(IBAction)clearSubView:(id)sender;
-(IBAction)forwardStep:(id)sender;
-(IBAction)backwordStep:(id)sender;
-(void) setBrandName:(NSString*) brandName markName:(NSString*) markName;

@end
