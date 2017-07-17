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

@synthesize appDelegate, garageRegisterController,checkedGaragesTable,checkGarages,passedGarages;
@synthesize checkedBtn,unCheckedBtn,selfInfoLabel,detailAlert;

-(void)loadGarageRegisterViewController
{
    [appDelegate.leftNavigationController pushViewController:garageRegisterController animated:YES ];
}

-(void) addUnCheckedGarage:(Garage *)garage
{
    [checkGarages addObject:garage];
    [checkedGaragesTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"partner view viewDidLoad ");
    [self setTitle:@"业务专属"];
    [self.navigationController.navigationBar setHidden:NO];
    
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
    passedGarages=[NSMutableArray array];
    indicator=0;
    [selfInfoLabel setText:appDelegate.ownerTel];
  //  [self getNeedCheckGarages];
    [self getAllGarages];
    
    [checkedGaragesTable setBackgroundColor:[UIColor clearColor]];
    UIView *tableFootView=[[UIView alloc] init];
    [tableFootView setBackgroundColor:[UIColor clearColor]];
    tableFootView.layer.masksToBounds=YES;
    tableFootView.layer.cornerRadius=5.0f;
    [checkedGaragesTable setTableFooterView:tableFootView];
    [checkedGaragesTable setTableHeaderView:tableFootView];
    buttonTitle=@"通过";
    _checkAlert=[[UIAlertView alloc] initWithTitle:@"审查信息" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:buttonTitle, nil];
    detailAlert=[[UIAlertView alloc] initWithTitle:@"查看详情" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    NSLog(@"partner manager view controller viewDidAppear ");
    [super viewDidAppear:animated];
  //  [checkedGaragesTable reloadData];
    
}

-(void) viewWillAppear:(BOOL)animated
{
     NSLog(@"partner manager view controller viewWillAppear ");
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
}

-(void)viewDidLayoutSubviews
{
    if ([checkedGaragesTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [checkedGaragesTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([checkedGaragesTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [checkedGaragesTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(IBAction)showGarages:(id)sender{
    
    if (sender==checkedBtn) {
        indicator=1;
    }else indicator=0;
    [checkedGaragesTable reloadData];
    
}

-(void) checkGarageWithIndex:(NSInteger)index
{
    Garage *garage=[checkGarages objectAtIndex:index];
    
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@check_garage.php" ,appDelegate.serverAddr];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"garage_id=%@",garage.id_code];
    //  NSLog(@"getCarInfo is work post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
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
            //    NSLog(@"post successful");
           NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"check_garage reponseString:%@",reponseString);
            dispatch_async(dispatch_get_main_queue(), ^{
                //   NSLog(@"this printf in main thread.");
                [checkGarages removeObjectAtIndex:index];
                [passedGarages addObject:garage];
                [checkedGaragesTable reloadData];
            });
            /*
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            if(jsonObject!=nil)
            {
              //  NSError *error;
              //  NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                //   NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
          
                
                    
            } */
            
            
        }
        else NSLog(@"post error!");
    }];
    
    
    
}

-(void) getAllGarages
{
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@getAllGarages.php" ,appDelegate.serverAddr];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&password=%@",appDelegate.ownerTel,@""];
  //  NSLog(@"getCarInfo is work post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
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
        //    NSLog(@"post successful");
        //    NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //    NSLog(@"get all garages reponseString:%@",reponseString);
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            if(jsonObject!=nil)
            {
                NSError *error;
                NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                //   NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
                //   NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
                NSDictionary *dictionary;
                NSString *garageTel,*garageContact,*garageName,*garageShortName,*garageAddr,*garageBusiness,*garageFlag,*garageID,*pay_cost,*validity_days,*register_date;
           //     NSLog(@"garages count:%ld",[arr count]);
                for(int i=0;i<[arr count]; i++)
                {
                    dictionary=[arr objectAtIndex:i];
                    garageID=[dictionary objectForKey:@"id"];
                    garageTel=[dictionary objectForKey:@"tel"];
                    garageContact=[dictionary objectForKey:@"contact"];
                    garageName=[dictionary objectForKey:@"name"];
                    garageShortName=[dictionary objectForKey:@"shortname"];
                    garageBusiness=[dictionary objectForKey:@"business"];
                    garageAddr=[dictionary objectForKey:@"addr"];
                    garageFlag=[dictionary objectForKey:@"passed"];
                    pay_cost=[dictionary objectForKey:@"pay_cost"];
                    validity_days=[dictionary objectForKey:@"validated_days"];
                    register_date=[dictionary objectForKey:@"register_date"];
                    Garage *oneGarage=[[Garage alloc] initWithShortName:garageShortName Name:garageName Tel:garageTel Contact:garageContact Business:garageBusiness Addr:garageAddr Flag:[garageFlag intValue] ];
                    oneGarage.id_code=garageID;
                    oneGarage.register_date=register_date;
                    oneGarage.expire_date=[appDelegate getEndDate:register_date life:[validity_days integerValue]];
                    [oneGarage setPayInfo:[pay_cost floatValue] validityTime:[validity_days integerValue]];
            //        NSLog(@"garage:%@",[oneGarage getCheckInfo]);
                    if (oneGarage.passed==2) {
                        [passedGarages addObject:oneGarage];
                    } else [checkGarages addObject:oneGarage];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //   NSLog(@"this printf in main thread.");
                        [checkedGaragesTable reloadData];
                    });
                    
                }
            }
            
            
        }
        else NSLog(@"post error!");
    }];
    
}

-(void) getNeedCheckGarages
{
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@getCarInfo.php" ,appDelegate.serverAddr];
    NSURL *url=[NSURL URLWithString:urlStr];
                      //                http://www.qcygl.com/getCarInfo.php
    NSString *post=nil;
 //   post=[NSString stringWithFormat:@"workerTel=%@",appDelegate.ownerTel];
  //  NSLog(@"getCarInfo is work post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
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
            
         //   NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //    id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       //   NSLog(@"getAllGarages post successful result:@",reponseString);
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
                if (oneGarage.passed==2) {
                    [passedGarages addObject:oneGarage];
                } else [checkGarages addObject:oneGarage];
                dispatch_async(dispatch_get_main_queue(), ^{
                 //   NSLog(@"this printf in main thread.");
                    [checkedGaragesTable reloadData];
                });
                
            }
       //     NSLog(@"get  passedGarages count %ld",[passedGarages count]);
        }
        else NSLog(@"post error!");
    }];
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (indicator==0) {
        return [checkGarages count];
    }else return [passedGarages count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row;
    Garage *garage;
    NSString *identifier;
    identifier=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==Nil) {
        //  cell=[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    row=[indexPath row];
    if (indicator==0) {
        garage=[checkGarages objectAtIndex:row];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }else {
        garage=[passedGarages objectAtIndex:row];
         [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    [cell.textLabel setText:[garage getCheckInfo]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    Garage *garage=[checkGarages objectAtIndex:row];
    if (indicator==0) {
        buttonTitle=@"通过";
        [_checkAlert setTag:[indexPath row]];
        [_checkAlert setMessage:[garage getCheckInfo ]];
        [_checkAlert show];
    } else{
        
        [detailAlert setMessage:[garage getDetailInfo]];
         [detailAlert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSInteger row=_checkAlert.tag;
      //  Garage *garage=[checkGarages objectAtIndex:row];
        [self checkGarageWithIndex:row];
        
    }
    
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
