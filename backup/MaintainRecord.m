//
//  MaintainRecord.m
//  234
//
//  Created by l on 9/20/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MaintainRecord.h"

@implementation MaintainRecord
@synthesize car_code,item_id,maintainMiles,lifeMiles,cost1,cost2,itemname,date,carLicense;

-(id)initWithCarCode:(NSInteger)tcar_code Item_id:(NSInteger)tId itemName:(NSString *)tname MaintainMiles:(NSInteger)tmiles Cost:(CGFloat)tcost Date:(NSString *)tdate
{
    if(self=[super init])
    {
        car_code=tcar_code;
        item_id=tId;
        itemname=tname;
        maintainMiles=tmiles;
        cost1=tcost;
        date=tdate;
    }
    return self;
}

-(id)initWithItemId:(NSInteger)tid carId:(NSInteger)tcarId carLicense:(NSString *)tLicense itemName:(NSString *)tName lifeMiles:(NSInteger)lMiles Date:(NSString *)dd
{
    if (self=[super init]) {
        item_id=tid;
        car_code=tcarId;
        carLicense=tLicense;
        itemname=tName;
        lifeMiles=lMiles;
        cost1=cost2=0;
        date=dd;
        
    }
    return self;    
}



@end
