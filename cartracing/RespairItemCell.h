//
//  RespairItemCell.h
//  234
//
//  Created by l on 8/6/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RespairItemCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *subItemsTable;
@property (weak, nonatomic) IBOutlet UILabel *miles;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (nonatomic,retain) NSMutableArray *subItems;

@end
