//
//  CustomTextField.m
//  234
//
//  Created by l on 5/19/15.
//
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) drawPlaceholderInRect:(CGRect)rect
{
   // [[UIColor orangeColor] setFill];
  //  [self.placeholder setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    if (self.placeholder) {
        UIColor *placeholderTextColor=[UIColor whiteColor];
        CGSize drawSize=[self.placeholder sizeWithAttributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName]];
        CGRect drawRect=rect;
        drawRect.origin.y=(rect.size.height-drawSize.height)*0.5;
        
        NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment=self.textAlignment;
        
        NSDictionary *textAttribute=@{NSFontAttributeName:self.font,
                                      NSParagraphStyleAttributeName:paragraphStyle,
                                      NSForegroundColorAttributeName:placeholderTextColor
                                      };
        [self.placeholder drawInRect:drawRect withAttributes:textAttribute];
    }
   
}

@end
