//
//  TopicItemCellTableViewCell.h
//  cartracing
//
//  Created by l on 4/10/16.
//
//

#import <UIKit/UIKit.h>
#import "TopicItem.h"

@interface TopicItemCellTableViewCell : UITableViewCell


@property(nonatomic,retain) IBOutlet UILabel *talker,*date,*topic;

-(void) cellAutoLayoutHeight:(TopicItem*) topicItem;

//-(void) configureCellWithData:(TopicItem*) item;
@end
