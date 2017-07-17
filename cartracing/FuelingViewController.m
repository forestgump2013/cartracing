//
//  FuelingViewController.m
//  cartracing
//
//  Created by l on 5/15/16.
//
//

#import "FuelingViewController.h"
#import "Car.h"
#import "AppDelegate.h"
#import "TracingCarViewController.h"
#import "FuelingItem.h"
#import "OilConsumeRecord.h"
#import "OilConsumeViewController.h"

@interface FuelingViewController ()

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *fuelingMiles;
@property (weak, nonatomic) IBOutlet UISlider *fuelingLeftPercent;
@property (weak ,nonatomic) IBOutlet UILabel *fuelingleftPercentLabel,*oilPriceInfoBoard;
@property CGFloat fuelingVolue,fuelingCost;
@property (weak, nonatomic) IBOutlet UIButton *fuelingLastOilConsumption;
@property (weak, nonatomic) IBOutlet UITextField *fuelingOilCost;
@property (weak, nonatomic) IBOutlet UITextField *fuelingOilPrice;
@property (weak, nonatomic) IBOutlet UITextField *fuelingOilVolume;
@property(nonatomic,retain) OilConsumeViewController *oilConsumeViewController;

@end

@implementation FuelingViewController

@synthesize appDelegate,scrollView;
@synthesize fuelingMiles;
@synthesize fuelingLeftPercent,oilPriceInfoBoard;
@synthesize fuelingleftPercentLabel;
@synthesize fuelingLastOilConsumption;
@synthesize fuelingOilCost,fuelingCost;
@synthesize fuelingOilPrice;
@synthesize fuelingOilVolume,fuelingVolue,oilConsumeViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (floorf(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self setTitle:@"燃油记录"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
     NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishFuelingRecord)];
    [rightBtn setTitleTextAttributes:fontDic forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:rightBtn];
    
    //
    UIBarButtonItem *returnButtonItem=[[UIBarButtonItem alloc] init];
    [returnButtonItem setTitle:@"返回"];
 //   NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    [returnButtonItem setTitleTextAttributes:fontDic forState:UIControlStateNormal];
    [self.navigationItem setBackBarButtonItem:returnButtonItem];
    
    oilConsumeViewController=[[OilConsumeViewController alloc] initWithNibName:@"OilConsumeViewController" bundle:nil];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [oilPriceInfoBoard setText:appDelegate.oilPriceInfo];
    [oilPriceInfoBoard sizeToFit];
    NSNumber *number=[NSNumber numberWithInteger:appDelegate.currentCar.currentMiles];
    [fuelingMiles setText:[appDelegate.numberFormater stringFromNumber:number]];
    [fuelingLeftPercent setValue:1];
    [fuelingOilPrice setText:[NSString stringWithFormat:@"%.2f",appDelegate.currentOilPrice]];
    self.navigationController.navigationBar.hidden=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)oilLeftSliderChange:(id)sender
{
    [fuelingleftPercentLabel setText:[[NSString alloc] initWithFormat:@"%.0f%%",fuelingLeftPercent.value*100]];
}

-(IBAction)loadOilConsumeViewController:(id)sender
{
    [oilConsumeViewController setData:appDelegate.currentCar.oilConsumeRecords];
    [appDelegate.navigationController pushViewController:oilConsumeViewController animated:YES];
}

-(IBAction)forwardStep:(id)sender
{
    [appDelegate removeFunctionViewController:self];
    [self finishFuelingRecord];
    
}

-(IBAction)backwardStep:(id)sender
{
    [appDelegate removeFunctionViewController:self];
}

-(void) finishFuelingRecord
{
    
    [fuelingMiles resignFirstResponder];
    [fuelingOilVolume resignFirstResponder];
    [fuelingOilCost resignFirstResponder];
    [fuelingOilPrice resignFirstResponder];
    
    
    
    NSString *text=[fuelingMiles text];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger miles =[text intValue];//,totalMiles;
    CGFloat leftPercent=[fuelingLeftPercent value];
    
    /*
    if (miles<appDelegate.currentCar.currentMiles) {
        [appDelegate showNotification:@"里程小于当前里程!"];
        return;
    } */
    
    
    NSDate *sendDate=[NSDate date];
    NSString *date=[appDelegate.dateFormatter stringFromDate:sendDate];
    //  NSLog(@"fueling date:%@",date);
    FuelingItem *item=[[FuelingItem alloc] initWithCurrentMiles:miles LeftVol:leftPercent*appDelegate.currentCar.oilBoxVolume Volume:fuelingVolue Cost:fuelingCost Date:date];
    item.carId=appDelegate.currentCar.car_id;
    FuelingItem *tItem;
    int i;
    
    
    CGFloat wearedOil;
    //---insert fueling record
    
    for(i=0;i<appDelegate.fuelingItems.count;i++)
    {
        tItem=[appDelegate.fuelingItems objectAtIndex:i];
        if(miles>tItem.miles)
        {
            //  NSLog(@"i=%ld",i);
            
            item.addMiles=item.miles-tItem.miles;
            wearedOil=tItem.leftVol+tItem.volume-item.leftVol;
            //     tItem.avOil=wearedOil/item.addMiles;
            //     tItem.avCost=tItem.cost/item.addMiles;
            item.avOil=wearedOil/item.addMiles;   //save the last av_value to the current record.
            item.avCost=tItem.cost/item.addMiles;
            //update fueling record
            //    [appDelegate updateFuelingRecord:tItem];
            if(i>0)
            {
                tItem=[appDelegate.fuelingItems objectAtIndex:(i-1)];
                tItem.addMiles=tItem.miles-item.miles;
                wearedOil=item.leftVol+item.volume-tItem.leftVol;
                //     item.avOil=wearedOil/tItem.addMiles;
                //     item.avCost=item.cost/tItem.addMiles;
                tItem.avOil=wearedOil/tItem.addMiles;
                tItem.avCost=item.cost/tItem.addMiles;
                [appDelegate updateFuelingRecord:tItem];
            }
            
            break;
        }
    }
    [appDelegate.fuelingItems insertObject:item atIndex:i];
    [appDelegate insertFuelingRecord:item];
    [appDelegate postFuelingRecordOfCar:appDelegate.currentCar Record:item];
    //---compute recent three months oil consumption
    
    //compute total oil consume
    [appDelegate.currentCar updateOilWearInfo:miles Volume:fuelingVolue Cost:fuelingCost Date:date];
    /*
    OilConsumeRecord *oilConsumeRecord;
    appDelegate.currentCar.totalOilConsumption+=item.volume;
    appDelegate.currentCar.totalOilCost+=item.cost;
    oilConsumeRecord=[appDelegate.currentCar.oilConsumeRecords objectAtIndex:0];
    if ([appDelegate.fuelingItems count]==1) {
        appDelegate.currentCar.initMiles=miles;
        //   [appDelegate.currentCar.fuelingInfo setString: @"首次记录"];
        //    oilConsumeRecord=[[OilConsumeRecord alloc] initWithStartDate:date EndDate:date OilPm:0 CostPm:0];
        //    [appDelegate.currentCar.oilConsumeRecords addObject:oilConsumeRecord];
        oilConsumeRecord.startDate=date;
        
    }else{
        totalMiles=(int)(miles-appDelegate.currentCar.initMiles);
        //   appDelegate.currentCar.fuelingInfo=[[NSString alloc] initWithFormat:@"油耗:%.2f升/公里 %.2f元/公里",appDelegate.currentCar.totalOilConsumption/totalMiles, appDelegate.currentCar.totalOilCost/totalMiles ];
        
        [oilConsumeRecord updateConsumeRecordWithOilPm:appDelegate.currentCar.totalOilConsumption/totalMiles CostPm:appDelegate.currentCar.totalOilCost/totalMiles EndDate:date];
        //     [appDelegate.currentCar.fuelingInfo setString:[[NSString alloc] initWithFormat:@"%.2f 升/公里  %.2f 元/公里 \n %@~%@",oilConsumeRecord.oilPm,oilConsumeRecord.costPm,oilConsumeRecord.startDate,oilConsumeRecord.endDate] ];
        NSLog(@"the latest fueling info:%@",appDelegate.currentCar.fuelingInfo);
    }
    
    */
    
    [appDelegate.currentCar updateFuelingInfo];
    
    [appDelegate.tracingCarViewController finishFunctionOprationWithMiles:miles];
    
  //  [appDelegate.navigationController popViewControllerAnimated:NO];
    
    
}


-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==fuelingOilPrice) {
        appDelegate.currentOilPrice=[fuelingOilPrice.text floatValue];
        return YES;
    }else if (textField==fuelingOilVolume) {
        if (appDelegate.currentOilPrice==0) {
            [appDelegate showNotification:@"油价为空!"];
            return YES;
        }
        //  appDelegate.oilPrice=[fuelingOilPrice.text floatValue];
        if ([fuelingOilVolume.text isEqualToString:@""]) {
            return YES;
        }
        if (![fuelingOilCost.text isEqualToString:@""]) {
            fuelingOilCost.text=@"";
        }
        fuelingVolue=[[fuelingOilVolume.text stringByReplacingCharactersInRange:range withString:string] floatValue];
        fuelingCost=fuelingVolue*appDelegate.currentOilPrice;
        [fuelingOilCost setPlaceholder:[[NSString alloc] initWithFormat:@"%.2f",fuelingCost]];
        return YES;
    }else  if (textField==fuelingOilCost) {
        if (appDelegate.currentOilPrice==0) {
            //[fuelingOilPrice.text isEqualToString:@""]
            [appDelegate showNotification:@"油价为空!"];
            return YES;
        }
        //    appDelegate.oilPrice=[fuelingOilPrice.text floatValue];
        if ([fuelingOilCost.text isEqualToString:@""]) {
            return YES;
        }
        if (![fuelingOilVolume.text isEqualToString:@""]) {
            fuelingOilVolume.text=@"";
        }
        fuelingCost=[[fuelingOilCost.text stringByReplacingCharactersInRange:range withString:string] floatValue];
        fuelingVolue=fuelingCost/appDelegate.currentOilPrice;
        [fuelingOilVolume setPlaceholder:[[NSString alloc] initWithFormat:@"%.2f",
                                          fuelingVolue]];
        return YES;
    }else if(textField==fuelingMiles){
        NSString *text=[textField.text stringByReplacingCharactersInRange:range withString:string ];
        text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSNumber *number=[NSNumber numberWithInt:[text intValue]];
        [textField setText:[appDelegate.numberFormater stringFromNumber:number] ];
        return NO;
    }
    return NO;
}

@end
