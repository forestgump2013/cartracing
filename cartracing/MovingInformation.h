//
//  MovingInformation.h
//  cartracing
//
//  Created by l on 1/2/16.
//
//

#import <Foundation/Foundation.h>

@interface MovingInformation : NSObject

@property(nonatomic,retain) NSString *city,*weekDay,*weather,*date,*limitNumber,*other;
-(NSString*) toString;

@end
