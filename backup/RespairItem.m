//
//  RespairItem.m
//  234
//
//  Created by l on 7/31/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "RespairItem.h"
#import "RespairSubItem.h"
@implementation RespairItem
@synthesize names,date;
@synthesize cost;
@synthesize miles,carId;
@synthesize subItems;


-(id) initWithNames:(NSString *)ns Miles:(NSInteger)ms Cost:(CGFloat)ct Date:(NSString *)de
{
    if(self=[super init])
    {
        names=ns;
        miles=ms;
        cost=ct;
        date=de;
        subItems=[NSMutableArray array];
            
    }
    return self;
}

-(void) analyzeSubItems
{
    NSData *subItemsData;
    id jsonObject;
    NSError *error=nil;
    NSMutableArray *arr;
    subItemsData=[names dataUsingEncoding:NSUTF8StringEncoding];
    NSString *subItem,*cost1,*cost2;
    NSDictionary *dictionary;
    jsonObject=[NSJSONSerialization JSONObjectWithData:subItemsData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject!=nil) {
        //    item.subItems=(NSMutableArray*)jsonObject;
        arr=[[NSMutableArray alloc] initWithArray:jsonObject];
        for (int j=0; j<[arr count]; j++) {
            dictionary=[arr objectAtIndex:j];
            subItem=[dictionary objectForKey:@"itemname"];
            cost1=[dictionary objectForKey:@"cost1"];
            cost2=[dictionary objectForKey:@"cost2"];
            [self.subItems addObject:[[RespairSubItem alloc] initWithName:subItem Cost1:[cost1 floatValue] Cost2:[cost2 floatValue]] ];
        }
    }

    
}

@end
