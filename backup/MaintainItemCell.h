//
//  MaintainItemCell.h
//  234
//
//  Created by l on 14-6-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  AppDelegate;
@class CustomProgressView;

@interface MaintainItemCell : UITableViewCell{
 //   IBOutlet UIButton *maintainBtn;
 //   AppDelegate *appDelegate;
}

@property(nonatomic, retain) AppDelegate *appDelegate;
@property(nonatomic, retain) IBOutlet UILabel *itemName,*milesLeftPercent,*timeLeftPercent;
@property(nonatomic, retain) IBOutlet CustomProgressView *leftPercent;
@property (retain, nonatomic) IBOutlet UIButton *checkbox;
@property(nonatomic, retain) UIButton *maintainBtn;
@property NSInteger itemIndex;
-(void) maintain;
-(void) initAppDelegate;
//-(void) initCheckBox;
-(void) showCheckBoxWithFlag:(Boolean) flag;
-(void) checkBoxClick:(UIButton *)btn;
@end
