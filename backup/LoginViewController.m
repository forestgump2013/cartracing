//
//  LoginViewController.m
//  234
//
//  Created by l on 8/4/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "CarOwnerRegisterViewController.h"
#import "AppDelegate.h"
#import "TracingCarViewController.h"
#import "Car.h"
#import "Garage.h"
#import "MaintainItem.h"
#import "MaintainRecord.h"
#import "FuelingItem.h"
#import "RespairItem.h"
#import "NotificationLabel.h"

@implementation LoginViewController
@synthesize owner;
@synthesize password;
@synthesize rTel;
@synthesize rPassword;
@synthesize rGarage;
@synthesize activityIndicatorView;
@synthesize msgBoard;
@synthesize appDelegate,scrollView,carOwnerRegisterViewController;

-(void)waitWait
{
    NSLog(@"I am wait 1 second!");
}

-(void)getCarInfo
{
  //  [appDelegate.cars removeAllObjects];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getCarInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&password=%@",ownerTel,@""];
    NSLog(@"getCarInfo is work post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    /*
     NSHTTPURLResponse *response=nil;
     NSError *error=[[NSError alloc] init];
     
     NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     if (error) {
     NSLog(@"Something wrong: %@",[error description]);
     }else {
     if (responseData) {
     NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
     NSLog(@"get %@",responseString);   */ 
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSLog(@"post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            if(jsonObject!=nil)
            {
                NSError *error;
                NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                //   NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
                //   NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
                NSDictionary *dictionary;
                NSString *car_code,*license,*brand,*current_miles,*init_miles,*oilBoxVolumn,*total_oilVolume,*total_fuelingCost,*fuelingInfo,*flag;
                //    NSLog(@"carInfo counts %ld  data%@",[arr count],reponseString);
                [appDelegate.cars removeAllObjects];
                Car *car;
                for(int i=0;i<[arr count]; i++)
                {
                    dictionary=[arr objectAtIndex:i];
                    car_code=[dictionary objectForKey:@"code"];
                    license=[dictionary objectForKey:@"license"];
                    brand=[dictionary objectForKey:@"brand"];
                    current_miles=[dictionary objectForKey:@"current_miles"];
                    init_miles=[dictionary objectForKey:@"init_miles"];
                    oilBoxVolumn=[dictionary objectForKey:@"oilbox_volume"];
                    total_oilVolume=[dictionary objectForKey:@"total_oilvolume"];
                    total_fuelingCost=[dictionary objectForKey:@"fueling_cost"];
                    fuelingInfo=[dictionary objectForKey:@"fueling_info"];
                    flag=[dictionary objectForKey:@"flag"];
                    car=[[Car alloc] initWithCarId:[car_code intValue] currentMiles:[current_miles intValue] license:license brand:brand Flag:[flag integerValue] ];
                    [car setfuelingConcernedInfoWithInitMiles:[init_miles intValue] BoxVolume:[oilBoxVolumn intValue] TotalVolume:[total_oilVolume floatValue] TotalFuelingCost:[total_fuelingCost floatValue] FuelingInfo:fuelingInfo ];
                    [car initOilConsumeRecordsWithFuelingInfo];
                    //   [appDelegate.cars addObject:car];
                    [appDelegate insertNewCar:car];
                    
                }
            }
            
            waitLevel++;
            if (waitLevel==5) {
                [self performSelectorOnMainThread:@selector(dealWithData) withObject:nil waitUntilDone:YES];
            }
            
            NSLog(@"get  cars count %ld",[appDelegate.cars count]);
        }
        else NSLog(@"post error!");
    }];    
}

-(void)getMaintainInfo
{
  //  [appDelegate.maintainItems removeAllObjects];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getMaintainInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&password=%@",ownerTel,@""];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    /*
      NSHTTPURLResponse *response=nil;
      NSError *error=[[NSError alloc] init];
    
     NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     if (error) {
     NSLog(@"Something wrong: %@",[error description]);
     }else {
     if (responseData) {
     NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
     NSLog(@"get %@",responseString);   */ 
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            
           NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"commit data to get maintaininfo successful,response:%@",reponseString);
            if(reponseString!=nil && ![reponseString isEqualToString:@""])
            {
                NSLog(@" analysis maintain data");
                NSError *error;
                NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                NSDictionary *dictionary;
                NSString *car_code,*item_id,*itemname,*lifemiles,*latestmiles,*leftpercent,*leftMiles,*latestMaintainDate,*lifeTime,*leftDays,*applyMark;
                NSLog(@"maintianInfo count %ld",[arr count]);
                MaintainItem *item;
                for(int i=0;i<[arr count]; i++)
                {
                    dictionary=[arr objectAtIndex:i];
                    car_code=[dictionary objectForKey:@"car_code"];
                    item_id=[dictionary objectForKey:@"id"];
                    itemname=[dictionary objectForKey:@"itemname"];
                    lifemiles=[dictionary objectForKey:@"lifemiles"];
                    latestmiles=[dictionary objectForKey:@"latestupdatedmiles"];
                    leftpercent=[dictionary objectForKey:@"leftpercent"];
                    leftMiles=[dictionary objectForKey:@"safemiles"];
                    lifeTime=[dictionary objectForKey:@"time_interval"];
                    latestMaintainDate=[dictionary objectForKey:@"latestupdateddate"];
                    leftDays=[dictionary objectForKey:@"leftdays"];
                    applyMark=[dictionary objectForKey:@"applymark"];
                    //     NSLog(@"%@,%@,%@,%@,%@,%@",car_code,item_id, itemname,lifemiles,latestmiles,leftpercent);
                    item=[[MaintainItem alloc] initWithItemId:[item_id intValue] itemName:itemname lifeMiles:[lifemiles intValue] latestMaintinMiles:[latestmiles intValue] leftPercent:[leftpercent intValue]];
                    item.carId=[car_code intValue];
                    item.leftMiles=[leftMiles intValue];
                    item.latestMaintainDate=latestMaintainDate;
                    item.lifeTime=[lifeTime intValue];
                    item.leftTime=[leftDays intValue];
                    item.applyMark=[applyMark intValue];
                    [appDelegate insertMaintainItem:item];
                }
            }
            
            waitLevel++;
            if (waitLevel==5) {
                [self performSelectorOnMainThread:@selector(dealWithData) withObject:nil waitUntilDone:YES];
            }
        }
        else NSLog(@"ommit data to get maintaininfo error!");
    }]; 
     
}

-(void) getmaintainRecordInfo
{
  //  [appDelegate.maintainRecords removeAllObjects];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/get_maintain_record.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&password=%@",ownerTel,@""];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    /*
     NSHTTPURLResponse *response=nil;
     NSError *error=[[NSError alloc] init];
     
     NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     if (error) {
     NSLog(@"Something wrong: %@",[error description]);
     }else {
     if (responseData) {
     NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
     NSLog(@"get %@",responseString);   */
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"commit data to get maintainrecord successful,response:%@",reponseString);
            NSError *error;
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            //    NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
         //   NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
            NSDictionary *dictionary;
            NSString *car_code,*item_id,*itemname,*latestmiles,*cost1,*cost2,*latestMaintainDate;
            NSLog(@"maintainrecord count %ld",[arr count]);
            MaintainRecord *record;
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                car_code=[dictionary objectForKey:@"car_code"];
                item_id=[dictionary objectForKey:@"id"];
                itemname=[dictionary objectForKey:@"itemname"];
            //    lifemiles=[dictionary objectForKey:@"lifemiles"];
                latestmiles=[dictionary objectForKey:@"miles"];
                latestMaintainDate=[dictionary objectForKey:@"date"];
                cost1=[dictionary objectForKey:@"cost1"];
                cost2=[dictionary objectForKey:@"cost2"];
                
                
                NSLog(@"cloud:maintainRecord,%@,%@,%@",car_code,item_id, itemname);
                record=[[MaintainRecord alloc] initWithCarCode:[car_code intValue] Item_id:[item_id intValue] itemName:itemname MaintainMiles:[latestmiles intValue] Cost:([cost2 floatValue]+[cost1 floatValue]) Date:latestMaintainDate];

                [appDelegate insertmaintainRecord:record];
                
            }
            waitLevel++;
            if (waitLevel==5) {
                [self performSelectorOnMainThread:@selector(dealWithData) withObject:nil waitUntilDone:YES];
            }
            
            //     NSLog(@"get data:%@",reponseString);
        }
        else NSLog(@"ommit data to get maintainrecord error!");
    }];
}


-(void) getFuelingInfo
{
  //  [appDelegate.fuelingItems removeAllObjects];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getFuelingInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&password=%@",ownerTel,@""];
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
            NSLog(@"get fueling record successful res:%@",reponseString);
            NSError *error;
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSDictionary *dictionary;
            NSString *car_code,*volume,*cost,*miles,*date,*avCost,*avOil,*addMiles;
            FuelingItem *item;
            NSLog(@"cloud fueling count %ld",[arr count]);
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                car_code=[dictionary objectForKey:@"car_code"];
                volume=[dictionary objectForKey:@"volume"];
                cost=[dictionary objectForKey:@"cost"];
                miles=[dictionary objectForKey:@"miles"];
                date=[dictionary objectForKey:@"date"];
                avCost=[dictionary objectForKey:@"avcost"];
                avOil=[dictionary objectForKey:@"avoil"];
                addMiles=[dictionary objectForKey:@"add_miles"];
                NSLog(@"%@,%@,%@,%@,%@",car_code,volume, cost,miles,date);
          //      item=[[FuelingItem alloc] initWithCurrentMiles:[miles intValue] LeftVol:0 Volume:[volume floatValue] Cost:[cost floatValue] Date:date];
                item=[[FuelingItem alloc] initWithCarId:[car_code intValue] FuelingMiles:[miles intValue] AddMiles:[addMiles intValue] Volume:[volume floatValue] Cost:[cost floatValue] AvOil:[avOil floatValue] AvCost:[avCost floatValue] Date:date];
             
                [appDelegate insertFuelingRecord:item];
                
            }
            waitLevel++;
            if (waitLevel==5) {
                [self performSelectorOnMainThread:@selector(dealWithData) withObject:nil waitUntilDone:YES];
            }
            //     NSLog(@"get data:%@",reponseString);
        }
        else NSLog(@"post error!");
    }];    
    
}

-(void)getRespairInfo
{
  //  [appDelegate.respairItems removeAllObjects];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getRespairInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&password=%@",ownerTel,@""];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    /*
     NSHTTPURLResponse *response=nil;
     NSError *error=[[NSError alloc] init];
     
     NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     if (error) {
     NSLog(@"Something wrong: %@",[error description]);
     }else {
     if (responseData) {
     NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
     NSLog(@"get %@",responseString);   */ 
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSLog(@"successfully get respair info");
            NSError *error;
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        //    NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
            NSDictionary *dictionary;
            NSString *car_code,*names,*cost,*miles,*date;
      //      NSLog(@"cloud repair count %ld",[arr count]);
            RespairItem *item;
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                car_code=[dictionary objectForKey:@"car_code"];
                names=[dictionary objectForKey:@"item"];
                cost=[dictionary objectForKey:@"cost"];
                miles=[dictionary objectForKey:@"miles"];
                date=[dictionary objectForKey:@"date"];
                NSLog(@"%@,%@,%@,%@,%@",car_code,names, cost,miles,date);
                item=[[RespairItem alloc] initWithNames:names Miles:[miles intValue] Cost:[cost floatValue] Date:date];
                item.carId=[car_code intValue];
                [appDelegate insertRespairRecord:item];
                
            }
            waitLevel++;
            if (waitLevel==5) {
                [self performSelectorOnMainThread:@selector(dealWithData) withObject:nil waitUntilDone:YES];
            }
            //     NSLog(@"get data:%@",reponseString);
        }
        else NSLog(@"post error!");
    }];    
}

-(IBAction)popMyself:(id)sender
{
    
    [appDelegate getAllCars];
    [appDelegate showNotification:@"登录用户可享受数据云端存储。"];
    
    if ([appDelegate.cars count]>0) {
        [appDelegate.tracingCarViewController refreshView];
    }else
    [appDelegate.tracingCarViewController showRegisterNewCar];
    
    NSLog(@"appDelegate.navigationController.view.center.x:%f",appDelegate.navigationController.view.center.x);
    if (appDelegate.navigationController.view.center.x<(appDelegate.screenWidth/2+10)) {
        [appDelegate.navigationController popViewControllerAnimated:YES];
    } else{
        NSLog(@"from leftNavigationController");
        [appDelegate.leftNavigationController popViewControllerAnimated:YES];
        [UIView animateWithDuration:1.0 animations:^{
            appDelegate.navigationController.view.center=CGPointMake(appDelegate.navigationController.view.center.x-(appDelegate.screenWidth*2/3), appDelegate.navigationController.view.center.y);
            
        }];
    }
    
    appDelegate.memberType=2;
    
    
}

-(IBAction)testUse:(id)sender
{
    
    
}

-(IBAction)login:(id)sender
{
    activityIndicatorView.hidden=NO;
    [activityIndicatorView startAnimating];
    
    if ([owner.text isEqualToString:@""]) {
        [appDelegate.notificationInfo showNotificationWithStr:@"账号为空!"];
        return;
    }
    if ([password.text isEqualToString:@""]) {
        [appDelegate.notificationInfo showNotificationWithStr:@"密码为空!"];
        return;
    }
    if (password.secureTextEntry) {
        owner.tag=3;
        [self checkIdentification];
        while (owner.tag==3) {
            
        }
        if (owner.tag==0) {
            [appDelegate.notificationInfo showNotificationWithStr:@"账号，密码不匹配!"];
            activityIndicatorView.hidden=YES;
            [activityIndicatorView stopAnimating];
            return;
        }
    }
    
    
    [self getCloudData];

}

-(BOOL) checkIdentification
{
    //  identify owner
    ownerTel=owner.text;
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/owner_login.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"tel=%@&password=%@",owner.text,password.text];
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
            
            
            NSError *error;
            NSDictionary *dictionary;
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if ([arr count]==0) {
                owner.tag=0;
            } else {
                    dictionary=[arr objectAtIndex:0];
                    appDelegate.memberType=[[dictionary objectForKey:@"type"] intValue] ;
                NSLog(@"login successful member:%ld",appDelegate.memberType);;
                
            }owner.tag=1;
            
        }
    }];
    if (owner.tag==1) {
        return TRUE;
    }
    return FALSE;
    
}



-(void)getCloudData
{
            // clear database
            [appDelegate clearDataBase];
            // get data from cloud.
            appDelegate.getDataFromCloud=TRUE;
            ownerTel=owner.text;
            waitLevel=0;
            [self getCarInfo];
            [self getMaintainInfo];
            [self getmaintainRecordInfo];
            [self getFuelingInfo];
            [self getRespairInfo];
            /*
            dispatch_async(dispatch_get_main_queue(), ^{
                
               }); */
}

-(void) dealWithData
{
    /*
    while (waitLevel<5) {
        // wait download data finishes.
        //   NSLog(@"wait");
    } */
    activityIndicatorView.hidden=YES;
    [activityIndicatorView stopAnimating];
    
    appDelegate.getDataFromCloud=FALSE;
    [appDelegate loginWithTel:ownerTel Type:appDelegate.memberType Garage:nil];
    if ([appDelegate.cars count]>0) {
        [appDelegate.tracingCarViewController returnRegisterNewCarView:nil];
        [appDelegate reSetCurrentCarWithCar:[appDelegate.cars objectAtIndex:0]];
    }else
        [appDelegate.tracingCarViewController showRegisterNewCar];
    
    [appDelegate.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)forgetPasswordView:(id)sender
{
    [carOwnerRegisterViewController setFlag:2];
    [appDelegate.navigationController  pushViewController:carOwnerRegisterViewController animated:YES];
}

-(IBAction)registerView:(id)sender
{
    [appDelegate.navigationController pushViewController:carOwnerRegisterViewController animated:YES];
    
}

-(IBAction)finishRegister:(id)sender
{
    [appDelegate.navigationController popViewControllerAnimated:YES];
    // commit register data
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/owner_register.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"Tel=%@&Password=%@&Garage=%@",rTel.text,rPassword.text,rGarage.text];
    NSLog(@"post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    //  NSHTTPURLResponse *response=nil;
    //  NSError *error=[[NSError alloc] init];
    /*
     NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
     if (error) {
     NSLog(@"Something wrong: %@",[error description]);
     }else {
     if (responseData) {
     NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
     NSLog(@"get %@",responseString);    */
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
        //    NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"post successful");
       //     NSLog(reponseString);
        }
        else NSLog(@"post error!");
    }];    
    
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

-(void)getYourPassword:(NSString *)pass Owner:(NSString *)yourTel
{
    [owner setText:yourTel];
    [password setText:pass];
     password.secureTextEntry=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    carOwnerRegisterViewController=[[CarOwnerRegisterViewController alloc] initWithNibName:@"CarOwnerRegisterViewController" bundle:nil];
    
    waitLevel=0;
    [activityIndicatorView setHidden:YES];
    [activityIndicatorView setHidesWhenStopped:YES];
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
 //   [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
 //   [self.view setTintColor:[UIColor whiteColor]];
    self.title=@"注册登录";
    [self.navigationItem setHidesBackButton:YES ] ;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
  //  [owner setBorderStyle:UITextBorderStyleNone];
  //  [password setBorderStyle:UITextBorderStyleNone];
    password.secureTextEntry=YES;
    
}

-(void)viewDidLayoutSubviews
{
    [scrollView setContentSize:CGSizeMake(appDelegate.screenWidth, 700)];
}

- (void)viewDidUnload
{
    [self setOwner:nil];
    [self setPassword:nil];
    [self setRTel:nil];
    [self setRPassword:nil];
    [self setRGarage:nil];
    [self setActivityIndicatorView:nil];
    [self setMsgBoard:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [owner setText:@""];
    [password setText:@""];
    [owner becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
