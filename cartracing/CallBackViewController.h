//
//  CallBackViewController.h
//  234
//
//  Created by l on 7/30/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@class TopicItem;

@interface CallBackViewController : UIViewController
{
    AppDelegate *appDelegate;
    NSInteger fromFlag;
    TopicItem *topic;
    NSMutableArray *items;
}
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextView *callBackInfo;
//@property (weak, nonatomic) IBOutlet UITextField *contact;
//@property(nonatomic,retain) IBOutlet UIButton *button;

-(IBAction)returnMainView:(id)sender;
-(void) setFromFlag:(NSInteger) flag  Items:(NSMutableArray*) is  Topic:(TopicItem *) im;
@end
