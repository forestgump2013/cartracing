//
//  SuggestItem.m
//  234
//
//  Created by l on 8/10/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SuggestItem.h"

@implementation SuggestItem
@synthesize license,brandName,suggest,date,clientTel;

-(id) initWithLicense:(NSString *)lic Brand:(NSString *)brand Tel:(NSString *)tel Suggest:(NSString *)sug Date:(NSString *)dt
{
    if(self=[super init])
    {
        self.license=lic;
        brandName=brand;
        clientTel=tel;
        suggest=sug;
        date=dt;
        
    }
    return self;
}


@end
