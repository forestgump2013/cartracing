//
//  GarageSuggestViewController.m
//  cartracing
//
//  Created by l on 10/17/15.
//
//

#import "GarageSuggestViewController.h"
#import "AppDelegate.h"

@interface GarageSuggestViewController ()

@end

@implementation GarageSuggestViewController

@synthesize suggest;

-(void) setOwner:(NSString *)currentOwner Garage:(NSString *)gNum
{
    owner=currentOwner;
    garageNum=gNum;
    NSLog(@"setowner is called garage:%@",garageNum);
}

-(void) commitSuggest{
    //commit suggest info .
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/garageSuggest_Insert.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&suggest=%@&garage=%@",owner,suggest.text,garageNum];
    NSLog(@"post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
                NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"garageSuggest_insert post  successful result:%@",reponseString);
            dispatch_async(dispatch_get_main_queue(), ^{
              //  [appDelegate.navigationController popViewControllerAnimated:NO];
            });
            
            
        }
        else NSLog(@"post error!");
    }];
    [suggest resignFirstResponder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    [self setTitle:@"建议"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    UIBarButtonItem *commitBtn=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitSuggest)];
    [self.navigationItem setRightBarButtonItem:commitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
