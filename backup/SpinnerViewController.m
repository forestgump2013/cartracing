//
//  AreaViewController.m
//  234
//
//  Created by l on 7/23/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SpinnerViewController.h"

@implementation SpinnerViewController
@synthesize itemsArray;
@synthesize triggerBtn,table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // areaNameBtn=[[UIButton alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) initWithData:(NSArray *)dataArray Frame:(CGRect)frame Button:(UIButton *)btn
{
    itemsArray=dataArray;
    [self.view setFrame:frame];
    triggerBtn=btn;
    [table reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f]];
    [self.view.layer setCornerRadius:5.0f];
    self.view.layer.masksToBounds=YES;
    [table setSeparatorInset:UIEdgeInsetsZero];
    // Do any additional setup after loading the view from its nib.
  //  areaNames=[[NSArray alloc] initWithObjects:@"京",@"津",@"沪",@"渝",@"鲁",@"皖",@"苏",@"浙",nil];
  //  [self.view setFrame:CGRectMake(areaNameBtn.frame.origin.x, 80, 70, 250)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma -mark
#pragma mark table view data method

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemsArray count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *SimpleCellIdentifier=@"SimpleCellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SimpleCellIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleCellIdentifier];
        
    }
    NSInteger row=[indexPath row];
    cell.textLabel.text=[itemsArray objectAtIndex:row];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
 //   NSLog(@"select area name%@",[areaNames objectAtIndex:row]);
    triggerBtn.titleLabel.text=[itemsArray objectAtIndex:row];
    triggerBtn.tag=row;
    [self.view removeFromSuperview];
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
    return 40;
}

@end
