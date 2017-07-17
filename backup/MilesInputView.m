//
//  MilesInputView.m
//  234
//
//  Created by l on 8/19/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MilesInputView.h"

@implementation MilesInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect btnFrame=CGRectMake(0, 0, frame.size.width, 30);
        addBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        addBtn.frame=btnFrame;
        [addBtn setBackgroundColor:[UIColor colorWithRed:24/255.0f green:35/255.0f blue:41/255.0f alpha:1.0f]];
        [addBtn.titleLabel setTextColor:[UIColor whiteColor]];
        number=[[UILabel alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 30)];
        [number setTextAlignment:NSTextAlignmentCenter];
        [number setBackgroundColor:[UIColor whiteColor]];
        
        btnFrame=CGRectMake(0, 60, frame.size.width, 30);
        subBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        subBtn.frame=btnFrame;
        [subBtn setBackgroundColor:[UIColor colorWithRed:24/255.0f green:35/255.0f blue:41/255.0f alpha:1.0f]];
        [subBtn.titleLabel setTextColor:[UIColor whiteColor]];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(incNumber) forControlEvents:UIControlEventTouchUpInside];
        [subBtn setTitle:@"-" forState:UIControlStateNormal];  
        [subBtn addTarget:self action:@selector(decNumber) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        [self addSubview:number];
        [self addSubview:subBtn];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:2.5f];
        [self.layer setBorderWidth:0.5f];
        [self.layer setBorderColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f].CGColor];
    }
    return self;
}

-(id) initwithPos_X:(NSInteger)x Pos_y:(NSInteger)y Width:(CGFloat)width
{
    CGRect frame=CGRectMake(x, y, width, 90);
    return [self initWithFrame:frame];
}

-(void)setNumber:(NSInteger)num
{
    NSLog(@"set number %d",num);
    number.text=[NSString stringWithFormat:@"%d",num];
}

-(NSInteger)getNumber
{
    return [number.text intValue];
}

-(void) incNumber
{
    NSInteger num=[number.text intValue];
    num=(num+1)%10;
    [number setText:[NSString stringWithFormat:@"%d",num]];
}

-(void) decNumber
{
    NSInteger num=[number.text intValue];
    num=(num+10-1)%10;
    [number setText:[NSString stringWithFormat:@"%d",num]];    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
