//
//  CallBackViewController.h
//  234
//
//  Created by l on 7/30/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

@interface CallBackViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextView *callBackInfo;
@property (weak, nonatomic) IBOutlet UITextField *contact;
@property(nonatomic,retain) IBOutlet UIButton *button;

-(IBAction)returnMainView:(id)sender;
@end
