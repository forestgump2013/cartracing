//
//  RoundCornorView.m
//  234
//
//  Created by l on 5/19/15.
//
//

#import "RoundCornorView.h"

@implementation RoundCornorView

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
}


@end
