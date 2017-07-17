//
//  MaintainItemSetCell.m
//  234
//
//  Created by l on 14-6-26.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MaintainItemSetCell.h"
#import "MaintainItem.h"
#import "HeightClass.h"
#import "AppDelegate.h"
#import "TracingCarViewController.h"

@implementation MaintainItemSetCell

@synthesize itemName,itemDetail,parentTable,height,showBtn,label1;
@synthesize heightArray,selfRow;
@synthesize latestMaintainMiles,latestMaintainDate;
@synthesize lifeMiles,lifeTime;
@synthesize item;
static AppDelegate *appDelegate;

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

-(void) takeOffKeyboard
{
    [latestMaintainMiles resignFirstResponder];
    [lifeMiles resignFirstResponder];
    [lifeTime resignFirstResponder];
    
}

-(void)initWithParentTable:(UITableView *)parent Row:(NSInteger)row HeightArray:(NSMutableArray *)array
{
    parentTable=parent;
    
    selfRow=row;
    heightArray=array;
    
    latestMaintainDate.inputView=appDelegate.tracingCarViewController.customInput;
    latestMaintainDate.inputAccessoryView=appDelegate.tracingCarViewController.accessoryView;
  //  [itemDetail setText:@""];
    /*
    itemDetail.numberOfLines=0;
 //   [itemDetail setHidden:YES];
    HeightClass *heightObject=[heightArray objectAtIndex:selfRow];
    if (heightObject.height>100) {
        [itemDetail setHidden:NO];
    } else [itemDetail setHidden:YES];
    */
    
}

-(void) initAppDelegate:(AppDelegate *)apd
{
    appDelegate=apd;
}

-(IBAction)showItemDetail:(id)sender
{
    
    HeightClass *heightObject=[heightArray objectAtIndex:selfRow];
    
    if (heightObject.height==219) {
        if (item.itemId<20) {
            [self.itemDetail setText:[appDelegate.itemDetails objectAtIndex:(item.itemId-1)]];
        } else [self.itemDetail setText:@"自定义项目"];
        
         [itemDetail sizeToFit];
        heightObject.height=219+itemDetail.frame.size.height+5;
        [showBtn setImage:[UIImage imageNamed:@"open_mark"] forState:UIControlStateNormal];
        [showBtn setImage:[UIImage imageNamed:@"open_mark"] forState:UIControlStateHighlighted];
    } else {
        [self.itemDetail setText:@""];
        [itemDetail sizeToFit];
        heightObject.height=219;
        [showBtn setImage:[UIImage imageNamed:@"close_mark"] forState:UIControlStateNormal];
        [showBtn setImage:[UIImage imageNamed:@"close_mark"] forState:UIControlStateHighlighted];
    }
    
     /*
    CGRect frame=self.itemDetail.frame;
    [self.itemDetail setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 4)];
    [itemDetail layoutIfNeeded];
    [label1 layoutIfNeeded];
    */
    
    
    [parentTable reloadData];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==latestMaintainMiles) {
        [item setLatestMaintainMiles:[[textField.text stringByReplacingCharactersInRange:range withString:string] intValue]];
    } else if (textField==lifeMiles  ){
        [item setLifeMiles:[[textField.text stringByReplacingCharactersInRange:range withString:string] intValue]];
    } else if (textField==latestMaintainDate  ){
        [item setLatestMaintainDate:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    } else if (textField==lifeTime  ){
        [item setLifeTime:[[textField.text stringByReplacingCharactersInRange:range withString:string] floatValue]*12 ];
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==latestMaintainDate) {
        appDelegate.tracingCarViewController.customInput.tag=3;
        appDelegate.currentInputDate=latestMaintainDate;
        appDelegate.currentEditItem=item;
    }
}

@end
