//
//  MaintainItemCell.m
//  234
//
//  Created by l on 14-6-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MaintainItemCell.h"
#import "AppDelegate.h"
#import "TracingCarViewController.h"
#import "MaintainItem.h"
#import "CustomProgressView.h"

@implementation MaintainItemCell

@synthesize appDelegate;
@synthesize itemName;
@synthesize pastMiles,pastDays;
@synthesize checkbox,defaultConstraint,defaultConstraint2,addConstraints;
@synthesize maintainBtn,itemIndex;

-(void)initialization
{
      //  appDelegate.addMaintainItemName.tag=0;
    [appDelegate loadMaintainItemInitView:NO ItemIndex:itemIndex];
}

-(id) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews=[[NSBundle mainBundle] loadNibNamed:@"MaintainItemCell" owner:self options:nil];
        if ([arrayOfViews count] <1) {
            return nil;
        }
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]] ) {
            return nil;
        }
        
        self=[arrayOfViews objectAtIndex:0];
    }
    return self;
}

-(void) showCheckBoxWithFlag:(Boolean)flag
{
    /*
    if (flag) {
        if([addConstraints count]==0){
            [addConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[checkbox]-10-[itemName]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(checkbox,itemName)]];
           
        }
        [checkbox setHidden:NO];
        defaultConstraint.constant=-28;
        if (itemName.frame.origin.x<33) {
            
        }
    }else{
        [checkbox setHidden:YES];
        [self removeConstraints:addConstraints];
        [self addConstraint:defaultConstraint];
        [self addConstraint:defaultConstraint2];
        if (itemName.frame.origin.x>33) {
        }
    }
    
    */
}

-(void)checkBoxClick:(UIButton *)btn
{
    btn.selected=!btn.selected;
    MaintainItem *item=[appDelegate.maintainItems objectAtIndex:btn.tag];    
    if(btn.selected) {
        
        [item setMTag:1];
    }
    else [item setMTag:0];
  //  NSLog(@"checkbox clicked! item:%@ tag:%d",item.itemName,item.mTag);
}

-(void)initAppDelegate
{
    appDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    [checkbox setImage:[UIImage imageNamed:@"unchecked_mark.png"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"checked_mark.png"] forState:UIControlStateSelected];
    [checkbox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(initialization)];
    addConstraints=[NSMutableArray array];
    
  //  [checkbox setTranslatesAutoresizingMaskIntoConstraints:NO];
  //  [itemName setTranslatesAutoresizingMaskIntoConstraints:NO];
   // [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  //  [leftPercent addGestureRecognizer:tapGestureRecognizer];
  //  [leftPercent initSet];
}
/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      //  [checkbox setHidden:YES];
        // Initialization code
        //appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}  */

@end
