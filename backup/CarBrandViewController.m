//
//  CarBrandViewController.m
//  123
//
//  Created by l on 9/3/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CarBrandViewController.h"
#import "AppDelegate.h"
#import "CarManageViewController.h"
#import "TracingCarViewController.h"
#import "DefaultTableViewCell.h"

@implementation CarBrandViewController
@synthesize keys;
@synthesize lists;
@synthesize brandTable;
@synthesize nav;
@synthesize carBrandDataBase,brandDictionary;
@synthesize currentSerice,currentProducer,currentBrand,currentModel,currentOilUnit;

-(void)setLevel:(NSInteger)val
{
    level=val;
}

-(void) setConditionWithBrand:(NSString *)brd Producer:(NSString *)prr Serice:(NSString *)see
{
    currentBrand=brd;
    currentProducer=prr;
    currentSerice=see;
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
  //  AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"mainpage_background.png"]];
    [self.view insertSubview:background atIndex:0];
    [brandTable setSectionIndexColor:[UIColor whiteColor]];
    
    [brandTable setSectionIndexBackgroundColor:[UIColor clearColor]];
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
        [brandTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
 //   NSLog(@"carbrandView viewDidLoad keys=%d",[keys count]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [keys count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *subList=[lists objectAtIndex:section];
    return [subList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSMutableArray *subList=[lists objectAtIndex:section];
    static NSString *SectionTableIdentifier=@"SectionTableIdentifier";
    DefaultTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SectionTableIdentifier];
    if(cell==nil){
        cell=[[DefaultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:SectionTableIdentifier];
    }
    NSString *brand=[subList objectAtIndex:row];
    NSString *en_brand=[brandDictionary objectForKey:brand];
    NSString *picName=[[NSString alloc] initWithFormat:@"%@.png",en_brand];
    cell.textLabel.text=[subList objectAtIndex:row];
  //  [cell.imageView setFrame:CGRectMake(0, 0,40, 40)];
    
  //  [cell.imageView setBounds:CGRectMake(0, 0, 40, 40)];
 //   [cell.imageView setAutoresizesSubviews:NO ];
    
    [cell.imageView setImage:[UIImage imageNamed:picName]];    
  //  NSLog(@"cell.imageView frame width=%f,height=%f",cell.imageView.frame.size.width,cell.imageView.frame.size.height);
    cell.textLabel.numberOfLines=0;
    cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [cell.textLabel sizeToFit];
  //  if(level<2)
   //     cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
/*
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [keys objectAtIndex:section];
}
*/

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, brandTable.bounds.size.width, 22)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f]];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, brandTable.bounds.size.width, 22)];
    [title setTextColor:[UIColor whiteColor]];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setText:[keys objectAtIndex:section]];
    
    [sectionView addSubview:title];
    return sectionView;
}

-(NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return keys;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"table did select is called! level=%d",level);
    NSInteger seciton=[indexPath section];
    NSInteger row=[indexPath row];
    NSMutableArray* newKeys=[NSMutableArray array];
    NSMutableArray* newLists=[NSMutableArray array];    
    switch (level) {
        case 0:
        {
            NSMutableArray *subList=[lists objectAtIndex:seciton];
            NSString *brand=[subList objectAtIndex:row];
       //     NSLog(brand);
            NSString *query=[[NSString alloc] initWithFormat: @"select producer from car_brand_table where brand='%@' group by producer ",brand];
            sqlite3_stmt *statement;
            if(sqlite3_prepare_v2(carBrandDataBase, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
            {
                char *str;
                NSString *producer,*serice;
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    str=(char*)sqlite3_column_text(statement, 0);
                    producer=[[NSString alloc] initWithUTF8String:str];
        //            NSLog(producer);
                    
                    [newKeys addObject:producer];
                    NSString *subQuery=[[NSString alloc] initWithFormat: @"select serice from car_brand_table where brand='%@' and producer='%@' group by serice ",brand,producer];
                    sqlite3_stmt *subStatement;
                    if(sqlite3_prepare_v2(carBrandDataBase, [subQuery UTF8String], -1, &subStatement, nil)==SQLITE_OK)
                    {
                        NSMutableArray *newSubList=[NSMutableArray array];
                        while (sqlite3_step(subStatement)==SQLITE_ROW) {
                            str=(char*)sqlite3_column_text(subStatement, 0);
                            serice=[[NSString alloc] initWithUTF8String:str];
                     //       NSLog(serice);
                            [newSubList addObject:serice];                    
                        }
                        [newLists addObject:newSubList];
                        
                    } else{
                        NSLog(@"error in select serice!");
                    } 
                }
                
                CarBrandViewController *subCarBrandViewController=[[CarBrandViewController alloc] initWithNibName:@"CarBrandViewController" bundle:nil];
                subCarBrandViewController.keys=newKeys;
                subCarBrandViewController.lists=newLists;
                [subCarBrandViewController setLevel:level+1];
                subCarBrandViewController.nav=nav;
                subCarBrandViewController.carBrandDataBase=carBrandDataBase;
                subCarBrandViewController.brandDictionary=brandDictionary;
                [subCarBrandViewController setConditionWithBrand:brand Producer:producer Serice:serice];
                [nav pushViewController:subCarBrandViewController animated:NO];   
                
            }else{
                NSLog(@"error in select producer!");
            }
            
            break;
        }   
        case 1:
        {
            
            NSString *query=[[NSString alloc] initWithFormat: @"select pyear from car_brand_table where brand='%@' and producer='%@' and serice='%@' group by pyear ",currentBrand,currentProducer,currentSerice];
            sqlite3_stmt *statement;
            if(sqlite3_prepare_v2(carBrandDataBase, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
            {
                char *str;
                NSString *pyear,*oilunit,*model;
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    str=(char*)sqlite3_column_text(statement, 0);
                    pyear=[[NSString alloc] initWithUTF8String:str];
           //         NSLog(pyear);
                    
                    [newKeys addObject:pyear];
                    NSString *subQuery=[[NSString alloc] initWithFormat: @"select oilunit,model from car_brand_table where brand='%@' and producer='%@' and serice='%@' and pyear='%@' ",currentBrand,currentProducer,currentSerice,pyear];
                    sqlite3_stmt *subStatement;
                    if(sqlite3_prepare_v2(carBrandDataBase, [subQuery UTF8String], -1, &subStatement, nil)==SQLITE_OK)
                    {
                        NSMutableArray *newSubList=[NSMutableArray array];
                        while (sqlite3_step(subStatement)==SQLITE_ROW) {
                            str=(char*)sqlite3_column_text(subStatement, 0);
                            oilunit=[[NSString alloc] initWithUTF8String:str];
                            str=(char*)sqlite3_column_text(subStatement, 1);
                            model=[[NSString alloc] initWithUTF8String:str];                            
                            NSLog(@"%@ \n %@",oilunit,model);
                            [newSubList addObject:[[NSString alloc] initWithFormat:@"%@\n%@",oilunit,model ]];                    
                        }
                        [newLists addObject:newSubList];
                        
                    } else{
                        NSLog(@"error in select serice!");
                    } 
                }
                
                CarBrandViewController *subCarBrandViewController=[[CarBrandViewController alloc] initWithNibName:@"CarBrandViewController" bundle:nil];
                subCarBrandViewController.keys=newKeys;
                subCarBrandViewController.lists=newLists;
                [subCarBrandViewController setLevel:level+1];
                subCarBrandViewController.nav=nav;
                subCarBrandViewController.carBrandDataBase=carBrandDataBase;
                subCarBrandViewController.brandDictionary=brandDictionary;
                [subCarBrandViewController setConditionWithBrand:currentBrand Producer:currentProducer Serice:currentSerice];
                [subCarBrandViewController setCurrentOilUnit:oilunit];
                [subCarBrandViewController setCurrentModel:model];
                [nav pushViewController:subCarBrandViewController animated:NO];   
                
            }else{
                NSLog(@"error in select producer!");
            }
            
            break;
            
        }
        case 2:
        {
            NSMutableArray *subList=[lists objectAtIndex:seciton];
            NSString *oilUnit_model=[subList objectAtIndex:row];            
            [nav popViewControllerAnimated:NO];
            [nav popViewControllerAnimated:NO];
            [nav popViewControllerAnimated:NO];
            TracingCarViewController *superView=(TracingCarViewController*)[nav topViewController];
            
            [superView.oneCarBrandNameButton setTitle:[[NSString alloc] initWithFormat:@"%@ %@ %@",currentBrand,currentSerice,oilUnit_model] forState:UIControlStateNormal];
            [superView.registerNewCarScrollView setContentSize:CGSizeMake(320, 700) ];
            NSString *markName=[brandDictionary objectForKey:currentBrand];
            NSLog(@"new car brand %@ %@ \n %@ mark:%@",currentBrand,currentSerice,oilUnit_model,markName);            
            [superView.oneCarBrandMark setImage:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.png",markName]]]; 
             
        }
        default:
            break;
    }
}

@end
