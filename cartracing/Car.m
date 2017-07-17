//
//  Car.m
//  234
//
//  Created by l on 14-7-1.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "Car.h"
#import "OilConsumeRecord.h"

@implementation Car
@synthesize car_id,insuranceInterval,inspectInterval,inspectLeftDays,insuranceLeftDays,daysConcernedInfo;
@synthesize  currentMiles,initMiles,flag;
@synthesize  totalOilConsumption,totalOilCost,oilBoxVolume;
@synthesize license,inspectDay,insuranceDay;
@synthesize brandName,brandModel,maintainInfo,fuelingInfo,respairInfo,oilConsumeRecords;

-(id) init
{
    if(self=[super init])
    {
        car_id=0;
        currentMiles=0;
        license=@"京A00001";
    }
    return self;
}

-(id) initWithCarId:(NSInteger)carid currentMiles:(NSInteger)miles license:(NSString *)tlicense brand:(NSString *)br Flag:(NSInteger)fag
{
    if(self=[super init])
    {
        car_id=carid;
        currentMiles=miles;
        license=tlicense;
        brandName=br;
        oilConsumeRecords=[NSMutableArray array];
        fuelingInfo=[[NSMutableString alloc] init];
        flag=fag;
    }
    return self;
}

-(void) setfuelingConcernedInfoWithInitMiles:(NSInteger)iMiles BoxVolume:(NSInteger)boxVo TotalVolume:(CGFloat)tVolume TotalFuelingCost:(CGFloat)tCost FuelingInfo:(NSString *)fInfo
{
    initMiles=iMiles;
    self.oilBoxVolume=boxVo;
    self.totalOilConsumption=tVolume;
    self.totalOilCost=tCost;
    
    [self.fuelingInfo setString:fInfo];
    
}

-(id) initTempCar:(NSInteger)miles license:(NSString *)tLicense
{
    if(self=[super init])
    {
        car_id=0;
        currentMiles=miles;
        license=tLicense;
        oilConsumeRecords=[NSMutableArray array]; 
        fuelingInfo=[[NSMutableString alloc] init];        
    }
    return self;
}

-(void) copyData:(Car *)oneCar
{
    car_id=oneCar.car_id;
    currentMiles=oneCar.currentMiles;
    license=[NSString stringWithFormat:@"%@",oneCar.license];
    brandName=[NSString stringWithFormat:@"%@",oneCar.brandName];
}

-(void)initOilConsumeRecordsWithFuelingInfo
{
    NSData *jsonData;
    
    NSError *error;
    id jsonObject;
    NSMutableArray *arr;
    NSDictionary *dictionary;
    NSString *sDate,*eDate,*oilPer,*costPer;
    OilConsumeRecord *record;
    jsonData=[fuelingInfo dataUsingEncoding:NSUTF8StringEncoding];
    jsonObject=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject!=nil) {
        arr=[[NSMutableArray alloc] initWithArray:jsonObject];
        for (int i=0; i<[arr count]; i++) {
            dictionary=[arr objectAtIndex:i];
            oilPer=[dictionary objectForKey:@"oilPer"];
            costPer=[dictionary objectForKey:@"costPer"];
            sDate=[dictionary objectForKey:@"sDate"];
            eDate=[dictionary objectForKey:@"eDate"];
            record=[[OilConsumeRecord alloc] initWithStartDate:sDate EndDate:eDate OilPm:[oilPer floatValue] CostPm:[costPer floatValue] ];
            [self.oilConsumeRecords addObject:record];
            
        }
        
    } else{
        record=[[OilConsumeRecord alloc] init];
        [self.oilConsumeRecords addObject:record];
    }
    if ([oilConsumeRecords count]>0 ) {
        record=[oilConsumeRecords objectAtIndex:0];
        if ([record.endDate isEqual:@""]) {
            [fuelingInfo setString:@"首次记录"];            
        } else [fuelingInfo setString:[record toString]];
    } else [fuelingInfo setString:@"未记录"];    
    
}

-(void)updateFuelingInfo
{
    OilConsumeRecord *record;
    [fuelingInfo  setString:@""] ;
    for (int i=0; i<[oilConsumeRecords count]; i++) {
        record=[oilConsumeRecords objectAtIndex:i];
        [fuelingInfo appendFormat:@"{\"sDate\":\"%@\",\"eDate\":\"%@\",\"oilPer\":\"%f\",\"costPer\":\"%f\"}",record.startDate,record.endDate,record.oilPm,record.costPm];
        
    }
    
    [fuelingInfo appendString:@"]"];
    [fuelingInfo insertString:@"[" atIndex:0];    
    
}

-(void) reComputeOilConsumeWithStartDate:(NSString *)sDate
{
    initMiles=currentMiles;
    totalOilCost=totalOilConsumption=0;
    OilConsumeRecord *record=[[OilConsumeRecord alloc] initWithStartDate:sDate EndDate:@"" OilPm:0 CostPm:0];
    [oilConsumeRecords insertObject:record atIndex:0];
}

-(void) updateOilWearInfo:(NSInteger)cMiles Volume:(float)vol Cost:(float)cost Date:(NSString *)cDate
{
    OilConsumeRecord *latestRecord=[oilConsumeRecords objectAtIndex:0];
    if (totalOilConsumption==0) {
        // new record.
        totalOilConsumption=vol;
        totalOilCost=cost;
        initMiles=cMiles;
        latestRecord.startDate=cDate;
    } else{
        // update the latest record.
        NSInteger addMiles=cMiles-initMiles;
        CGFloat avOil=totalOilConsumption/addMiles;
        CGFloat avCost=totalOilCost/addMiles;
        [latestRecord updateConsumeRecordWithOilPm:avOil CostPm:avCost EndDate:cDate];
        totalOilConsumption+=vol;
        totalOilCost+=cost;
    }
}

-(NSString*) theLatestOilWearInfo
{
    OilConsumeRecord *latestRecord=[oilConsumeRecords objectAtIndex:0];
    return [latestRecord readableInfo];
}

-(void) initNewCarInfo
{
    //FLAG
    flag=1;
    // init maintian info.
    
    // init fueling info.
    OilConsumeRecord *firstRecord=[[OilConsumeRecord alloc] initWithStartDate:@"" EndDate:@"" OilPm:0 CostPm:0];
    [oilConsumeRecords addObject:firstRecord];
    totalOilConsumption=totalOilCost=0;
    
    [self updateFuelingInfo];
  
    
    //init respair info.
}

-(BOOL)isAlreadyNewRecord
{
    return [[oilConsumeRecords objectAtIndex:0] isNewRecord];
}

-(void) computeInspectLeftDays
{
    if (inspectInterval>0 && ![inspectDay isEqualToString:@""]) {
        NSInteger pastDays=[self intervalDaysFromDate:inspectDay];
        inspectLeftDays=inspectInterval*365-pastDays;
    }
}

-(void) computeInsuranceLeftDays
{
    if (insuranceInterval>0 && ![insuranceDay isEqualToString:@""]) {
        NSInteger pastDays=[self intervalDaysFromDate:insuranceDay];
        insuranceLeftDays=insuranceInterval*365-pastDays;
    }
}

-(NSString*)getDaysConcernedInfo
{
    NSString *info=@"";
    if (inspectLeftDays<=30 && inspectLeftDays>0) {
        [info stringByAppendingFormat:@" 距下次年检%d天",(int)inspectLeftDays];
    }
    if (insuranceLeftDays<=30 && insuranceLeftDays>0) {
        [info stringByAppendingFormat:@"  距车险到期%d天",(int)insuranceLeftDays];
    }
    return info;
}

-(NSInteger) intervalDaysFromDate:(NSString *)fromDate
{
    if (fromDate==nil) {
         NSLog(@" maintain intervalDaysFromDate error fromDate:nil");
        return 0;
    }
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
