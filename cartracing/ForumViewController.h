//
//  ForumViewController.h
//  cartracing
//
//  Created by l on 4/10/16.
//
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@class CallBackViewController;
@class ForumCommentViewController;

@interface ForumViewController : UITableViewController

@property(nonatomic,retain) NSMutableArray *topicItems;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) CallBackViewController *sendTopicViewController;
@property(nonatomic,retain) ForumCommentViewController *forumCommentViewController;

@end
