//
//  RespairSubItem.h
//  234
//
//  Created by l on 2/7/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespairSubItem : NSObject
{
//    NSString *name;
 //   CGFloat cost1,cost2;
}
@property(nonatomic,retain) NSString *name;
@property CGFloat cost1,cost2;

-(id) initWithName:(NSString*) tn Cost1:(CGFloat) c1 Cost2:(CGFloat)c2;

@end
