//
//  RoundLabel.m
//  234
//
//  Created by l on 5/24/15.
//
//

#import "RoundLabel.h"

@implementation RoundLabel

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
