//
//  PartnerManageViewController.m
//  cartracing
//
//  Created by l on 7/9/15.
//
//

#import "PartnerManageViewController.h"
#import "GarageRegisterController.h"
#import "AppDelegate.h"
#import "Garage.h"

@interface PartnerManageViewController ()

@end


@implementation PartnerManageViewController

@synthesize appDelegate, garageRegisterController,checkedGaragesTable,checkGarages;

-(void)loadGarageRegisterViewController
{
    [appDelegate.leftNavigationController pushViewController:garageRegisterController animated:YES ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"业务专属"];
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
    
    UIBarButtonItem *garageRegisterBtn=[[UIBarButtonItem alloc] initWithTitle:@"商家入驻" style:UIBarButtonItemStylePlain target:self action:@selector(loadGarageRegisterViewController)];
    [self.navigationItem setRightBarButtonItem:garageRegisterBtn];
    
    //-----------------
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    garageRegisterController=[[GarageRegisterController alloc] initWithNibName:@"GarageRegisterController" bundle:nil ];
    
    //get garages data
    checkGarages=[NSMutableArray array];
    
    [checkedGaragesTable setBackgroundColor:[UIColor clearColor]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void) getNeedCheckGarages
{
    //  [appDelegate.cars removeAllObjects];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getUncheckedGarage.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"workerTel=%@",appDelegate.ownerTel];
  //  NSLog(@"getCarInfo is work post:%@",post);
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
            NSLog(@"post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
          
            NSError *error;
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSDictionary *dictionary;
            NSString *garageTel,*garageContact,*garageName,*garageShortName,*garageAddr,*garageBusiness,*garageFlag;
        
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                garageTel=[dictionary objectForKey:@"tel"];
                garageContact=[dictionary objectForKey:@"contact"];
                garageName=[dictionary objectForKey:@"name"];
                garageShortName=[dictionary objectForKey:@"shortname"];
                garageBusiness=[dictionary objectForKey:@"business"];
                garageAddr=[dictionary objectForKey:@"addr"];
                garageFlag=[dictionary objectForKey:@"passed"];
                
                Garage *oneGarage=[[Garage alloc] initWithShortName:garageShortName Name:garageName Tel:garageTel Contact:garageContact Business:garageBusiness Addr:garageAddr Flag:[garageFlag intValue] ];
                
            }
            
            
            NSLog(@"get  cars count %ld",[appDelegate.cars count]);
        }
        else NSLog(@"post error!");
    }];
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [checkGarages count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NULL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
