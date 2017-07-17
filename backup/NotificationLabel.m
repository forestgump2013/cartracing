//
//  NotificationLabel.m
//  234
//
//  Created by l on 5/29/15.
//
//

#import "NotificationLabel.h"

@implementation NotificationLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(id) initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f]];
        //   [infoBoard setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor whiteColor]];
        [self setFont:[UIFont fontWithName:self.font.fontName size:14]];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:5.0f];
        [self.layer setBorderColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f].CGColor];
        [self.layer setBorderWidth:1.0f];
        [self setText:@"tttttttt"];
        //[self setLayoutMargins:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
        // [infoBoard setTranslatesAutoresizingMaskIntoConstraints:NO];
        //  [infoBoard sizeToFit];
        self.alpha=0;
       // [self.view addSubview:infoBoard];
    }
    return self;
}

-(void) setRootView:(UIWindow *)rootView
{
    [rootView addSubview:self];
}
/*


-(void)  drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
     [super drawLayer:layer inContext:ctx];
    NSLog(@"drawlayer");

}


-(CGRect) textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    NSLog(@"textRectForbounds:%f :%f",bounds.size.width,bounds.size.height);
    return [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    NSLog(@"set frame w%f-h%f",frame.size.width,frame.size.height);
}

-(void) sizeToFit
{
    [super sizeToFit];
    NSLog(@"size to fit");
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
  //   CGSize size=[self intrinsicContentSize];
    CGRect tRect=CGRectMake(rect.origin.x, rect.origin.y, rect.size.width+10, rect.size.height+10);
 //  [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height)];
   [super drawRect:tRect];
    NSLog(@"drawRect width:%f height:%f",rect.size.width,rect.size.height);
}

-(void) drawTextInRect:(CGRect)rect
{
    UIEdgeInsets inset={5,5,5,5};
  //  [super drawTextInRect:UIEdgeInsetsInsetRect(rect, inset)];
    NSLog(@"drawTextInRect.");
  //  CGSize size=[self intrinsicContentSize];
    CGRect tRect=CGRectMake(rect.origin.x, rect.origin.y, rect.size.width+10, rect.size.height+10);
    [super drawTextInRect:tRect];
}

-(CGSize) intrinsicContentSize
{
    CGSize size=[super intrinsicContentSize];
    NSLog(@"inlabel width:%f ,height:%f",size.width,size.height);
    CGSize tSize=CGSizeMake(size.width+10, size.height+10);
    return tSize;
}
*/

-(void) showNotificationWithStr:(NSString *)str
{
    [self setText:str];
    [self sizeToFit];
    //  [infoBoard sizeThatFits:[infoBoard getInsetSize]];
    self.center=CGPointMake(self.superview.center.x, self.center.y);
    [UIView animateWithDuration:1 animations:^{
        self.alpha=1;
        NSLog(@"show warning info");
    }completion:^(BOOL finished){
        //     [infoBoard setHidden:YES];
        [NSThread sleepForTimeInterval:0.8];
        //   infoBoard.alpha=0;
        [UIView animateWithDuration:1.0f animations:^{self.alpha=0;} completion:^(BOOL finished){}];
        
        
        NSLog(@" fading finished.");
    }];
}

-(void) sizeToFit
{
   // [super sizeToFit];
    CGSize size=[self intrinsicContentSize];
    CGRect tRect=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width+10, size.height+10);
    [self setFrame:tRect];
    NSLog(@"size to fit w%f*h%f",self.frame.size.width,self.frame.size.height);
}

-(CGSize) getInsetSize
{
    CGSize size=[self intrinsicContentSize];
    CGSize tSize=CGSizeMake(size.width+10, size.height+10);
    NSLog(@"getInsetSize width:%f ,height:%f",tSize.width,tSize.height);
    return tSize;
}


@end
