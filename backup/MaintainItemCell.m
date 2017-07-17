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
@synthesize leftPercent,milesLeftPercent,timeLeftPercent;
@synthesize checkbox;
@synthesize maintainBtn,itemIndex;

-(void)maintain
{
  //  MaintainItemCell *cell=(MaintainItemCell*) maintainBtn.superview.superview;
   // NSLog(@"row=%d",leftPercent.tag);
    MaintainItem *item=[appDelegate.maintainItems objectAtIndex:leftPercent.tag]; 
    [item setMTag:1];
    if (item.applyMark>0) {
        
    //    appDelegate.addMaintainItemName.tag=0;
        [appDelegate.tracingCarViewController loadMaintainView:item];
    }else{
        appDelegate.itemInitItemName.tag=leftPercent.tag;
        appDelegate.addMaintainItemName.tag=0;
        [appDelegate loadMaintainItemInitView:nil];
    }
    
   
}

-(void) showCheckBoxWithFlag:(Boolean)flag
{
    if (flag) {
        [checkbox setHidden:NO];        
        if (itemName.frame.origin.x<33) {
            
        //    CGRect tmpFrame=itemName.frame;
        //    tmpFrame.origin.x=tmpFrame.origin.x+33;
         //   [itemName setFrame:tmpFrame];
            itemName.transform=CGAffineTransformMakeTranslation(23, 0);
            milesLeftPercent.transform=CGAffineTransformMakeTranslation(10, 0);
     //       tmpFrame=leftPercent.frame;
            
     //       tmpFrame=CGRectMake(leftPercent.frame.origin.x+33, leftPercent.frame.origin.y, leftPercent.frame.size.width, leftPercent.frame.size.height);
        //    [leftPercent setFrame:tmpFrame];
        //    leftPercent.transform=CGAffineTransformMakeTranslation(33, 0);
           
         //   leftPercent.transform=CGAffineTransformMakeScale(0.8f, 8.0f);
         //   leftPercent.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(0.8f, 8.0f), 33.0f, 0);
            [leftPercent rightIndent];
            
        }
    }else{
        [checkbox setHidden:YES];
        if (itemName.frame.origin.x>33) {
          //  [checkbox setHidden:YES];
        //    CGRect tmpFrame=itemName.frame;
        //    tmpFrame.origin.x=tmpFrame.origin.x-33;
         //   [itemName setFrame:tmpFrame];
            itemName.transform=CGAffineTransformMakeTranslation(-23, 0);
            milesLeftPercent.transform=CGAffineTransformMakeTranslation(-10, 0);
         //   tmpFrame=leftPercent.frame;
            
         //   tmpFrame=CGRectMake(leftPercent.frame.origin.x-33, leftPercent.frame.origin.y, leftPercent.frame.size.width, leftPercent.frame.size.height);
          //  [leftPercent setFrame:tmpFrame];
          //  leftPercent.transform=CGAffineTransformMakeTranslation(-33, 0);
         //   leftPercent.frame.origin.x-=33;
        //   leftPercent.transform=CGAffineTransformMakeScale(1.0f, 8.0f);
        //    leftPercent.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(1.0f, 8.0f), -33.0f, 0);
        //    [leftPercent.layer setCornerRadius:5.0f];
            [leftPercent restoreFromIndent];
        }
    }
}

-(void)checkBoxClick:(UIButton *)btn
{
    btn.selected=!btn.selected;
    MaintainItem *item=[appDelegate.maintainItems objectAtIndex:btn.tag];    
    if(btn.selected) {
        
      //  item.mTag=1;
        [item setMTag:1];
    }
    else [item setMTag:0];
  //  NSLog(@"checkbox clicked! item:%@ tag:%d",item.itemName,item.mTag);
}

-(void)initAppDelegate
{
    appDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    [checkbox setImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"checkbox_on.png"] forState:UIControlStateSelected];
    [checkbox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(maintain)];
  //  leftPercent=[[CustomProgressView alloc] initWithFrame:CGRectMake(89, 20, appDelegate.screenWidth*0.7, 20)];
 //   [leftPercent setFrame:CGRectMake(leftPercent.frame.origin.x, leftPercent.frame.origin.y, leftPercent.frame.size.width, leftPercent.frame.size.height+10)];
 //   UIImage *imgTrack=[UIImage imageNamed:@"progressview_background.png"];
 //   UIImage *imgProgress=[UIImage imageNamed:@"bluebutton_unpressed.png"];
  //  leftPercent.transform=CGAffineTransformMakeScale(1.0f, 8.0f);
  //  [leftPercent setProgressImage:imgProgress];
   // [leftPercent setTrackImage:imgTrack];
  //  [leftPercent setProgressTintColor:[UIColor colorWithRed:0 green:126/255 blue:197/255 alpha:1.0f]];
//    [leftPercent setTintColor:[UIColor clearColor]];
 //   [leftPercent setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bluebutton_unpressed.png"]]];
  //  [leftPercent.layer setCornerRadius:5.0f];
    [leftPercent addGestureRecognizer:tapGestureRecognizer];
   // [leftPercent setProgressImage:[UIImage imageNamed:@"progressview.png"]];
  //  NSLog(@"initWithStyle is worked");
   // [self adds ];
    [leftPercent initSet];
}

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
}

@end
