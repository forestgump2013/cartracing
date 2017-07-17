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
    NSMutableArray *suggestItems,*carClients;
 //   NSString *clientTel,*garageTel;
}
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UILabel *garageTitle;
@property(nonatomic,retain) NSMutableArray *suggestItems,*carClients;
@property NSInteger indicator;
@property(nonatomic,retain) NSString *clientTel;
@property (weak, nonatomic) IBOutlet UITableView *infoTable;
@property(nonatomic,retain) IBOutlet UITextField *garageName,*garageShortName,*garageTel,*garageContact,*garageAddr,*garageBusiness,*garagePasswrod,*garageRePassword;
@property(nonatomic,retain) IBOutlet UIButton *clientBtn,*suggentBtn;
@property(nonatomic,retain) IBOutlet UIScrollView *editViewScrollView;
@property(nonatomic,retain) UIView *editView;
@property(nonatomic,retain) Garage *selfInfo;
//-(IBAction)commitSuggest:(id)sender;
-(void) showEditView;
-(IBAction)commitEditInfo:(id)sender;
-(IBAction)btnPress:(id)sender;
-(IBAction)returnEditView:(id)sender;
-(void) getClientSuggests;
-(void) getClientsInfo;
-(void)getselfGarageInfo;
-(void)garagePass;

@end
