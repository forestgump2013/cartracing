//
//  MoveLabel.m
//  234
//
//  Created by l on 9/18/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MoveLabel.h"


@implementation MoveLabel

-(void)setText:(NSString *)str
{
    [label setText:str];
 //   [label sizeToFit];
   // CGSize size=CGSizeMake(900, label.frame.size.height);
    stringWidth=label.intrinsicContentSize.width;
    if (stringWidth<width) {
        stringWidth=width;
    }else{
        [label setFrame: CGRectMake(0, 0, stringWidth+2, 23)];
    }
    NSLog(@"string width:%f",stringWidth);
    
    
}

-(void)_handTimer
{
   // NSLog(@"_handtimer");
    if (label.center.x>(-stringWidth/2)) {
        label.center=CGPointMake(label.center.x-1, label.center.y);
    } else label.center=CGPointMake(width+stringWidth/2, label.center.y);
}



-(void)_start
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (isMoving) {
            return;
        }
        isMoving=TRUE;
        label.center=CGPointMake(width+stringWidth/2, label.center.y);
        
        while (isMoving) {
            NSLog(@"moveing");
            [UIView animateWithDuration:3.0f animations:^{
                label.center=CGPointMake(-stringWidth/2, label.center.y);
            } completion:^(BOOL finish){
                label.center=CGPointMake(width+stringWidth/2, label.center.y);
            }];
            [NSThread sleepForTimeInterval:3.3f];
            
        }
    });
    
   
}
-(void)start
{
    /*
    label.center=CGPointMake(width+stringWidth/2, label.center.y);
    [UIView animateWithDuration:5.0f animations:^{
        label.center=CGPointMake(-stringWidth/2, label.center.y);
    } completion:^(BOOL finish){
      //  [self start];
        NSLog(@"moveing end");
        
    }];
     */
  //  [NSThread detachNewThreadSelector:@selector(_start) toTarget:self withObject:nil];
    
    if (timer==nil) {
        NSLog(@"timer==nil start Timer");
        timer=[NSTimer scheduledTimerWithTimeInterval:0.025f target:self selector:@selector(_handTimer) userInfo:nil repeats:YES];
    }
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)selfReInit
{
    
    // Initialization code
    CGRect frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    label=[[UILabel alloc] initWithFrame:frame];
    [self addSubview:label];
    isMoving=FALSE;
    width=self.frame.size.width;
    [self setBackgroundColor:[UIColor clearColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"Arial" size:14]];
  //  label.center=CGPointMake(self.center.x+width, label.center.y);
        [self setClipsToBounds:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
