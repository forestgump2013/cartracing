//
//  CustomSlider.m
//  234
//
//  Created by l on 5/18/15.
//
//

#import "CustomSlider.h"

@implementation CustomSlider

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
    
}


-(CGRect) minimumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x, bounds.origin.y+5, bounds.size.width, 3*bounds.size.height);
}

-(CGRect) maximumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x, bounds.origin.y+5, bounds.size.width, 3*bounds.size.height);
}


-(CGRect)trackRectForBounds:(CGRect)bounds
{
      return CGRectMake(bounds.origin.x, bounds.origin.y+5, bounds.size.width, 15);
}

@end
