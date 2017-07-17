//
//  SuggestItem.h
//  234
//
//  Created by l on 8/10/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuggestItem : NSObject
{
    NSString *license,*brandName,*clientTel,*suggest,*date;
}
@property(nonatomic,retain) NSString *license,*brandName,*clientTel,*suggest,*date;
-(id) initWithLicense:(NSString*) lic Brand:(NSString*) brand Tel:(NSString*)tel Suggest:(NSString*) sug Date:(NSString*)dt;
@end
