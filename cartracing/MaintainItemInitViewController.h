//
//  MaintainItemInitViewController.h
//  cartracing
//
//  Created by l on 6/5/16.
//
//

#import <UIKit/UIKit.h>

@interface MaintainItemInitViewController : UIViewController<UITextFieldDelegate>{
    BOOL newFlag;
    NSString *itemName;
    NSInteger itemIndex;
    BOOL itemJustTime;
}


@property(nonatomic,retain)  UITableView *parentTable;
@property(nonatomic,retain)  NSMutableArray *buffer;


-(void) setNewItemIndex:(NSInteger) index;
-(void) setisJustTime:(BOOL) isTime;
-(void) setContainerData:(NSMutableArray*) bs containerTable: (UITableView*) table;

-(IBAction)forwardStep:(id)sender;
-(IBAction)backwordStep:(id)sender;
@end
