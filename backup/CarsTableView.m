//
//  CarsTableView.m
//  234
//
//  Created by l on 1/26/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CarsTableView.h"
#import "AppDelegate.h"
#import "Car.h"
#import "TracingCarViewController.h"
#import "PersonalCenterViewController.h"
#import "CarManageViewController.h"
#import "DefaultTableViewCell.h"

@implementation CarsTableView
@synthesize plot;
@synthesize appDelegate;
@synthesize table;
-(id) initWithPlot:(NSInteger *)tPlot AppDelegate:(AppDelegate *)apd
{
    if (self=[super init]) {
      //  tableArray=array;
        plot=tPlot;
        appDelegate=apd;
        table=[[UITableView alloc] init];
        table.delegate=self;
        table.dataSource=self;
        self.view.frame=CGRectMake((appDelegate.screenWidth-180)/2, 64, 180, 44*([appDelegate.cars count]+1));
        table.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //    [table setBackgroundColor:[UIColor yellowColor]];
    //    [table setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenBtn.png"]]];
        [table.layer setMasksToBounds:YES];
        [table.layer setCornerRadius:5.0f];
        [table setBackgroundColor:[UIColor colorWithRed:72/255.0f green:81/255.0f blue:88/255.0f alpha:1.0f]];
        [table setSeparatorInset:UIEdgeInsetsZero];
        [self.view addSubview:table];
        [self.view setUserInteractionEnabled:YES];
        [table setUserInteractionEnabled:YES];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"CarsTableView numberOfRowsInSection");
    if (plot==3) {
        NSLog(@"plot==3,numberOfRowsInSection ");
        return [appDelegate.deletedCars count]+1;
    }
      return [appDelegate.cars count]+1;
    
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==Nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    */
    static NSString *identifier=@"identifier";
    DefaultTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell=[[DefaultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
  //  [cell setBackgroundColor:[UIColor clearColor];
    NSInteger row=[indexPath row];
    if (plot==3) {
        NSLog(@"plot==3,row:%ld ",row);
        if (row==0) {
            [cell.imageView setImage:nil];
            cell.textLabel.text=@"选择恢复车辆";
            return cell;
        }else{
            Car *oneCar=[appDelegate.deletedCars objectAtIndex:row-1];
            cell.textLabel.text=oneCar.license;
            [cell.textLabel setTextColor:[UIColor whiteColor]];
            [cell.imageView setImage:[UIImage imageNamed:[appDelegate getMarkWithBrand:oneCar.brandName]]];
            
            return cell;
        }
    }
    
    
    if (row==[appDelegate.cars count]) {
        if (plot==0){
            cell.textLabel.text=@"添加新车";
        } else{
             cell.textLabel.text=@"恢复删除车辆";
        }
        [cell.imageView setImage:nil];
        return cell;
    }
    Car *oneCar=[appDelegate.cars objectAtIndex:row];
    cell.textLabel.text=oneCar.license;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.imageView setImage:[UIImage imageNamed:[appDelegate getMarkWithBrand:oneCar.brandName]]];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if (plot==3) {
        Car *oneCar=[appDelegate.deletedCars objectAtIndex:row-1];
        [appDelegate.personalCenterViewController.carManageViewController restoreOneCar:oneCar];
        [self.view removeFromSuperview];
        [appDelegate.personalCenterViewController.carManageViewController.titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]]];
        [self.view removeFromSuperview];
        return;
    }
    if (row==[appDelegate.cars count]) {
        if (plot==0) {
            [self.appDelegate.tracingCarViewController showRegisterNewCar];
            [appDelegate.tracingCarViewController.titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]]];
        }else{
            if ([appDelegate.deletedCars count]==0) {
                [appDelegate showNotification:@"无删除车辆!"];
            } else{
                NSLog(@"press restore button deletecars:%ld",[appDelegate.deletedCars count]);
                self.plot=3;
                [self refreshDeletedCarsTableView];
             //   [tableView deselectRowAtIndexPath:indexPath animated:NO];
                [self.table reloadData];
                return;
            }
            
           // [appDelegate.personalCenterViewController.carManageViewController.titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]]];
        }
        
    } else {
        Car *oneCar=[appDelegate.cars objectAtIndex:row];
        if (plot==0) {
            appDelegate.currentCar=oneCar;
            [appDelegate.tracingCarViewController returnRegisterNewCarView:nil];
            [appDelegate.tracingCarViewController refreshView];
            self.table.tag=row;
            [appDelegate.tracingCarViewController.titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]]];
            
        } else{
            [appDelegate.personalCenterViewController.carManageViewController refreshEditViewWithEditCar:oneCar ];
            [appDelegate.personalCenterViewController.carManageViewController.titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]]];
        }
        
        
    }
    [self.view removeFromSuperview];
    
   //  NSLog(@"cars table didselected is called!");
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    isVisible=TRUE;
}

-(void)viewDidDisappear:(BOOL)animated
{
   // NSLog(@"carsTableview disappear!");
    [super viewDidDisappear:animated];
    isVisible=FALSE;
}

-(void) refreshCarsTableView
{
    CGRect frame=self.view.frame;
    [self.view setFrame:CGRectMake(frame.origin.x, frame.origin.y
                                   , frame.size.width, 44*([appDelegate.cars count]+1))];
    table.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

-(void) refreshDeletedCarsTableView
{
    CGRect frame=self.view.frame;
    [self.view setFrame:CGRectMake(frame.origin.x, frame.origin.y
                                   , frame.size.width, 44*([appDelegate.deletedCars count]+1))];
    table.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

-(BOOL) isVisible
{
    return isVisible;
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
        [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
        [table setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}

@end
