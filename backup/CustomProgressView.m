//
//  CustomProgressView.m
//  234
//
//  Created by l on 5/17/15.
//
//

#import "CustomProgressView.h"

@implementation CustomProgressView
@synthesize progressView,trackView,leftRound,leftProgressView,progressVal;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        progressView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        UIImage *img=[UIImage imageNamed:@"bluebutton_unpressed"];
        [progressView setImage:img];
        [progressView.layer setCornerRadius:5.0f];
        progressView.layer.masksToBounds=YES;
        trackView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        UIImage *img1=[UIImage  imageNamed:@"trackImage"];
        [trackView setImage:img1];
        [self addSubview:trackView];
        [self addSubview:progressView];
        self.clipsToBounds=YES;
        leftRound=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width*0.05, frame.size.height)];
        leftRound.clipsToBounds=YES;
        leftProgressView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        UIImage *img2=[UIImage imageNamed:@"progressImage"];
        [leftProgressView setImage:img2];
        [leftRound setBackgroundColor:[UIColor redColor]];
        [leftRound addSubview:leftProgressView];
     //   [self addSubview:leftRound];
        [self.layer setCornerRadius:5.0f];
        
        NSLog(@"CustomProgressView init");
    }
    return self;
}

-(void) initSet
{
    CGRect frame=self.frame;
    progressView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    UIImage *img=[UIImage imageNamed:@"bluebutton_unpressed"];
    [progressView setImage:img];
    [progressView.layer setCornerRadius:5.0f];
    progressView.layer.masksToBounds=YES;
    trackView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    UIImage *img1=[UIImage  imageNamed:@"trackImage"];
    [trackView setImage:img1];
    [self addSubview:trackView];
    [self addSubview:progressView];
    self.clipsToBounds=YES;
    /*
     leftRound=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width*0.05, frame.size.height)];
     leftRound.clipsToBounds=YES;
     leftProgressView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
     UIImage *img2=[UIImage imageNamed:@"progressImage"];
     [leftProgressView setImage:img2];
     [leftRound setBackgroundColor:[UIColor redColor]];
     [leftRound addSubview:leftProgressView];
     //   [self addSubview:leftRound];
     */
    [self.layer setCornerRadius:5.0f];
}

-(void) rightIndent
{
  //  progressView.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(0.8f, 1.0f), 33.0f, 0);
   //  trackView.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(0.8f, 1.0f), 33.0f, 0);
    self.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(0.8f, 1.0f), 7.0f, 0);
 //   [self reDrawProgressView];
    
}

-(void)restoreFromIndent
{
  //   progressView.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(1.0f, 8.0f), -33.0f, 0);
  //  trackView.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(1.0f, 8.0f), -33.0f, 0);
    self.transform=CGAffineTransformTranslate(CGAffineTransformMakeScale(1.0f, 8.0f), -7.0f, 0);
  //  [self reDrawProgressView];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
   
}


-(void) setProgress:(CGFloat)val
{
    /*
    if (progress==0) {
        [progressView setHidden:YES];
        return;
    } */
    progressVal=val;
    CGFloat dx=((1-progressVal)*progressView.frame.size.width);
  //  progressView.transform=CGAffineTransformMakeTranslation(-dx, 0);
  //  NSLog(@"%f: dx:%f  view.width:%f",progressView.frame.size.width,dx,self.frame.size.width);
  //  [progressView setFrame:CGRectMake(-dx, progressView.frame.origin.y, progressView.frame.size.width, progressView.frame.size.height)];
    progressView.center=CGPointMake(104-dx, progressView.center.y);
 //   CGFloat tx=(progress*progressView.frame.size.width);
 //   [progressView setFrame:CGRectMake(0, 0, tx, progressView.frame.size.height)];
  
  //  progressView.transform=CGAffineTransformScale(progressView.transform, progressVal, 1.0f);
  //  CGFloat dx2=(self.frame.size.width-progressView.frame.size.width)/2;
  //  progressView.transform=CGAffineTransformMakeTranslation(-dx2, 0);
  //  progressView.transform=CGAffineTransformTranslate(CGAffineTransformScale(progressView.transform, progress, 1.0f), -dx, 0);
    return;
}

-(void) showAlertWithTag:(NSInteger)tag
{
    UIImage *img;
    if (tag<0) {
        img=[UIImage imageNamed:@"red_alert"];
    } else img=[UIImage imageNamed:@"bluebutton_unpressed"];
    
    [progressView setImage:img];
}

@end
