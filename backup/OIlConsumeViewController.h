//
//  OIlConsumeViewController.h
//  234
//
//  Created by l on 3/24/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OIlConsumeViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>

@property(retain,nonatomic) IBOutlet UITableView *recordsTable;
@property(nonatomic,retain) NSMutableArray *records;

@end
