//
//  MaintainItemSetCell.h
//  234
//
//  Created by l on 14-6-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MaintainItem;
@class  AppDelegate;

@interface MaintainItemSetCell : UITableViewCell<UITextFieldDelegate>{
//    IBOutlet UILabel *itemName;
  //  IBOutlet UITextField *latestMaintainMiles;
 //   IBOutlet UITextField *lifeMiles;
}

@property(nonatomic,retain) IBOutlet UIButton *showBtn;
@property(nonatomic , retain) IBOutlet UILabel *itemName,*itemDetail,*label1;
@property(nonatomic , retain) IBOutlet UITextField *latestMaintainMiles,*latestMaintainDate;
@property(nonatomic , retain) IBOutlet UITextField *lifeMiles,*lifeTime;
@property(nonatomic, retain) UITableView *parentTable;
@property(nonatomic, retain) MaintainItem *item;
@property NSInteger selfRow;
@property(nonatomic,retain) NSMutableArray *heightArray;

@property NSInteger height;

-(void) initWithParentTable:(UITableView*)parent Row:(NSInteger) row HeightArray:(NSMutableArray*) array;
-(IBAction)showItemDetail:(id)sender;
-(void) initAppDelegate:(AppDelegate*) apd;


@end
