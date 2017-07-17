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
}
@property(nonatomic,retain) NSString *name,*tel,*addr,*shortname,*business,*contact,*id_code,*passid;
@property NSInteger passed;

-(id) initWithName:(NSString*)na Tel:(NSString*) te Addr:(NSString*)ad;
-(id) initWithShortName:(NSString*) sname Name:(NSString*) nn Tel:(NSString*) tt Contact:(NSString*) cont Business:(NSString*) busi Addr:(NSString*) add Flag:(NSInteger) f;
-(NSString*) getCheckInfo;
@end
