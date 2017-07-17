//
//  OilConsumeRecord.h
//  234
//
//  Created by l on 3/23/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OilConsumeRecord : NSObject

@property CGFloat oilPm,costPm;
@property NSInteger startMiles,endMiles;
@property (nonatomic,retain) NSString *startDate,*endDate;

-(id) initWithStartDate:(NSString*) sDate EndDate:(NSString*) eDate OilPm:(CGFloat) oilp CostPm:(CGFloat) costp;
-(void) updateConsumeRecordWithOilPm:(CGFloat) oilp CostPm:(CGFloat) costp EndDate:(NSString*) eDate;
-(NSString*) toString;
-(NSString*) readableInfo;

-(BOOL) isNewRecord;

@end
