//
//  CustomProgressView.h
//  234
//
//  Created by l on 5/17/15.
//
//

#import <UIKit/UIKit.h>

@interface CustomProgressView : UIView

@property(nonatomic,retain)UIImageView *progressView,*trackView,*leftProgressView;
@property(nonatomic,retain)UIView *leftRound;
@property CGFloat progressVal;

-(void) setProgress:(CGFloat)val;
-(void) initSet;
-(void) rightIndent;
-(void) restoreFromIndent;
-(void) showAlertWithTag:(NSInteger) tag;

@end
