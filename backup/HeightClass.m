//
//  HeightClass.m
//  234
//
//  Created by l on 5/20/15.
//
//

#import "HeightClass.h"

@implementation HeightClass

@synthesize height;

-(id) initWithHeight:(NSInteger)h
{
    if (self=[super init]) {
        height=h;
    }
    return self;
}
@end
