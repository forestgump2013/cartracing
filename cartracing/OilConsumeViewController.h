//
//  OIlConsumeViewController.h
//  234
//
//  Created by l on 3/24/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface OilConsumeViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(retain,nonatomic) IBOutlet UITableView *recordsTable;
@property(nonatomic,retain) NSMutableArray *records;
@property(nonatomic,retain) UIAlertView *alertView;
@property(nonatomic,retain) AppDelegate *appDelegate;
-(void) setData:(NSMutableArray*) data;

@end
