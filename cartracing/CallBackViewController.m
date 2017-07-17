//
//  CallBackViewController.m
//  234
//
//  Created by l on 7/30/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//


#import "AppDelegate.h"
#import "CallBackViewController.h"
#import "TopicItem.h"

@implementation CallBackViewController
@synthesize appDelegate;
@synthesize callBackInfo;
//@synthesize contact,button;

-(IBAction)returnMainView:(id)sender
{
    /*
    UIView *mainView=appDelegate.navigationController.view;
    [UIView animateWithDuration:1.0 animations:^{
        mainView.center=CGPointMake(mainView.center.x+160, mainView.center.y);
    }];
    [appDelegate.leftNavigationController popViewControllerAnimated:YES];
    */
   // [button.titleLabel setText:@"提交成功"];
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
  //  self.title=@"";
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
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
    
  //  [button.titleLabel setText:@"确定"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    UIBarButtonItem *sendBtn=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(commitInfo)];
    self.navigationItem.rightBarButtonItem=sendBtn;
    
    
}

- (void)viewDidUnload
{
    [self setCallBackInfo:nil];
 //   [self setContact:nil];
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

-(void)setFromFlag:(NSInteger)flag Items:(NSMutableArray *)is Topic:(TopicItem *)im
{
    fromFlag=flag;
    items=is;
    topic=im;
    if (fromFlag==0) {
        [self setTitle:@"发贴"];
    }else [self setTitle:@"发评论"];
}

-(void) commitInfo
{
    if (fromFlag==0) {
        [self sendOneTopic];
    } else [self sendOneComment];
}

-(void) sendOneTopic
{
    if ([callBackInfo.text isEqualToString:@""] ) {
        [appDelegate showNotification:@"请输入信息！"];
    }
    
    TopicItem *item=[[TopicItem alloc] initWithItemID:[items count] FollowID:0 Talker:appDelegate.ownerTel Topic:callBackInfo.text Date:[appDelegate.dateFormatter stringFromDate:[NSDate date]]];
    // send one topic
    NSURL *url=[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@postCommunityTopic.php",appDelegate.serverAddr ]];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"raiser=%@&topic=%@",appDelegate.ownerTel,callBackInfo.text];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
    if(error==nil)
    {
       // NSLog(@"postCommunityTopic successful");
        NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"postCommunityTopic response:%@",reponseString);
        [items insertObject:item atIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [appDelegate.leftNavigationController popViewControllerAnimated:YES];
        });
        
    }
    else NSLog(@"post error!");
    }];

}

-(void) sendOneComment
{
    if ([callBackInfo.text isEqualToString:@""] ) {
        [appDelegate showNotification:@"请输入信息！"];
    }
    TopicItem *item=[[TopicItem alloc] initWithItemID:[items count] FollowID:[topic getItemID] Talker:appDelegate.ownerTel Topic:callBackInfo.text Date:[appDelegate.dateFormatter stringFromDate:[NSDate date]]];
    
    // send one comment
    NSURL *url=[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@postCommunityComment.php",appDelegate.serverAddr ]];
    NSString *post=nil;
    
    post=[NSString stringWithFormat:@"sid=%d&echor=%@&comment=%@",(int)[topic getItemID],appDelegate.ownerTel,callBackInfo.text];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [   request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            // NSLog(@"postCommunityTopic successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"postCommunityComment response:%@",reponseString);
            [items insertObject:item atIndex:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [appDelegate.leftNavigationController popViewControllerAnimated:YES];
            });
        }
        else NSLog(@"post error!");
    }];
}

@end
