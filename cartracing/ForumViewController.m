//
//  ForumViewController.m
//  cartracing
//
//  Created by l on 4/10/16.
//
//

#import "ForumViewController.h"
#import "AppDelegate.h"
#import "TopicItem.h"
#import "TopicItemCellTableViewCell.h"
#import "CallBackViewController.h"
#import "ForumCommentViewController.h"

@interface ForumViewController ()

@property(nonatomic,retain) IBOutlet UITableView *table;

@end


@implementation ForumViewController

@synthesize topicItems,appDelegate,table,sendTopicViewController,forumCommentViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title=@"交流反馈";
    // Do any additional setup after loading the view from its nib.
 //   [self.navigationController.navigationBar setHidden:NO];
    
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
    
    //
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    topicItems=[NSMutableArray array];
    [self getAllTopicItems];
    
     UIBarButtonItem *sendBtn=[[UIBarButtonItem alloc] initWithTitle:@"发贴" style:UIBarButtonItemStylePlain target:self action:@selector(sendTopic)];
    self.navigationItem.rightBarButtonItem=sendBtn;
    
    forumCommentViewController=[[ForumCommentViewController alloc] initWithNibName:@"ForumCommentViewController" bundle:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // clear table
    //-----------------
    UIView *tableFootView=[[UIView alloc] init];
    [tableFootView setBackgroundColor:[UIColor clearColor]];
    tableFootView.layer.masksToBounds=YES;
    tableFootView.layer.cornerRadius=5.0f;
    [table setTableFooterView:tableFootView];
    [table setTableHeaderView:tableFootView];
  //  NSLog(@"viewDidLoad");
}

-(void) viewDidAppear:(BOOL)animated
{
    [table reloadData];
  //   NSLog(@"viewDidAppear");
  
}

-(void) viewWillAppear:(BOOL)animated
{
      [self.navigationController.navigationBar setHidden:NO];
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

-(void) sendTopic
{
    if(sendTopicViewController==nil){
        sendTopicViewController=[[CallBackViewController alloc] initWithNibName:@"CallBackViewController" bundle:nil];
    }
    [sendTopicViewController setFromFlag:0 Items:topicItems Topic:nil];
    [appDelegate.leftNavigationController pushViewController:sendTopicViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
 //   return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [topicItems count];
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
    TopicItem *item=[topicItems objectAtIndex:[indexPath row]];
  //  [cell.rai]
    [cell cellAutoLayoutHeight:item];
  //  [cell.talker setText:item.talker];
   // [cell.topic setText:item.topic];
   // [cell.date setText:item.date];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
    TopicItem *item=[topicItems objectAtIndex:[indexPath row]];
    
    [cell cellAutoLayoutHeight:item];
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
 //   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    [forumCommentViewController setTopic:[topicItems objectAtIndex:[indexPath row]]];
    // Push the view controller.
    [self.navigationController pushViewController:forumCommentViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) getAllTopicItems
{
    //  [appDelegate.fuelingItems removeAllObjects];
    NSURL *url=[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@getCommunityTopics.php",appDelegate.serverAddr]];
    NSString *post=nil;
  //  post=[NSString stringWithFormat:@"owner=%@&password=%@",ownerTel,@""];
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
            NSLog(@"getCommunityTopics.php successful response:%@",reponseString);
            NSError *error;
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSDictionary *dictionary;
            NSString *itemID,*fID,*raiser,*topic,*date;
            TopicItem *item;
            NSLog(@"cloud fueling count %ld",[arr count]);
            for(int i=0;i<[arr count]; i++)
            {
                dictionary=[arr objectAtIndex:i];
                itemID=[dictionary objectForKey:@"id"];
                raiser=[dictionary objectForKey:@"raiser"];
                topic=[dictionary objectForKey:@"topic"];
                date=[dictionary objectForKey:@"date"];
                item=[[TopicItem alloc] initWithItemID:[itemID intValue] FollowID:0 Talker:raiser Topic:topic Date:date];
                
                [topicItems addObject:item];
                
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
