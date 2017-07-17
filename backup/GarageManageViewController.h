//
//  GarageManageViewController.h
//  234
//
//  Created by l on 8/1/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  AppDelegate;
@class SuggestItem;
@class Garage;

@interface GarageManageViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    AppDelegate *appDelegate;
    NSMutableArray *suggestItems,*waitedGarages;
 //   NSString *clientTel,*garageTel;
}
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextView *suggestContent;
@property(nonatomic,retain) NSMutableArray *suggestItems,*waitedGarages;
@property(nonatomic,retain) NSString *clientTel;
@property (weak, nonatomic) IBOutlet UITableView *suggestTable,*garageTable;
@property(nonatomic,retain) IBOutlet UITextField *garageName,*garageShortName,*garageTel,*garageContact,*garageAddr,*garageBusiness,*garagePasswrod,*garageRePassword;
@property(nonatomic,retain) UIView *editView;
@property(nonatomic,retain) Garage *selfInfo;
-(IBAction)commitSuggest:(id)sender;
-(void) showEditView;
-(IBAction)commitEditInfo:(id)sender;
-(void)getClientSuggests;
-(void)getselfGarageInfo;
-(void)garagePass;

@end
