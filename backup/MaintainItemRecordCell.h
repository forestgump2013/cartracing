//
//  MaintainItemRecordCell.h
//  234
//
//  Created by l on 2/1/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MaintainRecord;
@interface MaintainItemRecordCell : UITableViewCell<UITextFieldDelegate>{
    IBOutlet UILabel *itemName,*lifeMiles;
    IBOutlet UITextField *cost1,*cost2;
    MaintainRecord *record;
}
@property(nonatomic,retain) IBOutlet UILabel *itemName,*lifeMiles;
@property(nonatomic,retain) IBOutlet UITextField *cost1,*cost2;
@property(nonatomic,retain) MaintainRecord *record;

@end
