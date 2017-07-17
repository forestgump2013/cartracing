//
//  PeccancyViewController.m
//  cartracing
//
//  Created by l on 4/14/16.
//
//

#import "PeccancyViewController.h"
#import "AppDelegate.h"

@interface PeccancyViewController ()

@property(nonatomic,retain) IBOutlet UIButton *backBtn;
@property(nonatomic,retain) AppDelegate *appDelegate;

@end

@implementation PeccancyViewController

@synthesize appDelegate,backBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    //加载网页的方式
    //1.创建并加载远程网页
    NSURL *url = [NSURL URLWithString:@"http://m.cheshouye.com/api/weizhang/?t=212d36"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    //2.加载本地文件资源
    /* NSURL *url = [NSURL fileURLWithPath:filePath];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [webView loadRequest:request];*/
    //3.读入一个HTML，直接写入一个HTML代码
    //NSString *htmlPath = [[[NSBundle mainBundle]bundlePath]stringByAppendingString:@"webapp/loadar.html"];
    //NSString *htmlString = [NSString stringWithContentsOfURL:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    //[webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
    
    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
    
    //---
    [backBtn setBackgroundImage:[appDelegate image:[UIImage  imageNamed:@"slidedown.png"] rotation:UIImageOrientationRight] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[appDelegate image:[UIImage  imageNamed:@"slidedown.png"] rotation:UIImageOrientationRight] forState:UIControlStateHighlighted];
    
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewDidLayoutSubviews
{
    /*
    if (backBtn.tag>20) {
        //have setted.
        return;
    } */
    // adjust backBtn.
    CGRect rectStatus=[[UIApplication sharedApplication] statusBarFrame];
    CGRect frame=backBtn.frame;
    CGPoint center=  backBtn.center;
    
    center.y+=rectStatus.size.height;
    frame.origin.y=(rectStatus.size.height+(50-frame.size.height)/2);
    [backBtn setFrame:frame];
    [backBtn setTag:frame.origin.y];
    NSLog(@"frame y %d ",(int)backBtn.frame.origin.y);
    //  [backBtn setCenter:center ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicatorView startAnimating];
    opaqueView.hidden = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicatorView startAnimating];
    opaqueView.hidden = YES;
}

//UIWebView如何判断 HTTP 404 等错误
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [NSURL URLWithString:@"http://m.cheshouye.com/api/weizhang/?t=0a3278"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2)) {
        // self.earthquakeData = [NSMutableData data];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [ webView loadRequest:[ NSURLRequest requestWithURL: url]];
        webView.delegate = self;
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        
        if ([error code] == 404) {
            NSLog(@"xx");
            webView.hidden = YES;
        }
        
    }
}

-(IBAction)backward:(id)sender
{
    [appDelegate.leftNavigationController popViewControllerAnimated:YES];
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
