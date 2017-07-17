//
//  FuelingItemCell.m
//  234
//
//  Created by l on 14-7-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "FuelingItemCell.h"

@implementation FuelingItemCell
@synthesize volume;
@synthesize cost;
@synthesize miles;
@synthesize date;

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
    UIView *selectView=[[UIView alloc] initWithFrame:self.frame];
    [selectView setBackgroundColor:[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f]];
    [self setSelectedBackgroundView:selectView];
}

@end
