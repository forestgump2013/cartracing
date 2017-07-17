//
//  CallBackViewController.m
//  234
//
//  Created by l on 7/30/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//


#import "AppDelegate.h"
#import "CallBackViewController.h"

@implementation CallBackViewController
@synthesize appDelegate;
@synthesize callBackInfo;
@synthesize contact,button;

-(IBAction)returnMainView:(id)sender
{
    /*
    UIView *mainView=appDelegate.navigationController.view;
    [UIView animateWithDuration:1.0 animations:^{
        mainView.center=CGPointMake(mainView.center.x+160, mainView.center.y);
    }];
    [appDelegate.leftNavigationController popViewControllerAnimated:YES];
    */
    [button.titleLabel setText:@"提交成功"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"反馈";
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:NO];
    
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
    [button.titleLabel setText:@"确定"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    
}

- (void)viewDidUnload
{
    [self setCallBackInfo:nil];
    [self setContact:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
