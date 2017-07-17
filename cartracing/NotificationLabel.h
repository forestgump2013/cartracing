//
//  NotificationLabel.h
//  234
//
//  Created by l on 5/29/15.
//
//

#import <UIKit/UIKit.h>

@interface NotificationLabel : UILabel

-(CGSize) getInsetSize;


-(void) showNotificationWithStr:(NSString*)str;
-(void) setRootView:(UIWindow*) rootView;
@end
