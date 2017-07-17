//
//  AreaViewController.h
//  234
//
//  Created by l on 7/23/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinnerViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
//    NSArray *areaNames;
//    UIButton *areaNameBtn;
}

@property(nonatomic,retain) NSArray *itemsArray;
@property(nonatomic,retain) UIButton *triggerBtn;
@property(nonatomic,retain) IBOutlet UITableView *table;

-(void) initWithData:(NSArray*) dataArray Frame:(CGRect) frame Button:(UIButton*)btn;

@end
