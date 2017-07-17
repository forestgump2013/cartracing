//
//  TopicItem.m
//  cartracing
//
//  Created by l on 4/10/16.
//
//

#import "TopicItem.h"

@implementation TopicItem

@synthesize talker,topic,date;

-(id) initWithItemID:(NSInteger)iID FollowID:(NSInteger)fID Talker:(NSString *)ter Topic:(NSString *)tc Date:(NSString *)de
{
    if (self=[super init]) {
        itemID=iID;
        followID=fID;
        talker=ter;
        topic=tc;
        date=de;
    }
    return self;
}

-(NSInteger) getItemID
{
    return itemID;
}

@end
