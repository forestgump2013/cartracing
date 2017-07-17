//
//  ForumCommentViewController.m
//  cartracing
//
//  Created by l on 4/13/16.
//
//

#import "ForumCommentViewController.h"
#import "TopicItem.h"
#import "TopicItemCellTableViewCell.h"
#import "AppDelegate.h"
#import "CallBackViewController.h"

@interface ForumCommentViewController ()

@property(nonatomic,retain) IBOutlet UITableView *table;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) TopicItem *topic;
@property(nonatomic,retain) NSMutableArray *comments;
@property(nonatomic,retain) CallBackViewController *callBackViewController;
@end

@implementation ForumCommentViewController

@synthesize appDelegate,topic,comments,table,callBackViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    callBackViewController=[[CallBackViewController alloc] initWithNibName:@"CallBackViewController" bundle:nil];
    comments=[NSMutableArray array];
    self.title=@"评论";
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:NO];
    
    if (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    // [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    //set background.
    UIImageView *background=[[UIImageView alloc] initWithFrame:self.view.bounds];
    background.contentMode=UIViewContentModeScaleToFill;
    background.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [background setImage:[UIImage imageNamed:@"fragment_background.png"]];
    [self.view insertSubview:background atIndex:0];
    
    //concerned table
    UIView *tableFootView=[[UIView alloc] init];
    [tableFootView setBackgroundColor:[UIColor clearColor]];
    tableFootView.layer.masksToBounds=YES;
    tableFootView.layer.cornerRadius=5.0f;
    [table setTableFooterView:tableFootView];
    [table setTableHeaderView:tableFootView];
    
    UIBarButtonItem *sendBtn=[[UIBarButtonItem alloc] initWithTitle:@"跟帖" style:UIBarButtonItemStylePlain target:self action:@selector(sendOneComment)];
    self.navigationItem.rightBarButtonItem=sendBtn;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getTopicComments];
}

-(void) viewDidAppear:(BOOL)animated
{
    [table reloadData];
    NSLog(@"viewDidAppear");
}

-(void)viewDidLayoutSubviews
{
    if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
        [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
        [table setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendOneComment{
    [callBackViewController setFromFlag:[topic getItemID] Items:comments Topic:topic];
    [self.navigationController pushViewController:callBackViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
   // return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return  [comments count]+1;
  //  return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"TopicTableViewCellIdentifier";
    TopicItemCellTableViewCell *cell = (TopicItemCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"TopicItemCellTableViewCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[TopicItemCellTableViewCell class]]) {
                cell=(TopicItemCellTableViewCell*) oneObject;
            }
        }
    }
    
    // Configure the cell...
    NSInteger row=[indexPath row];
    if (row==0) {
        [cell cellAutoLayoutHeight:topic];
    }else{
        TopicItem *item=[comments objectAtIndex:row-1];
        [cell cellAutoLayoutHeight:item];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"TopicTableViewCellIdentifier";
    TopicItemCellTableViewCell *cell = (TopicItemCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"TopicItemCellTableViewCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[TopicItemCellTableViewCell class]]) {
                cell=(TopicItemCellTableViewCell*) oneObject;
            }
        }
    }
  //  TopicItem *item=[topicItems objectAtIndex:[indexPath row]];
    
  //  [cell cellAutoLayoutHeight:item];
    CGSize size=[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    return size.height+1;
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
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setTopic:(TopicItem *)item
{
    topic=item;
}

-(void) getTopicComments
{
    //  [appDelegate.fuelingItems removeAllObjects];
    NSURL *url=[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@getCommunityComments.php",appDelegate.serverAddr]];
    NSString *post=nil;
      post=[NSString stringWithFormat:@"sid=%d",(int)[topic getItemID]];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
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
            NSLog(@"getCommunityComments.php successful response:%@",reponseString);
            NSError *error;
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSDictionary *dictionary;
            NSString *itemID,*raiser,*topic,*date;
            TopicItem *item;
         //   NSLog(@"cloud comments count %ld",[arr count]);
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                itemID=[dictionary objectForKey:@"id"];
                raiser=[dictionary objectForKey:@"echor"];
                topic=[dictionary objectForKey:@"comment"];
                date=[dictionary objectForKey:@"date"];
                item=[[TopicItem alloc] initWithItemID:[itemID intValue] FollowID:0 Talker:raiser Topic:topic Date:date];
                
                [comments addObject:item];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [table reloadData];
            });
            /*
             if (waitLevel==5) {
             [self performSelectorOnMainThread:@selector(dealWithData) withObject:nil waitUntilDone:YES];
             } */
            //     NSLog(@"get data:%@",reponseString);
            
        }
        else NSLog(@"post error!");
    }];
}

@end
