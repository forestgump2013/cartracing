//
//  Garage.m
//  234
//
//  Created by l on 8/10/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Garage.h"

@implementation Garage
@synthesize name,tel,addr,shortname,business,contact,passid,passed;

-(id) initWithName:(NSString *)na Tel:(NSString *)te Addr:(NSString *)ad
{
    if(self=[super init])
    {
        name=na;
        tel=te;
        addr=ad;
    }
    return self;
}

-(id) initWithShortName:(NSString *)sname Name:(NSString *)nn Tel:(NSString *)tt Contact:(NSString *)cont Business:(NSString *)busi Addr:(NSString *)add Flag:(NSInteger)f
{
    if (self=[super init]) {
        name=nn;
        shortname=sname;
        tel=tt;
        contact=cont;
        business=busi;
        addr=add;
        passed=f;
        
    }
    return self;
}

-(NSString*) getCheckInfo
{
    NSString *str=[[NSString alloc] initWithFormat:@"%@\n%@",addr,passid];
    return str;
}
@end
