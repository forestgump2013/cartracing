//
//  OilConsumeRecord.m
//  234
//
//  Created by l on 3/23/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OilConsumeRecord.h"

@implementation OilConsumeRecord

@synthesize oilPm,costPm,startDate,endDate,startMiles,endMiles;

-(id) initWithStartDate:(NSString *)sDate EndDate:(NSString *)eDate OilPm:(CGFloat)oilp CostPm:(CGFloat)costp
{
    if (self=[super init]) {
        startDate=sDate;
        endDate=eDate;
        oilPm=oilp;
        costPm=costp;
        
    }
    return self;
}

-(void) updateConsumeRecordWithOilPm:(CGFloat)oilp CostPm:(CGFloat)costp EndDate:(NSString *)eDate
{
    oilPm=oilp;
    costPm=costp;
    endDate=eDate;
}

-(NSString*) toString
{
    if ([startDate isEqualToString:@""]) {
        return @"油耗信息";
    } else if([endDate isEqualToString:@""])
        return @"首次记录";
    else
    return [[NSString alloc] initWithFormat:@"%.2f 升/公里  %.2f 元/公里 \n %@~%@",self.oilPm,self.costPm,self.startDate,self.endDate];
}

-(NSString*) readableInfo
{
    if ([startDate isEqualToString:@""]) {
        return @"油耗信息";
    } else if([endDate isEqualToString:@""])
        return @"首次记录";
    else
        return [[NSString alloc] initWithFormat:@"%.2f 升/公里  %.2f 元/公里 \n %@~%@",self.oilPm,self.costPm,self.startDate,self.endDate];
}

-(BOOL) isNewRecord
{
    if ([startDate isEqualToString:@""] || [endDate isEqualToString:@""]) {
        return TRUE;
    } else return FALSE;
}

@end
