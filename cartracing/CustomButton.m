//
//  CustomButton.m
//  234
//
//  Created by l on 5/11/15.
//
//

#import "CustomButton.h"

@implementation CustomButton

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
    [self.layer setBorderColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f].CGColor];
    self.layer.cornerRadius=5.0f;
    self.layer.masksToBounds=YES;
    [self.layer setBorderWidth:1.0f];
    
}


@end
