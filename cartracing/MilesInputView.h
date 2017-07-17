//
//  MilesInputView.h
//  234
//
//  Created by l on 8/19/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MilesInputView : UIView
{
    UIButton *addBtn,*subBtn;
    UILabel *number;
}

-(id) initwithPos_X:(NSInteger) x  Pos_y:(NSInteger) y Width:(CGFloat) width;

-(void) setNumber:(NSInteger)num;
-(NSInteger) getNumber;

-(void) incNumber;
-(void) decNumber;

@end
