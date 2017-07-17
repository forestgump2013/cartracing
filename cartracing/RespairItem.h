//
//  RespairItem.h
//  234
//
//  Created by l on 7/31/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespairItem : NSObject

{
    NSInteger miles,carId;
    NSString *names;
    CGFloat cost;
    NSString *date;
    NSMutableArray *subItems;
}
@property(nonatomic,retain) NSString *names,*date;
@property(nonatomic,retain) NSMutableArray *subItems;
@property NSInteger miles,carId;
@property CGFloat cost;

-(id) initWithNames:(NSString*) ns Miles:(NSInteger) ms Cost:(CGFloat) ct Date:(NSString*) de;
-(void) analyzeSubItems;
@end
