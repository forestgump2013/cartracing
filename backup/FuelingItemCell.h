//
//  FuelingItemCell.h
//  234
//
//  Created by l on 14-7-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuelingItemCell : UITableViewCell
{
   IBOutlet  UILabel *volume;
   IBOutlet UILabel *cost;
}

@property (nonatomic,retain)  UILabel *volume;
@property (nonatomic,retain)  UILabel *cost;
@property (weak, nonatomic) IBOutlet UILabel *miles;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
