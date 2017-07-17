//
//  CarsTableView.h
//  234
//
//  Created by l on 1/26/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface CarsTableView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
 //   NSMutableArray *tableArray;
    AppDelegate *AppDelegate;
    UITableView *table;
    BOOL isVisible;
    CGFloat viewHeight;
}

//@property(nonatomic,retain) NSMutableArray *tableArray;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) UITableView *table;

// plot 0:tracing car view  1: carManageView.
@property NSInteger plot;

-(id)initWithPlot:(int)tPlot AppDelegate:(AppDelegate*) apd;
-(BOOL)isVisible;
-(void) refreshCarsTableView;
-(void) refreshDeletedCarsTableView;


@end
