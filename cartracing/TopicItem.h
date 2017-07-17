//
//  TopicItem.h
//  cartracing
//
//  Created by l on 4/10/16.
//
//

#import <Foundation/Foundation.h>

@interface TopicItem : NSObject
{
    NSInteger itemID,followID;
}


@property(nonatomic,retain) NSString *talker,*topic,*date;

-(id) initWithItemID:(NSInteger) iID FollowID:(NSInteger)fID Talker:(NSString*) ter  Topic:(NSString*) tc Date:(NSString*) de;
-(NSInteger) getItemID;
@end
