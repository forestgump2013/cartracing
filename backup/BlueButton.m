//
//  BlueButton.m
//  234
//
//  Created by l on 5/14/15.
//
//

#import "BlueButton.h"

@implementation BlueButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=5.0f;
    [self setBackgroundImage:[UIImage imageNamed:@"bluebutton_unpressed"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"bluebutton_pressed"] forState:UIControlStateHighlighted];
    [self setTintColor:[UIColor whiteColor]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
}

@end
