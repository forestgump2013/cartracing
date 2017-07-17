//
//  DefaultTableViewCell.m
//  234
//
//  Created by l on 3/27/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "DefaultTableViewCell.h"

@implementation DefaultTableViewCell

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

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(24, (self.frame.size.height-32)/2, 32, 32 )];  //self.imageView.frame.size.height
    self.imageView.contentMode=UIViewContentModeCenter;
  //  [self.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    [self.imageView setBackgroundColor:[UIColor clearColor]];
    [self.imageView.layer setContentsScale:1.2];
//    self.imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [self.textLabel setTextColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    
}

@end
