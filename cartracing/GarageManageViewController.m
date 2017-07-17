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
@synthesize infoTable,indicator,clientBtn,suggentBtn;
//@synthesize suggestContent;
@synthesize appDelegate,selfInfo,editView;
@synthesize suggestItems,carClients;
@synthesize clientTel,garageTel,garageContact,garageName,garageShortName,garageAddr,garageBusiness,garagePasswrod,garageRePassword,garageTitle,editViewScrollView;

/*
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
} */

-(void)getClientsInfo
{
  //  carClients=[NSMutableArray array];
    [carClients removeAllObjects];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getClientInfo.php"];
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
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@" getClientInfo post successful result:%@",reponseString);
            if ([appDelegate stringIsNull:reponseString]) {
                return ;
            }
        //    id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSError *error;
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSDictionary *dictionary;
            NSString *license,*brand,*owner,*item;
       //     NSLog(@"count %d:%d",[array count],[arr count]);
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                license=[dictionary objectForKey:@"license"];
                brand=[dictionary objectForKey:@"brand"];
                owner=[dictionary objectForKey:@"owner"];
                NSLog(@"%@,%@,%@",license,brand ,owner);
                item=[[NSString alloc] initWithFormat:@"%@ %@\n%@",owner,license,brand];
                [carClients addObject:item];
                
            }
            dispatch_async(dispatch_get_main_queue(),^{
                [self.infoTable reloadData];
            });
            NSLog(@"getClientInfo finished!");
        
        }
        else NSLog(@"post error!");
    }];
    
}

-(void)getClientSuggests
{
   // suggestItems=[NSMutableArray array];
    [suggestItems removeAllObjects];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getClientSuggest.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"garage=%@",appDelegate.ownerTel];
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
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"getClientSuggest post successful result:%@",reponseString);
            if ([appDelegate stringIsNull:reponseString]) {
                return ;
            }
       //     id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
        //    NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSDictionary *dictionary;
            NSString *license,*brand,*note,*date,*owner;
            SuggestItem *item;
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
              //  license=[dictionary objectForKey:@"license"];
              //  brand=[dictionary objectForKey:@"brand"];
                note=[dictionary objectForKey:@"suggest"];
                owner=[dictionary objectForKey:@"owner"];
                date=[dictionary objectForKey:@"date"];
                NSLog(@"%@,%@,%@,%@,%@",license,brand, note,owner,date);
                item=[[SuggestItem alloc] initWithLicense:license Brand:brand Tel:owner Suggest:note Date:date];
                [suggestItems addObject:item];
                
            }
            NSLog(@"getClientSuggests finished!");
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
    
    [garagePasswrod resignFirstResponder];
    [garageRePassword resignFirstResponder];
    [self returnEditView:nil];
    
    
}

-(void) showEditView
{
    if (editView==nil) {
        NSArray *nibView=[[NSBundle mainBundle] loadNibNamed:@"garageInfoEdit" owner:self options:nil];
        editView=[nibView objectAtIndex:0];
        editView.frame=CGRectMake(-appDelegate.screenWidth+5, 0, appDelegate.screenWidth-10, 350);
        [self.view addSubview:editView];
        [editViewScrollView setContentSize:CGSizeMake(appDelegate.screenWidth-10, 600)];
    }
    
    if (editView.center.x>0) {
        return;
    }
    NSLog(@"show edit view garage addr:%@",selfInfo.addr);
    [garageName setText:selfInfo.name];
    [garageShortName setText:selfInfo.shortname];
    [garageTel setText:selfInfo.tel];
    [garageContact setText:selfInfo.contact];
    [garageBusiness setText:selfInfo.business];
    [garageAddr setText:selfInfo.addr];
    
    [self.navigationItem setHidesBackButton:YES];
    [UIView animateWithDuration:1.0 animations:^{
        editView.center=CGPointMake(editView.center.x+appDelegate.screenWidth, editView.center.y);
    }];
    
}

-(IBAction)returnEditView:(id)sender
{
    NSLog(@"return btn is pressed!");
    [self.navigationItem setHidesBackButton:NO];
    [UIView animateWithDuration:1.0 animations:^{
        editView.center=CGPointMake(editView.center.x-appDelegate.screenWidth, editView.center.y);
    }];
}

-(void)getselfGarageInfo
{
  //  carClients=[NSMutableArray array];
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/getGarageInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"id=%@",appDelegate.ownerTel];
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
            
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"getselfGarageInfo post successful,result:%@",reponseString);
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
            NSDictionary *dictionary;
            NSString *name,*shortname,*tel,*contact,*addr,*business;
         //   NSLog(@"count %d:%d",[array count],[arr count]);
            for(int i=0;i<[arr count]; )
            {
                dictionary=[arr objectAtIndex:i];
                name=[dictionary objectForKey:@"name"];
                shortname=[dictionary objectForKey:@"shortname"];
                tel=[dictionary objectForKey:@"tel"];
                contact=[dictionary objectForKey:@"contact"];
                addr=[dictionary objectForKey:@"addr"];
                business=[dictionary objectForKey:@"business"];
                selfInfo=[[Garage alloc] initWithShortName:shortname Name:name Tel:tel Contact:contact Business:business Addr:addr Flag:1];
                break;
                
            }
            dispatch_async(dispatch_get_main_queue(),^{
                [garageTitle setText:selfInfo.name];
            });
        }
        else NSLog(@"post error!");
    }];       
}


-(IBAction)btnPress:(id)sender
{
    if (sender==clientBtn) {
        indicator=0;
    }else if (sender==suggentBtn){
        indicator=1;
    }
    [infoTable reloadData ];
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
    NSLog(@" garage manage viewDidLoad");
    // routine set
    [self setTitle:@"商家管理"];
    
    
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    //----------------
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIBarButtonItem *editBtn=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(showEditView)];
    self.navigationItem.rightBarButtonItem=editBtn;
    indicator=0;
    [infoTable setBackgroundColor:[UIColor clearColor]];
    carClients=[NSMutableArray array];
     suggestItems=[NSMutableArray array];
    [self getClientsInfo];
    [self getClientSuggests];
    [self getselfGarageInfo];
    //-----------------
    UIView *tableFootView=[[UIView alloc] init];
    [tableFootView setBackgroundColor:[UIColor clearColor]];
    tableFootView.layer.masksToBounds=YES;
    tableFootView.layer.cornerRadius=5.0f;
    [infoTable setTableFooterView:tableFootView];
    [infoTable setTableHeaderView:tableFootView];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@" garage manage viewWillAppear");
    [self.navigationController.navigationBar setHidden:NO];
  //  carClients=[NSMutableArray array];
   // suggestItems=[NSMutableArray array];
}

-(void)viewDidLayoutSubviews
{
    if ([infoTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [infoTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([infoTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [infoTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)viewDidUnload
{
   // [self setSuggestContent:nil];
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
    NSLog(@"numberOfRowsInSection is called indicater %ld",indicator);
    switch (indicator) {
        case 0:
            return [carClients count];
        case 1:
            return [suggestItems count];
            
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
    switch (indicator) {
        case 1:
        {
            SuggestItem *item=[suggestItems objectAtIndex:row];
            
            cell.textLabel.text=[NSString stringWithFormat:@"%@ \n %@ \n %@",item.clientTel,item.suggest,item.date];
            break;
        }
        case 0:
        {
            NSString *str=[carClients objectAtIndex:row];
        //    NSLog(@"row:%d name:%@  tel:%@",row,item.name,item.tel);
            cell.textLabel.text=str;
            break;
        }
        default:
            break;
    }
    NSLog(@"cell text:%@",cell.textLabel.text);
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
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
/*
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
*/

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    switch (appDelegate.memberType) {
        case 1:
             return 70;
        case 2:
            return 55;
            
        default:
            break;
    } */
    return 60;
   
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
