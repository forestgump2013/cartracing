//
//  MovingInformation.m
//  cartracing
//
//  Created by l on 1/2/16.
//
//

#import "MovingInformation.h"

@implementation MovingInformation

@synthesize city,date,weekDay,weather,limitNumber,other;

-(id)init
{
    if (self=[super init] ) {
        city=@"";
        date=@"";
        weekDay=@"";
        weather=@"";
        limitNumber=@"";
        other=@"";
    }
    return self;
}

-(NSString*)toString
{
    return [[NSString alloc] initWithFormat:@"%@ %@ %@ %@ %@ %@",city,date,weekDay,weather,limitNumber,other];
}

@end
