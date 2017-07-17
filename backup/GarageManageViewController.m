//
//  GarageManageViewController.m
//  234
//
//  Created by l on 8/1/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "GarageManageViewController.h"
#import "AppDelegate.h"
#import "Car.h"
#import "SuggestItem.h"
#import "Garage.h"

@implementation GarageManageViewController
@synthesize suggestTable,garageTable;
@synthesize suggestContent;
@synthesize appDelegate,selfInfo,editView;
@synthesize suggestItems,waitedGarages;
@synthesize clientTel,garageTel,garageContact,garageName,garageShortName,garageAddr,garageBusiness,garagePasswrod,garageRePassword;

-(IBAction)commitSuggest:(id)sender
{
    //post respair info
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/garageSuggest_Insert.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&car_code=%d&note=%@&garage=%@",@"11711771117",1,suggestContent.text,@"13112340001"];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",[postData length]];
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
            NSLog(@"get data:%@",reponseString);            
        }
        else NSLog(@"post error!");
    }]; 
    [suggestContent resignFirstResponder];
}

-(void)getClientSuggests
{
    suggestItems=[NSMutableArray array]; 
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getClientSuggest.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"garage=%@",appDelegate.ownerTel];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",[postData length]];
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
        //    NSString *reponseString;//=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
            NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
            NSDictionary *dictionary;
            NSString *license,*brand,*note,*date,*owner;
            NSLog(@"count %d:%d",[array count],[arr count]);
            SuggestItem *item;
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                license=[dictionary objectForKey:@"license"];
                brand=[dictionary objectForKey:@"brand"];
                note=[dictionary objectForKey:@"note"];
                owner=[dictionary objectForKey:@"owner"];
                date=[dictionary objectForKey:@"date"];
                NSLog(@"%@,%@,%@,%@,%@",license,brand, note,owner,date);
                item=[[SuggestItem alloc] initWithLicense:license Brand:brand Tel:owner Suggest:note Date:date];
                [suggestItems addObject:item];
                
            }
            
             //    NSLog(@"get data:%@",reponseString);
            NSLog(@"suggests count:%lu",[suggestItems count]);
            [self.suggestTable reloadData];
        }
        else NSLog(@"post error!");
    }];        
    
}

-(IBAction)commitEditInfo:(id)sender
{
    //check info.
    if ([garageName.text isEqualToString:@""] || [garageShortName.text isEqualToString:@""]||
        [garageTel.text isEqualToString:@""] || [garageContact.text isEqualToString:@""]||
        [garageAddr.text isEqualToString:@""] || [garageBusiness.text isEqualToString:@""]||
        [garagePasswrod.text isEqualToString:@""]) {
        [appDelegate showNotification:@"填入注册必要信息！"];
    }
    
    if (![garagePasswrod.text isEqualToString:garageRePassword.text]) {
        [appDelegate showNotification:@"密码重复有误！"];
    }
    
    //  commit edit info
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/update_garageinfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"new_tel=%@&contact=%@&password=%@&name=%@&shortname=%@&addr=%@&business=%@&id=%@",garageTel.text,garageContact.text,garagePasswrod.text,garageName.text,garageShortName.text,garageAddr.text,garageBusiness.text ,appDelegate.ownerTel];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",[postData length]];
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
            NSLog(@"get data:%@",reponseString);
        }
        else NSLog(@"post error!");
    }];
    //   [self moveView:-100];
    [garageName resignFirstResponder];
    [garageShortName resignFirstResponder];
    [garageTel resignFirstResponder];
    [garageAddr resignFirstResponder];
    [garageContact resignFirstResponder];
    [garageBusiness resignFirstResponder];
    
    
}

-(void) showEditView
{
    if (editView==nil) {
        NSArray *nibView=[[NSBundle mainBundle] loadNibNamed:@"garageInfoEdit" owner:self options:nil];
        editView=[nibView objectAtIndex:0];
        editView.frame=CGRectMake(-appDelegate.screenWidth+5, 0, appDelegate.screenWidth-10, 165);
        [self.view addSubview:editView];
    }
    [UIView animateWithDuration:1.0 animations:^{
        editView.center=CGPointMake(editView.center.x+appDelegate.screenWidth, editView.center.y);
    }];
    
}

-(void)getselfGarageInfo
{
    waitedGarages=[NSMutableArray array];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getGarageInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"id=%@",appDelegate.ownerTel];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",[postData length]];
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
            
        //    NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
            NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
            NSDictionary *dictionary;
            NSString *name,*shortname,*tel,*contact,*addr,*business;
         //   NSLog(@"count %d:%d",[array count],[arr count]);
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                name=[dictionary objectForKey:@"name"];
                shortname=[dictionary objectForKey:@"shortname"];
                tel=[dictionary objectForKey:@"tel"];
                contact=[dictionary objectForKey:@"contact"];
                addr=[dictionary objectForKey:@"addr"];
                business=[dictionary objectForKey:@"business"];
                selfInfo=[[Garage alloc] initWithShortName:shortname Name:name Tel:tel Contact:contact Business:business Addr:addr Flag:1];
                
                
            }
            
                NSLog(@"get data:%@",reponseString);
            [self.garageTable reloadData];
        }
        else NSLog(@"post error!");
    }];       
}

-(void)garagePass
{
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/check_garage.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"workerTel=%@&garage=%@",appDelegate.ownerTel,garageTel];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",[postData length]];
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
            NSLog(reponseString);
            
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIBarButtonItem *editBtn=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(showEditView)];
    self.navigationItem.rightBarButtonItem=editBtn;
    /*
    switch (appDelegate.memberType) {
        case 1:
            [self getClientSuggests];
        //    [self.suggestTable reloadData];
            break;
        case 2:
            [self getGarages];
            break;
        default:
            break;
    } */
}

- (void)viewDidUnload
{
    [self setSuggestContent:nil];
    [self setSuggestTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark table concerned

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (appDelegate.memberType) {
        case 1:
            NSLog(@"table rows:%d",[suggestItems count]);            
            return [suggestItems count];
        case 2:
            return [waitedGarages count];
            
        default:
            return 0;
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier=@"SimpleTableIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:SimpleTableIdentifier];
    }
    NSInteger row=[indexPath row];
    cell.textLabel.numberOfLines=0;    
    switch (appDelegate.memberType) {
        case 1:
        {
            SuggestItem *item=[suggestItems objectAtIndex:row];
            
            cell.textLabel.text=[NSString stringWithFormat:@"%@ %@ \n %@\n%@ %@",item.license,item.brandName,item.suggest,item.clientTel,item.date];
            break;
        }
        case 2:
        {
            Garage *item=[waitedGarages objectAtIndex:row];
            NSLog(@"row:%d name:%@  tel:%@",row,item.name,item.tel);
            cell.textLabel.text=[NSString stringWithFormat:@"%@ \n %@",item.name,item.tel];
            break;
        }
        default:
            break;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    NSString *msg;
    switch (appDelegate.memberType) {
        case 1:
        {
            SuggestItem *item=[suggestItems objectAtIndex:row];
            msg=[NSString stringWithFormat:@"联系车主 %@",item.license];
            clientTel=item.clientTel;
            break;
        }
        case 2:
        {
            Garage *item=[waitedGarages objectAtIndex:row];
            msg=[NSString stringWithFormat:@"%@ 审批通过",item.name];
            garageTel=item.tel;
        }
        default:
            break;
    }
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (appDelegate.memberType) {
        case 1:
             return 70;
        case 2:
            return 55;
            
        default:
            break;
    }
    return 44;
   
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        switch (appDelegate.memberType) {
            case 1:
            {
                NSLog(@"connect owner%@!",clientTel);
                NSString *telUrl=[NSString stringWithFormat:@"telprompt:%@",clientTel];
                NSURL *url=[[NSURL alloc] initWithString:telUrl];
                [[UIApplication sharedApplication] openURL:url];                
                break;
            }
                case 2:
            {
                [self garagePass];
                break;
            }
            default:
                break;
        }
        
    }
}

@end
