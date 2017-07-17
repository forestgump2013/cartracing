//
//  MoveLabel.h
//  234
//
//  Created by l on 9/18/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveLabel : UIView
{
    UILabel *label;
    BOOL isMoving;
    CGFloat width,stringWidth;
    NSTimer *timer;
}
-(void) selfReInit;
-(void)setText:(NSString*)str;
-(void)_start;
-(void)_handTimer;
-(void)start;

@end
