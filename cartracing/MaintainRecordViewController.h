//
//  MaintainRecordViewController.h
//  234
//
//  Created by l on 2/3/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MaintainRecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UISegmentedControl *segmentedControll;
    IBOutlet  UITableView *recordsTable;
}
@property(nonatomic,retain) UISegmentedControl *segmentedControll;
@property(nonatomic,retain) UITableView *recordsTable;
@property(nonatomic,retain) NSMutableArray *currentItems,*allItems;
-(IBAction)switchRecords:(id)sender;
-(void) sortDate;
-(void) clearData;
@end
