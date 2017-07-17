//
//  RespairSubItemCell.m
//  234
//
//  Created by l on 2/7/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RespairSubItemCell.h"
#import "RespairSubItem.h"

@implementation RespairSubItemCell
@synthesize name;
@synthesize cost1,cost2,subItem,totalCost;

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

-(void)setEditingStyle
{
    [name setBorderStyle:UITextBorderStyleNone];
    [cost1 setBorderStyle:UITextBorderStyleNone];
    [cost2 setBorderStyle:UITextBorderStyleNone];
    [name setEnabled:YES];
    [cost1 setEnabled:YES];
    [cost2 setEnabled:YES];
    
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==cost1 || textField==cost2) {
        NSLog(@"textFieldDidBeginEditing");
        currentTotalCost=[totalCost.text floatValue];        
    }
    
}

-(void)returnKeyBoard
{
    [self.name resignFirstResponder];
    [self.cost1 resignFirstResponder];
    [self.cost2 resignFirstResponder];
}


-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==cost1) {
        tempCost=[[cost1.text stringByReplacingCharactersInRange:range withString:string] floatValue];        
        [subItem setCost1:tempCost];
        /*
        if (first) {
            first=false;
            currentTotalCost=[totalCost.text floatValue];
        } */
        [totalCost setText:[[NSString alloc] initWithFormat:@"%.1f",currentTotalCost+tempCost]];
    } else if(textField==cost2){
        tempCost=[[cost2.text stringByReplacingCharactersInRange:range withString:string] floatValue];             
        [subItem setCost2:tempCost];
        /*
        if (first) {
            first=false;
            currentTotalCost=[totalCost.text floatValue];
        } */
        [totalCost setText:[[NSString alloc] initWithFormat:@"%.1f",currentTotalCost+tempCost]];        
        
    }else if(textField==name){
        [subItem setName:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    }
    return YES;    
    
}

@end
