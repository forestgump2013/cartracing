//
//  PeccancyViewController.h
//  cartracing
//
//  Created by l on 4/14/16.
//
//

#import <UIKit/UIKit.h>

@interface PeccancyViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}

-(IBAction)backward:(id)sender;
@end
