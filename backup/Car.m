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
@synthesize car_id,insuranceInterval,inspectInterval;
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

-(void) initNewCarInfo
{
    //FLAG
    flag=1;
    // init maintian info.
    
    // init fueling info.
    OilConsumeRecord *firstRecord=[[OilConsumeRecord alloc] initWithStartDate:@"" EndDate:@"" OilPm:0 CostPm:0];
    [oilConsumeRecords addObject:firstRecord];
    [self updateFuelingInfo];
  
    
    //init respair info.
}

-(BOOL)isAlreadyNewRecord
{
    return [[oilConsumeRecords objectAtIndex:0] isNewRecord];
}

@end
