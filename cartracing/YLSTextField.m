//
//  YLSTextField.m
//  cartracing
//
//  Created by l on 11/13/15.
//
//

#import "YLSTextField.h"

@implementation YLSTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGRect) leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect=[super leftViewRectForBounds:bounds];
    iconRect.origin.x+=5;
    return iconRect;
}

@end
