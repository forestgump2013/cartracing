//
//  TopicItemCellTableViewCell.m
//  cartracing
//
//  Created by l on 4/10/16.
//
//

#import "TopicItemCellTableViewCell.h"

@implementation TopicItemCellTableViewCell

@synthesize talker,date,topic;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) cellAutoLayoutHeight:(TopicItem *)topicItem
{
    //
    [topic setLineBreakMode:NSLineBreakByWordWrapping];
    [topic setPreferredMaxLayoutWidth:CGRectGetWidth(topic.frame)];
    //
    if ([self isPureInt:topicItem.talker] && [topicItem.talker length]==11) {
        NSString *name=[topicItem.talker stringByReplacingOccurrencesOfString:[topicItem.talker substringFromIndex:7] withString:@"****"];
        [talker setText:name];
    } else   [talker setText:topicItem.talker];
    [topic setText: topicItem.topic];
    [date setText:topicItem.date];
}
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
