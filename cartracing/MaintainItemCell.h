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

@interface MaintainItemCell : UICollectionViewCell{
}

@property(nonatomic, retain) AppDelegate *appDelegate;
@property(nonatomic, retain) IBOutlet UILabel *itemName,*pastMiles,*pastDays;
@property (retain, nonatomic) IBOutlet UIButton *checkbox;
@property (retain,nonatomic) IBOutlet NSLayoutConstraint *defaultConstraint,*defaultConstraint2;
@property (retain,nonatomic) NSMutableArray *addConstraints;
@property(nonatomic, retain) UIButton *maintainBtn;
@property NSInteger itemIndex;
-(void) initialization;
-(void) initAppDelegate;
-(void) showCheckBoxWithFlag:(Boolean) flag;
-(void) checkBoxClick:(UIButton *)btn;
@end
