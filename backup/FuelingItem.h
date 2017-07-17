//
//  FuelingItem.h
//  234
//
//  Created by l on 14-7-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuelingItem : NSObject{
  //  CGFloat volume,cost,leftVol,avOil,avCost;
//    NSInteger miles,carId;
    NSString *date;
}
@property CGFloat volume,leftVol,avOil,avCost;
@property CGFloat cost;
@property (nonatomic,retain) NSString *date;
@property NSInteger miles,addMiles,carId;

-(id) initWithVolume:(CGFloat) vol Cost:(CGFloat)ct;
-(id) initWithCurrentMiles:(NSInteger) ms LeftVol:(CGFloat) lVol Volume:(CGFloat) vol Cost:(CGFloat) ct Date:(NSString*) dt;
-(id) initWithCarId:(NSInteger) cId FuelingMiles:(NSInteger) ms AddMiles:(NSInteger) aMiles Volume:(CGFloat) vol Cost:(CGFloat) ct AvOil:(CGFloat) aOil AvCost:(CGFloat) aCost Date:(NSString*) dt;

@end
