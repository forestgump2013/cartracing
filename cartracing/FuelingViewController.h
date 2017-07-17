//
//  FuelingViewController.h
//  cartracing
//
//  Created by l on 5/15/16.
//
//

#import <UIKit/UIKit.h>

@interface FuelingViewController : UIViewController<UITextFieldDelegate>

-(IBAction)oilLeftSliderChange:(id)sender;
-(IBAction)loadOilConsumeViewController:(id)sender;

-(IBAction)forwardStep:(id)sender;
-(IBAction)backwardStep:(id)sender;

@end
