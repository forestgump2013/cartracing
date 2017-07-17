//
//  FuelingItem.m
//  234
//
//  Created by l on 14-7-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "FuelingItem.h"



@implementation FuelingItem

@synthesize volume,leftVol,avOil,avCost;
@synthesize cost;
@synthesize miles,addMiles,carId;
@synthesize date;
-(id) init
{
    if(self=[super init])
    {
        volume=0;
        cost=0;
    }
    return  self;
}

-(id) initWithVolume:(CGFloat)vol Cost:(CGFloat)ct
{
    if(self=[super init])
    {
        volume=vol;
        cost=ct;
    }
    return  self;
}

-(id) initWithCurrentMiles:(NSInteger)ms LeftVol:(CGFloat)lVol Volume:(CGFloat)vol Cost:(CGFloat)ct Date:(NSString *)dt
{
    if(self=[super init])
    {
        miles=ms;
        leftVol=lVol;
        volume=vol;
        cost=ct;
        date=dt;
    }
    return self;
}

-(id) initWithCarId:(NSInteger)cId FuelingMiles:(NSInteger)ms AddMiles:(NSInteger)aMiles Volume:(CGFloat)vol Cost:(CGFloat)ct AvOil:(CGFloat)aOil AvCost:(CGFloat)aCost Date:(NSString *)dt
{
    if(self=[super init])
    {
        carId=cId;
        miles=ms;
        addMiles=aMiles;
        volume=vol;
        cost=ct;
        avCost=aCost;
        avOil=aOil;
        date=dt;
    }
    return self;
}


@end
