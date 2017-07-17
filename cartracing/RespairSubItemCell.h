//
//  RespairSubItemCell.h
//  234
//
//  Created by l on 2/7/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RespairSubItem;

@interface RespairSubItemCell : UITableViewCell<UITextFieldDelegate>
{
 //   UILabel*name;
 //   UITextField *name,*cost1,*cost2;
 //   RespairSubItem *subItem;
    Boolean first;
  //  UILabel *totalCost;
    CGFloat currentTotalCost,tempCost;
}

@property(nonatomic,retain) IBOutlet UITextField *name,*cost1,*cost2;
@property(nonatomic, retain)  UILabel *totalCost;
@property(nonatomic,retain) RespairSubItem *subItem;

-(void) setEditingStyle;
-(void) returnKeyBoard;

@end
