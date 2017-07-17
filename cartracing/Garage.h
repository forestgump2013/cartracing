//
//  Garage.h
//  234
//
//  Created by l on 8/10/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Garage : NSObject
{
  //  NSString *name,*tel,*addr,*shortname;
    CGFloat payment;
    NSInteger validityTime;
}
@property(nonatomic,retain) NSString *name,*tel,*addr,*shortname,*business,*contact,*id_code,*passid,*register_date,*expire_date;
@property NSInteger passed,directLevel;

-(id) initWithName:(NSString*)na Tel:(NSString*) te Addr:(NSString*)ad;
-(id) initWithShortName:(NSString*) sname Name:(NSString*) nn Tel:(NSString*) tt Contact:(NSString*) cont Business:(NSString*) busi Addr:(NSString*) add Flag:(NSInteger) f;
-(NSString*) getCheckInfo;
-(NSString*) getDetailInfo;
-(void) setPayInfo:(CGFloat)payCost validityTime:(NSInteger) time;
//-(id) initWithDefaultValue;
@end
