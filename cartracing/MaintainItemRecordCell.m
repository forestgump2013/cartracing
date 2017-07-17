//
//  MaintainItemRecordCell.m
//  234
//
//  Created by l on 2/1/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MaintainItemRecordCell.h"
#import "MaintainRecord.h"


@implementation MaintainItemRecordCell

@synthesize itemName,lifeMiles,cost1,cost2;
@synthesize record;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==cost1) {
        [record setCost1:[cost1.text floatValue]];
    } else if(textField==cost2){
        [record setCost2:[cost2.text floatValue]];
    }
    return YES;
}

@end
