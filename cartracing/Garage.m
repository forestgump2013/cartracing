//
//  Garage.m
//  234
//
//  Created by l on 8/10/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Garage.h"

@implementation Garage
@synthesize name,tel,addr,shortname,business,contact,passid,passed,directLevel,register_date,expire_date;

-(id) init
{
    if(self=[super init])
    {
        name=@"汽车云管理";
        shortname=@"汽车云";
        tel=@"18611030409";
        addr=@"北京市海淀区";
        contact=@"李继军";
        business=@"汽车云服务";
    }
    return self;
    
}

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

-(void) setPayInfo:(CGFloat)payCost validityTime:(NSInteger)time
{
    payment=payCost;
    validityTime=time;
}

-(NSString*) getCheckInfo
{
    NSString *str=[[NSString alloc] initWithFormat:@"%@\n地址:%@\n服务:%@\n支付金额:¥%.2f元\n有效期:%d月",name,addr,business,payment,(int)validityTime/30];
    return str;
}

-(NSString*) getDetailInfo
{
    NSString *str=[[NSString alloc] initWithFormat:@"%@\n地址:%@\n服务:%@\n支付金额:¥%.2f元\n有效期:%@~%@ %d月",name,addr,business,payment,register_date,expire_date,(int)validityTime/30];
    return str;
}

@end
