//
//  HelpViewController.h
//  234
//
//  Created by l on 3/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class GarageViewController;
@class AppDelegate;

@interface HelpViewController : UIViewController

//@property(nonatomic,retain) GarageViewController *garageRegisterView;
@property(nonatomic, retain) AppDelegate *appDelegate;
@property(nonatomic,retain) UINavigationController *container;

-(IBAction)loadGarageRegisterView:(id)sender;

@end
