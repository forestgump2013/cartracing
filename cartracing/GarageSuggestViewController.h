//
//  GarageSuggestViewController.h
//  cartracing
//
//  Created by l on 10/17/15.
//
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface GarageSuggestViewController : UIViewController{
    AppDelegate *appDelegate;
    NSString *owner,*garageNum;
}

@property(nonatomic,retain) IBOutlet UITextView *suggest;

-(void) setOwner:(NSString*) currentOwner Garage:(NSString*) gNum;

-(void) commitSuggest;

@end
