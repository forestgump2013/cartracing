//
//  MaintainRecord.h
//  234
//
//  Created by l on 9/20/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaintainRecord : NSObject
{
  //  NSInteger car_code,item_id,maintainMiles,lifeMiles;
 //   NSString *itemname,*date,*carLicense;
 //   CGFloat cost1,cost2;
}
@property NSInteger car_code,item_id,maintainMiles,lifeMiles,lifeTime;
@property(nonatomic,retain) NSString *itemname,*date,*carLicense;
@property CGFloat cost1,cost2;

-(id)initWithCarCode:(NSInteger)tcar_code  Item_id:(NSInteger) tId itemName:(NSString*) tname MaintainMiles:(NSInteger) tmiles Cost:(CGFloat)tcost Date:(NSString*)tdate;

-(id)initWithItemId:(NSInteger) tid carId:(NSInteger)tcarId carLicense:(NSString*)tLicense itemName:(NSString*) tName lifeMiles:(NSInteger) 
lMiles Date:(NSString*) dd;

@end
