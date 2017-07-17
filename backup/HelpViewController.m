//
//  HelpViewController.m
//  234
//
//  Created by l on 3/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"
//#import "GarageViewController.h"
#import "AppDelegate.h"

@implementation HelpViewController

@synthesize container,appDelegate;//garageRegisterView,

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

-(IBAction)loadGarageRegisterView:(id)sender
{
 //   garageRegisterView.appDelegate=appDelegate;
 //   [container pushViewController:garageRegisterView animated:YES];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // garageRegisterView=[[GarageViewController alloc] initWithNibName:@"GarageViewController" bundle:nil];
    [self setTitle:@"帮助信息"];
    [self.navigationController.navigationBar setHidden:NO];
    
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
   // [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
}

- (void)viewDidUnload
{
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
