//
//  CarBrandViewController.h
//  123
//
//  Created by l on 9/3/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface CarBrandViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *keys;
    NSMutableArray *lists;
    NSInteger level;
}
@property(nonatomic,retain) NSString *currentBrand,*currentProducer,*currentSerice,*currentOilUnit,*currentModel;
@property(nonatomic,retain) NSMutableArray *keys;
@property(nonatomic,retain) NSMutableArray *lists;
@property(nonatomic,retain) NSDictionary *brandDictionary; 
@property(nonatomic,retain) UINavigationController *nav;
@property sqlite3 *carBrandDataBase;
@property (weak, nonatomic) IBOutlet UITableView *brandTable;

-(void) setLevel:(NSInteger)val;
//-(void) loadDataWithKeys:(NSMutableArray*) tkeys Lists:(NSMutableArray*) tlist;
-(void) setConditionWithBrand:(NSString*) brd Producer:(NSString*) prr Serice:(NSString*) see;

@end
