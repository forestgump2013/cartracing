//
//  MaintainItem.m
//  234
//
//  Created by l on 14-6-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MaintainItem.h"

@implementation MaintainItem

@synthesize itemId,carId;
@synthesize itemName;
@synthesize lifeMiles,leftMiles,lifeTime,leftTime,timeLeftPercent,pastMiles,pastTime;
@synthesize latestMaintainMiles,latestMaintainDate;
@synthesize leftPercent,applyMark,mTag;

-(id) init
{
    if(self =[super init])
    {
        itemName=@"***";
        lifeMiles=1000;
        latestMaintainMiles=1000;
        leftPercent=100;
    }
    return  self;
}

-(id) initWithName:(NSString *)name lifeMiles:(NSInteger)lm latestMaintinMiles:(NSInteger)lmm leftPercent:(NSInteger)lp
{
    if(self =[super init])
    {
        itemName=[name copy];
        lifeMiles=lm;
        latestMaintainMiles=lmm;
        leftPercent=lp;
        applyMark=1;
        
    }
    return  self;
}

-(id)initWithItemId:(NSInteger)tId itemName:(NSString *)tName lifeMiles:(NSInteger)lMiles latestMaintinMiles:(NSInteger)latestMMiles leftPercent:(NSInteger)lpercent
{
    if(self=[super init])
    {
        self.itemId=tId;
        itemName=tName;
        lifeMiles=lMiles;
        latestMaintainMiles=latestMMiles;
        leftPercent=lpercent;
        leftMiles=lifeMiles*leftPercent/100;
        latestMaintainDate=@"";
        [self freshTag];
        applyMark=0;
    }
    return self;    
    
}

-(id)initWithCarId:(NSInteger)cId ItemId:(NSInteger)tId itemName:(NSString *)name lifeMiles:(NSInteger)lm latestMaintinMiles:(NSInteger)lmm leftPercent:(NSInteger)lp leftMiles:(NSInteger)tleftMiles APPLYMARK:(NSInteger)amark

{
    if(self=[super init])
    {
        carId=cId;
        self.itemId=tId;
        itemName=[name copy];
        lifeMiles=lm;
        latestMaintainMiles=lmm;
        latestMaintainDate=@"";
        leftPercent=lp;
        leftMiles=tleftMiles;
        [self freshTag];
        applyMark=amark;
    }
    return self;
}

-(id)initWithCarId:(NSInteger)cId ItemId:(NSInteger)tId itemName:(NSString *)tName lifeTime:(NSInteger)lTime latestMaintinDate:(NSString *)latestMDate
{
    if(self=[super init])
    {
        carId=cId;
        self.itemId=tId;
        itemName=tName;
        lifeTime=lTime;
        latestMaintainDate=latestMDate;
     //   [self updateLeftTime];
        
    }
    return self;    
    
}

-(void) setTimeLife:(NSInteger)tLife latestMDate:(NSString *)lmDate
{
    lifeTime=tLife;
    latestMaintainDate=lmDate;
}


-(void) setLifeMiles:(NSInteger)lm latestMaintainMiles:(NSInteger)lmm{
    lifeMiles=lm;
    latestMaintainMiles=lmm;
}

-(void)freshTag
{
    if ((lifeMiles>0 && leftMiles<200) || (lifeTime>0 && leftTime<10) ){
        mTag=-1;
        leftPercent=10;
    } else mTag=0;
}

-(void) maintain:(NSInteger)latestMiles Date:(NSString *)maintainDate
{
       NSLog(@"item maintain %@",itemName);    
    if (latestMiles<=latestMaintainMiles) {
        return;
    }
    self.latestMaintainMiles=latestMiles;
    
    if (lifeMiles>0) {
        self.leftPercent=100;
        self.leftMiles=lifeMiles;
    }
    
    latestMaintainDate=maintainDate;
   
    if (lifeTime>0) {
        timeLeftPercent=100;
        leftTime=lifeTime*30;
    }
    
    mTag=0; 
}

-(void) editItemWithCurrentMiles:(NSInteger)cMiles LatestMaintainMiles:(NSInteger)latestMMiles LifeMiles:(NSInteger)lMiles latestDate:(NSString *)lDate DateLife:(NSInteger)dateDiv
{
  //  NSLog(@"editItemWithCurrentMiles lastMaintainedMiles:%ld,LifeMIles:%ld",latestMMiles,lMiles );
    lifeMiles=lMiles;
    lifeTime=dateDiv;
    if (lifeMiles==0 && lifeTime==0) {
        return;
    }
    if (lifeMiles>0) {
        lifeMiles=lMiles;
        latestMaintainMiles =latestMMiles;
        leftMiles=lifeMiles-(cMiles-latestMMiles);
        if (leftMiles>0) {
            leftPercent=(leftMiles*100)/lifeMiles;
        }else leftPercent=0;
        
    }
    if (lifeTime>0) {
        latestMaintainDate=lDate;
        lifeTime=dateDiv;
        leftTime=lifeTime*30-[self intervalDaysFromDate:lDate];
        timeLeftPercent=leftTime*100/(lifeTime*30);        
    }
    applyMark=1;
    [self freshTag];
    
}




-(void) updateCurrentMiles:(NSInteger)currentMiles{
    if(currentMiles<= latestMaintainMiles || lifeMiles==0) return;
    self.leftPercent=100-(currentMiles-latestMaintainMiles)*100/lifeMiles;
    leftMiles=lifeMiles*leftPercent/100;
    if(self.leftPercent<=0) self.leftPercent=5;
    [self freshTag];
}

-(void)computePastTimeWithLastMaintainTime:(NSString *)tDate LifeTime:(NSInteger)tLifeTime
{
    latestMaintainDate=tDate;
    lifeTime=tLifeTime;
    if (latestMaintainDate==nil ||[latestMaintainDate isEqualToString:@""]) {
        return;
    }
     pastTime=[self intervalDaysFromDate:latestMaintainDate];
    
    if (lifeTime>0) {
        leftTime=lifeTime*30-[self intervalDaysFromDate:latestMaintainDate];
        timeLeftPercent=leftTime*100/(lifeTime*30);
    }
    
}


-(NSInteger) intervalDaysFromDate:(NSString *)fromDate
{
   NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSDate *fDate=[dateFormatter dateFromString:fromDate];
    NSDate *now=[NSDate date];
    if ([fDate isEqual:nil]) {
        NSLog(@" maintain intervalDaysFromDate error date:%@",fromDate);
    }
    NSLog(@"intervalDaysFromDate is work date %@",fromDate);
    NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
 //   unsigned int unitFlags=NSDayCalendarUnit;
    NSDateComponents *compt=[gregorian components:NSCalendarUnitDay fromDate:fDate toDate:now options:0];
    return [compt day];
    
}
@end
