//
//  Car.h
//  234
//
//  Created by l on 14-7-1.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject{
  //  NSInteger car_id;
    NSInteger currentMiles,initMiles;
    NSString *brandName,*brandModel;
    NSString *license;
    CGFloat totalOilConsumption,totalOilCost,oilBoxVolume;
    NSString *maintainInfo,*respairInfo;
}

@property NSInteger car_id,inspectInterval,insuranceInterval,inspectLeftDays,insuranceLeftDays;
@property NSInteger currentMiles,initMiles,flag;
@property CGFloat totalOilConsumption,totalOilCost,oilBoxVolume;
@property(nonatomic,retain) NSString *license,*inspectDay,*insuranceDay,*daysConcernedInfo;
@property(nonatomic,retain) NSString *brandName,*brandModel,*maintainInfo,*respairInfo;
@property(nonatomic,retain) NSMutableArray *oilConsumeRecords;
@property(nonatomic,retain) NSMutableString *fuelingInfo;
-(id)initWithCarId:(NSInteger) carid currentMiles: (NSInteger) miles license: (NSString *) tlicense brand:(NSString*) br Flag:(NSInteger) fag;
-(void) setfuelingConcernedInfoWithInitMiles:(NSInteger) iMiles BoxVolume:(NSInteger) boxVo TotalVolume:(CGFloat) tVolume TotalFuelingCost:(CGFloat) tCost FuelingInfo:(NSString*) fInfo;
-(id) initTempCar:(NSInteger) miles license:(NSString*) tLicense;
-(void) initNewCarInfo;
-(void) copyData:(Car*) oneCar;
-(void) initOilConsumeRecordsWithFuelingInfo;
-(void) updateFuelingInfo;
-(void) reComputeOilConsumeWithStartDate:(NSString*) sDate;
-(void) updateOilWearInfo:(NSInteger) cMiles Volume:(float) vol  Cost:(float) cost Date:(NSString*) cDate;
-(NSString*) theLatestOilWearInfo;
-(BOOL) isAlreadyNewRecord;
-(void) computeInspectLeftDays;
-(void) computeInsuranceLeftDays;
-(NSString*) getDaysConcernedInfo;


@end
