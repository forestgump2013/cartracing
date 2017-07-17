//
//  MaintainItem.h
//  234
//
//  Created by l on 14-6-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaintainItem : NSObject{
    
    NSString *itemName;
    NSInteger carId,itemId;
  //  NSInteger lifeMiles,leftMiles;
    NSInteger latestMaintainMiles;
    NSInteger leftPercent,applyMark,mTag;
}
@property(nonatomic,retain) NSString *itemName,*latestMaintainDate;
@property NSInteger itemId,carId;
@property NSInteger lifeMiles,leftMiles,lifeTime, leftTime; //lifeTime units month.
@property NSInteger latestMaintainMiles;
@property  NSInteger leftPercent,timeLeftPercent,applyMark,mTag;
-(id) initWithName:(NSString *)name lifeMiles:(NSInteger) lm latestMaintinMiles:(NSInteger) lmm leftPercent:(NSInteger) lp;
-(id) initWithCarId:(NSInteger) cId  ItemId:(NSInteger) tId itemName:(NSString*) tName lifeTime:(NSInteger) lTime latestMaintinDate:(NSString*)latestMDate;

-(id) initWithItemId:(NSInteger) tId itemName:(NSString*) tName lifeMiles:(NSInteger) lMiles latestMaintinMiles:(NSInteger)latestMMiles leftPercent:(NSInteger) lpercent;
-(id) initWithCarId:(NSInteger)cId ItemId:(NSInteger) tId itemName:(NSString *)name lifeMiles:(NSInteger) lm latestMaintinMiles:(NSInteger) lmm leftPercent :(NSInteger) lp leftMiles:(NSInteger) tleftMiles  APPLYMARK:(NSInteger)amark ;
-(void) setLifeMiles:(NSInteger)lm latestMaintainMiles:(NSInteger) lmm;
-(void) editItemWithCurrentMiles:(NSInteger) cMiles LatestMaintainMiles:(NSInteger) latestMMiles LifeMiles:(NSInteger) lMiles latestDate:(NSString*) lDate DateLife:(NSInteger) dateDiv;

-(void) maintain:(int) latestMiles Date:(NSString*) maintainDate;
-(void) updateCurrentMiles:(NSInteger) currentMiles;
-(void) configrationTimeWithLifeTime:(NSInteger) lTime latestMaintainTime:(NSString*)lDate; 
-(void) updateLeftTime;
-(void) freshTag;
-(NSInteger) intervalDaysFromDate:(NSString*) fromDate;
@end
