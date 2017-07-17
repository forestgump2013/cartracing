//
//  RespairSubItem.m
//  234
//
//  Created by l on 2/7/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RespairSubItem.h"

@implementation RespairSubItem

@synthesize name,cost1,cost2;

-(id)init
{
    if (self=[super init]) {
        name=@"";
        cost1=cost2=0;
    }
    return self;
}

-(id)initWithName:(NSString *)tn Cost1:(CGFloat)c1 Cost2:(CGFloat)c2
{
    if (self=[super init]) {
        self.name=tn;
        cost1=c1;
        cost2=c2;
    }
    return self;
}

@end
