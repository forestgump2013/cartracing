//
//  AppDelegate.m
//  234
//
//  Created by l on 14-6-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MaintainItem.h"
#import "MaintainRecord.h"
#import "FuelingItem.h"
#import "RespairItem.h"
#import "RespairSubItem.h"
#import "TracingCarViewController.h"
#import "CreateNewCarViewController.h"
#import "LoginViewController.h"
#import "CarManageViewController.h"
#import "PersonalCenterViewController.h"
#import "MaintainItemInitViewController.h"
#import "CarsTableView.h"
#import "Car.h"
#import "Garage.h"
#import "NotificationLabel.h"
#import "MovingInformation.h"
#import "SpinnerViewController.h"
//#import "MyQuartzView.h"

@implementation AppDelegate

@synthesize window = _window,lock;
@synthesize memberType,getDataFromCloud,serverAddr,dateFormatter,numberFormater;
@synthesize currentCarId,weatherInfo,province;
@synthesize notificationInfo,activityIndicatorView,movingInfo;
@synthesize currentOilPrice,screenWidth,screenHeight;
@synthesize loginDate,ownerTel,garageTel,dateInfo,city,carLimitInfo,currentElementName,currentVal,oilPriceInfo;
@synthesize currentCar,customGarage,currentInputDate,currentEditItem;
@synthesize  tracingCarViewController,createNewCarViewController;
@synthesize loginViewController;
@synthesize carsTableView,spinnerView,scanLine,slowDownAnimation;
@synthesize personalCenterViewController;
@synthesize database,carBrandDataBase,brandDictionary,areaCodeArray,carCheckYearUnits,itemDetails;
@synthesize maintainItems,maintainRecords;
@synthesize fuelingItems,respairItems;
@synthesize cars,deletedCars,relatedGarages,directRelatedGarages;
@synthesize navigationController,leftNavigationController,autoNavigationController;
@synthesize itemInitItemName,itemInitLatestMaintainMiles,addMaintainItemName,itemInitMaintainLifeMiles,itemInitLatestMaintainDate,itemInitLatestMaintainDateDiv,accessoryView,customInput,maintainItemSetScrollView,maintainItemInitView,maintainItemInitViewController;

-(NSString *) dataFilePath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:kFileName];
}

-(NSString *) archiveFilePath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:kArchiveFileName];
}

-(void) initBrandDictionary
{
  //  NSArray *test=[NSArray arrayWithObjects:@"",@"tt", nil];
    NSArray *brandKeys=[NSArray arrayWithObjects:@"奥迪",@"宝龙",@"宝马",@"别克",@"凯迪拉克",
@"昌河",@"雪佛兰",@"克莱斯勒",@"雪铁龙",@"东风风行",
@"东南",@"大众",@"福特",@"哈飞",@"本田",
                        @"红旗",@"现代",@"Jeep",@"江铃",@"起亚",
                        @"路虎",@"雷克萨斯",@"猎豹汽车",@"林肯",@"马自达",
                        @"奔驰",@"三菱",@"日产",@"欧宝",@"标致",
                        @"雷诺",@"荣威",@"斯柯达",@"斯巴鲁",@"铃木",
                        @"丰田",@"五菱",@"夏利",@"一汽",@"中华",
                        @"中兴",@"世爵",@"众泰",@"全球鹰",@"力帆",
                        @"双环",@"双龙",@"大宇",@"奇瑞",@"威兹曼",
                        @"威麟",@"宾利",@"帝豪",@"开瑞",@"江淮",
                        @"沃尔沃",@"海马",@"瑞麒",@"西雅特",@"讴歌",
                        @"迈巴赫",@"道奇",@"长安商用",@"GMC",@"AC Schnitzer",
                        @"阿尔法·罗密欧",@"阿斯顿·马丁",@"保斐利",@"保时捷",@"北京汽车",
                        @"北汽制造",@"北汽威旺",@"北汽新能源(1)",@"北汽新能源(2)",@"奔腾",
                        @"宝骏",@"巴博斯",@"布加迪",@"比亚迪",@"长城",
                        @"长安轿车",@"DS",@"东风小康",@"东风御风",@"东风风度",
                        @"东风风神",@"东风风行",@"光冈",@"广汽",@"广汽吉奥",
                        @"广汽日野",@"观致汽车",@"华泰",@"哈弗",@"恒天汽车",
                        @"汇众",@"海格",@"海马商用车",@"黄海",@"法拉利",
                        @"福汽启腾",@"福田",@"福田欧辉",@"福迪",@"菲亚特",
                        @"飞驰商务车",@"九龙",@"吉利汽车",@"捷豹",@"江南",
                        @"江淮安驰",@"江淮客车",@"金旅客车",@"金杯",@"金龙联合",
                        @"KTM",@"卡威",@"卡尔森",@"科尼塞克",@"科瑞斯",
                        @"兰博基尼",@"劳斯莱斯",@"理念",@"莲花",@"蓝海房车",
                        @"路特斯",@"陆风",@"MG",@"MINI",@"摩根",
                        @"玛莎拉蒂",@"迈凯伦",@"纳智捷",@"欧朗",@"启辰",
                        @"庆铃",@"smart",@"上汽大通MAXUS",@"山姆",@"绅宝",
                        @"陕汽通家",@"泰卡特",@"特斯拉",@"腾势",@"潍柴英致",
                        @"新凯",@"星客特",@"依维柯",@"扬州亚星客车",@"永源",
                        @"英菲尼迪",@"野马汽车",@"中欧",@"中通客车",@"之诺",
                        @"浙江卡尔森",nil];
    NSArray *objects=[NSArray arrayWithObjects:@"audi",@"baolong",@"bmw",@"buick",@"cadillac",
                      @"changhe",@"chevrolet",@"chrysler",@"citroen",@"dongfeng",
                      @"dongnan",@"dos",@"ford",@"hafei",@"honda",
                      @"hongqi",@"hyundai",@"jeep",@"jiangling",@"kia",
                      @"landrover",@"lexus",@"liebao",@"lincoln",@"mazda",
                      @"mercedes",@"mitsubishi",@"nissan",@"oubao",@"peugeot",
                      @"renault",@"roewe",@"skoda",@"subaru",@"suzuki",
                      @"toyota",@"wuling",@"xiali",@"yiqi",@"zhonghua",
                      @"zhongxing",@"shijue",@"zhongtai",@"quanqiuying",@"lifan",
                      @"shuanghuan",@"shuanglong",@"dayu",@"qirui",@"weiziman",
                      @"weilin",@"binli",@"dihao",@"kairui",@"jianghuai",
                      @"volvo",@"haima",@"ruilin",@"xiyate",@"ouge",
                      @"maibahe",@"daoqi",@"changan_business",@"gmc",@"acschnitzer",
                      @"alfaromeo",@"asidoumading",@"bufari",@"porsche",@"beijingqiche",
                      @"biqizhizao",@"beiqiweiwang",@"biqixinnengyuan",@"biqixinnengyuan",@"benteng",
                      @"baojun",@"barbus",@"bugatti",@"biyadi",@"greatwall",
                      @"changan_jeep",@"ds",@"dongfengxiaokang",@"dongfeng",@"dongfengfengdu",
                      @"dongfengfengshen",@"dongfengfengxing",@"mitsuoka",@"guangqichuanqi",@"guangqijiao",
                      @"guangqiriye",@"guangzhi",@"huadai",@"hafu",@"hengtian",
                      @"huizhong",@"haige",@"haimashangyong",@"huanghai",@"ferrari",
                      @"fuqiqiteng",@"futian",@"futian",@"fudi",@"fiat",
                      @"speedautomobile",@"jiulong",@"jiliqiche",@"jaguar",@"jiangnan",
                      @"jianhuaianchi",@"jianghuaikeche",@"jinlvkeche",@"jinbei",@"jinlong",
                      @"ktm",@"kawei",@"carlsson",@"koenigsegg",@"krius",
                      @"lamborghini",@"rollsroyce",@"everus",@"lianhua",@"lanhaifangche",
                      @"lotus",@"lufeng",@"mg",@"mini",@"morgan",
                      @"maserati",@"mclaren",@"luxgen",@"oulang",@"qichen",
                      @"qingling",@"smart",@"maxus",@"shanmu",@"kunbao",
                      @"shanqitongjia",@"techs",@"tesla",@"tengshi",@"yingzhi",
                      @"xinkai",@"starcoach",@"iveco",@"yaxing",@"yongyuan",
                      @"infiniti",@"yema",@"zhongou",@"zhongtongkeche",@"zhinuo",
                      @"zhejiangkarlsson", nil];
    brandDictionary=[[NSDictionary alloc] initWithObjects:objects forKeys:brandKeys];
   //  NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"25",@"age",@"张三",@"name",@"男",@"性别",nil];   
  //  NSLog(@"initBrandDictionary 福特:%@", [brandDictionary objectForKey:@"福特"]) ;
    
}

-(NSString*) getMarkWithBrand:(NSString *)brand
{
    int i;
    char c;
    for (i=0; i<[brand length]; i++) {
        c= [brand characterAtIndex:i];
        if (c==' ' || c=='\0') {
            break;
        }
        
    }
    NSString *brandTitle=[brand substringToIndex:i];
    NSLog(@"getMarkWithBrand:%@",brandTitle);
    return  [[NSString alloc] initWithFormat:@"%@.png",[brandDictionary objectForKey:brandTitle]];   
}


-(void) initDataBase
{ 
    NSString *carBrandDataBasePath=[[NSBundle mainBundle] pathForResource:@"carBrand" ofType:@"db"];
    if(sqlite3_open([carBrandDataBasePath UTF8String], &carBrandDataBase) !=SQLITE_OK)
    {
        sqlite3_close(carBrandDataBase);
        NSAssert(0,@"Failed to open carbranddatabase");
    }
    [self selectAllCarBrand];
   
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) !=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database" );
    }
    
    //update table struct
   // [self dropAllTables];
   // [self clearDataBase];
    char *errMsg;
    NSString *createSQL=@"CREATE TABLE IF NOT EXISTS  CARS_TABLE (CAR_ID INTEGER PRIMARY KEY , BRAND_NAME TEXT,BRAND_MODEL TEXT , CURRENT_MILES INTEGER ,INIT_MILES INTEGER, TOTAL_OILVOLUME REAL,TOTAL_OILCOST REAL,OILBOX_VOLUME REAL, LICENSE TEXT,MAINTAIN_INFO TEXT,FUELING_INFO TEXT,RESPAIR_INFO TEXT,INSPECT_DATE TEXT,INSPECT_INTERVAL INTEGER,INSURANCE_DATE,INSURANCE_INTERVAL INTEGER, FLAG INTEGER)";
    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errMsg) !=SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Error create table: %s", errMsg);
    }
    
    createSQL=@"CREATE TABLE IF NOT EXISTS  MAINTAIN_ITEMS_TABLE (ITEM_ID INTEGER , CAR_ID INTEGER , ITEM_NAME TEXT, LIFE_MILES INTEGER,LIFE_TIME INTEGER, LATEST_MAINTAIN_MILES INTEGER, LATEST_MAINTAIN_TIME TEXT, LEFT_PERCENT INTEGER, TIME_LEFT_PERCENT INTEGER, LEFT_MILES INTEGER , LEFT_DAYS INTEGER ,APPLY_MARK INTEGER,TAG INTEGER, PRIMARY KEY(ITEM_ID,CAR_ID))";
    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errMsg) !=SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Error create table MAINTAIN_ITEMS_TABLE : %s", errMsg);
    }
    
    createSQL=@"CREATE TABLE IF NOT EXISTS  MAINTAIN_RECORD_TABLE (ITEM_ID INTEGER , CAR_ID INTEGER , ITEM_NAME TEXT,MAINTAIN_MILES INTEGER, MAINTAIN_COST FLOAT,MAINTAIN_DATE TEXT )";
    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errMsg) !=SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Error create table MAINTAIN_ITEMS_TABLE : %s", errMsg);
    }    
    
    createSQL=@"CREATE TABLE IF NOT EXISTS FUELING_TABLE( CAR_ID INTEGER,OIL_VOLUME REAL,AV_OIL REAL,OIL_COST REAL,AV_COST REAL ,LAST_LEFT_VOLUME REAL, CURRENT_MILES INTEGER,ADD_MILES INTEGER, DATE TEXT)";
    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errMsg) !=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"Error create talbe FUELING_TABLE: %s", errMsg);
    }
    
    
    
    
    createSQL=@"CREATE TABLE IF NOT EXISTS RESPAIR_TABLE(CAR_ID INTEGER,NAMES TEXT,MILES INTEGER, COST REAL,DATE TEXT)";
    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errMsg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"Error in create table respair_table", errMsg);
    }
    
    NSLog(@"init database is worked!");
    [self.tracingCarViewController setDatabase:database];
  
}

-(void) restoreOneCar:(Car *)aCar
{
    //UPDATE FALAG
    NSString *sql=[NSString stringWithFormat:@"UPDATE CARS_TABLE SET FLAG=1   WHERE CAR_ID=%d ",(int)aCar.car_id];
    char *msg;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in restoreOneCar", msg);
    }
    
}

-(void) deleteOneCar:(NSInteger)car_id
{
    NSString *sql=[NSString stringWithFormat:@"UPDATE CARS_TABLE  SET FLAG=0  WHERE CAR_ID=%d ",(int)car_id];
    char *msg;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in delete from cars_table", msg);
    }
}

-(void)clearDataBase
{
    [lock lock];
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM CARS_TABLE ; "];
    char *msg;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in clear from cars_table", msg);
    }
    sql=[NSString stringWithFormat:@"DELETE FROM MAINTAIN_ITEMS_TABLE; "];
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in clear from maintain_table", msg);
    }
    sql=[NSString stringWithFormat:@"DELETE FROM MAINTAIN_RECORD_TABLE; "];
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in clear from maintain_table", msg);
    }
    
    sql=[NSString stringWithFormat:@"DELETE FROM FUELING_TABLE  "];
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in clear from fueling_table", msg);
    } 
    sql=[NSString stringWithFormat:@"DELETE FROM RESPAIR_TABLE ; "];
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in clear from respair_table", msg);
    }     
    
    [cars removeAllObjects];
    [maintainItems removeAllObjects];
    [maintainRecords removeAllObjects];
    [fuelingItems removeAllObjects];
    [respairItems removeAllObjects];
    [relatedGarages removeAllObjects];
    [lock unlock];
}

-(void)dropTableWithName:(NSString *)tableName
{
    NSString *sql=[NSString stringWithFormat:@" DROP TABLE %@ ; ",tableName];
    char *msg;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in drop table", msg);
    }    
    
}

-(void)dropAllTables
{
    [self dropTableWithName:@"CARS_TABLE"];
    [self dropTableWithName:@"MAINTAIN_ITEMS_TABLE"];
     [self dropTableWithName:@"MAINTAIN_RECORD_TABLE"];    
    [self dropTableWithName:@"FUELING_TABLE"];
    [self dropTableWithName:@"RESPAIR_TABLE"];        
     
}

-(void) updateDatabase
{
    NSString *sql=@"drop table if exists RESPAIR_TABLE ";
    char *errMsg;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errMsg) !=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in drop RESPAIR_TABLE", errMsg);
    }
}

-(void) selectAllCarBrand
{
    NSString *query=@"select * from car_brand_table group by brand";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(carBrandDataBase, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
      //  char *str;
     //   NSString *brand;
        while (sqlite3_step(statement)==SQLITE_ROW) {
          //  str=(char*)sqlite3_column_text(statement, 1);
       //     brand=[[NSString alloc] initWithUTF8String:str];
      //      NSLog(brand);
        }
    }
}

-(void) getAllCars
{
    
    NSString *query=@"select CAR_ID,BRAND_NAME,CURRENT_MILES,LICENSE,INIT_MILES,TOTAL_OILVOLUME,TOTAL_OILCOST,FUELING_INFO, FLAG ,INSPECT_INTERVAL,INSURANCE_INTERVAL,INSPECT_DATE,INSURANCE_DATE FROM CARS_TABLE ORDER BY CAR_ID ASC";
    sqlite3_stmt *statement;
    NSInteger init_miles,currentMiles,flag,interval;
    CGFloat oilVolume,oilCost;
    char* str;
    NSString *fuelingInfo,*brandName;
  
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSInteger carid=sqlite3_column_int(statement, 0);
            char *tbrandName=(char*)sqlite3_column_text(statement, 1);
            brandName=[[NSString alloc] initWithUTF8String:tbrandName];
            currentMiles=sqlite3_column_int(statement,2);
            char *tlicense=(char*)sqlite3_column_text(statement, 3);
            init_miles=sqlite3_column_int(statement, 4);
            oilVolume=sqlite3_column_double(statement, 5);
            oilCost=sqlite3_column_double(statement, 6);
            
            if(tlicense==nil)
            {
       //         tlicense="nullString";
                break;
            }           
            NSString *license=[[NSString alloc] initWithUTF8String:tlicense];
            str=(char*)sqlite3_column_text(statement, 7);
            flag=sqlite3_column_int(statement,8);
            fuelingInfo=[[NSString alloc] initWithUTF8String:str];
            Car *oneCar=[[Car alloc] initWithCarId:carid currentMiles:currentMiles license:license brand:brandName Flag:flag];
            [oneCar setBrandName:brandName];
            oneCar.initMiles=init_miles;
            oneCar.totalOilCost=oilCost;
            oneCar.totalOilConsumption=oilVolume;
            [oneCar.fuelingInfo setString:fuelingInfo];
            [oneCar initOilConsumeRecordsWithFuelingInfo] ;
            
            interval=sqlite3_column_int(statement,9);
            if (interval>0) {
                char *tDate=(char*)sqlite3_column_text(statement, 10);
                oneCar.inspectInterval=interval;
                oneCar.inspectDay=[[NSString alloc] initWithUTF8String:tDate];
                [oneCar computeInspectLeftDays];
            }
            
            interval=sqlite3_column_int(statement,11);
            if (interval>0) {
                char *tDate=(char*)sqlite3_column_text(statement, 12);
                oneCar.insuranceInterval=interval;
                oneCar.insuranceDay=[[NSString alloc] initWithUTF8String:tDate];
                [oneCar computeInsuranceLeftDays];
            }
            if(carid==currentCarId)
            {
                /*
                currentCar.car_id=currentCarId;
                currentCar.currentMiles=currentMiles;
                currentCar.license=license;
                currentCar.brandName=brandName;
                */
                currentCar=oneCar;
            }
            if (flag==1) {
                [cars addObject:oneCar];
            }else [deletedCars addObject:oneCar];
        }
        if ([cars count]>0) {
            [self.tracingCarViewController refreshView];
            NSLog(@"car count:%d",(int)[cars count]);
        }else {
            [navigationController pushViewController:createNewCarViewController animated:NO];
            NSLog(@" create new car view is loaded!");
            
        }
        
    } else {
        NSLog(@"get all cars error!");
    }

}   

-(void) initMaintainItems
{
    
    [maintainItems removeAllObjects];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:1 itemName:@"机油" lifeMiles:5000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:2 itemName:@"机油滤芯" lifeMiles:5000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:3 itemName:@"空气滤清器" lifeMiles:10000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:4 itemName:@"空调滤清器" lifeMiles:20000 latestMaintinMiles:0 leftPercent:100]];
    
    
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:5 itemName:@"汽油滤清器" lifeMiles:10000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:6 itemName:@"变速箱油" lifeMiles:30000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:7 itemName:@"转向助力油" lifeMiles:50000 latestMaintinMiles:0 leftPercent:100]];
    //-----
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:8 itemName:@"火花塞" lifeMiles:40000 latestMaintinMiles:0 leftPercent:100]];
    
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:9 itemName:@"刹车油" lifeMiles:30000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:10 itemName:@"防冻液" lifeMiles:40000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:11 itemName:@"检查刹车片" lifeMiles:40000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:12 itemName:@"轮胎换位" lifeMiles:40000 latestMaintinMiles:0 leftPercent:100]];
    
    
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:13 itemName:@"四轮定位" lifeMiles:50000 latestMaintinMiles:0 leftPercent:100]];
    //---
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:14 itemName:@"清洗喷油嘴" lifeMiles:10000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:15 itemName:@"清洗油路" lifeMiles:20000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:16 itemName:@"清洗进气道" lifeMiles:30000 latestMaintinMiles:0 leftPercent:100]];
    
}

-(void) initGlobalData
{
    currentCar=[[Car alloc] init];
    cars=[NSMutableArray array];
    deletedCars=[NSMutableArray array];
    maintainItems=[NSMutableArray array];
    maintainRecords=[NSMutableArray array];
    fuelingItems=[NSMutableArray array];
    respairItems=[NSMutableArray array];
    
    relatedGarages=[NSMutableArray array];
    customGarage=[[Garage alloc] initWithShortName:@"定制汽修" Name:@"汽修厂全称" Tel:@"010-87654321" Contact:@"联系人" Business:@"汽修厂服务" Addr:@"汽修厂地址" Flag:3];
    
    directRelatedGarages=[NSMutableArray array];
    lock=[NSLock new];
    areaCodeArray=[[NSArray alloc] initWithObjects:@"京",@"津",@"沪",@"渝",@"冀",@"蒙",@"晋",@"黑",@"吉",@"辽",@"皖",@"苏",@"浙",@"闽",@"鲁",@"赣",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",nil];
    carCheckYearUnits=[[NSArray alloc] initWithObjects:@"1年",@"2年",@"3年",@"4年",@"5年",@"6年",nil];
    itemDetails=[[NSArray alloc] initWithObjects:@"润滑油在作用过程中，添加剂被逐渐消耗，燃烧产生的污染物与机油混合产生油泥、沉积，时间一长，这些污垢不但会加速发动机磨损，还会导致发动机锈化腐蚀、散热不畅等严重后果。因此，及时更换机油是对发动机最好的呵护。\n更换周期:一般车辆每5000公里更换一次(或参照车辆保养手册)",
                 @"(简称机滤)机滤的作用是过滤机油内各种杂质，防止杂质对发动机造成磨损，如长期不更换机滤，会使机滤因污垢而部分堵塞，污染物就直接流进发动机，加剧机件磨损；如仅更换机油而不更换机滤，旧机滤内残留的被污染机油会重新进入机油中循环，所以，专家强调:每次换油时应更换机滤。\n更换周期:每次更换机油时更换(或参照车辆保养手册)",
                 @"(简称空滤)发动机燃烧的是汽油/柴油与空气的混合物，叫做“油气混合物”。油气混合物中的空气，经空气滤清器过滤后进入发动机。如空气滤清器过脏会导致空气进入不顺畅，有些微小颗粒还会“挤”进发动机对高速运动的发动机缸体造成严重的磨损。所以，空气滤清器的滤芯必须定期更换。\n更换周期:一般车辆每20000公里更换一次(或参照车辆保养手册)",
                 @"(简称空调滤)空调滤清器是保证车内人员健康的重要损耗品之一，其主要作用是隔绝外界进入车内空气中的各种粉尘及有害物质。如长时间不更换空调滤网，容易对乘车人的健康造成伤害。\n更换周期:一般车辆每20000公里更换一次(或参照车辆保养手册)",
                 @"(简称汽滤)汽油滤清器主要功能是滤除汽油中的杂质。如果汽油滤清器过脏或堵塞，主要表现为:加油门时，动力起来较慢，或起不来，汽车启动困难。\n更换周期:一般车辆每20000公里更换一次(或参照车辆保养手册)",
                 @"(齿轮油)变速箱内部的齿轮高速旋转来传递动力，所以需要齿轮油来润滑、冷却、清洁、防腐等。齿轮油长期在高温下可能变质，导致润滑效果下降，对齿轮的保护作用降低，如不更换会加速齿轮的磨损，导致硬性故障出现。油品变质后也会生成油泥，出现换挡阀卡滞，表现出来的是换挡冲击，车辆噪音增大。长期让变速箱在恶劣润滑油里工作，还会导致变速不畅，增加阻力的同时也会增大油耗。\n更换周期:一般车辆每40000公里更换一次(或参照车辆保养手册)",
                 @"转向助力油是对转向系统起液压传递和润滑保护作用。如果过期变质，助力油的润滑效果下降，转向助力泵和转向机就会磨损加剧，容易出现硬性故障，零部件的寿命缩短。另一方面，过期会使助力系统内部生成油泥，影响助力效果，转向沉。\n更换周期:一般车辆每40000公里更换一次(或参照车辆保养手册)",
                 @"火花塞的新旧对油耗也有直接影响，如果火花塞使用时间过久，会出现点火不顺畅，进而增大油耗。车主可在车辆回场维修或保养时，要求工人随机拆下一个火花塞进行目测，如果火花塞的金属极出现发黑或发白时，均是不正常现象，如果发黑物质可以用金属丝刮出，则火花塞进行简单清洁后还可继续使用，但如果发白或发黑且不能清除，则必须更换火花塞。\n更换周期:一般车辆每40000公里更换一次(或参照车辆保养手册)",
                 @"(制动油)制动油的容积会随着温度的变化而变化，因此刹车油储油壶上设有通气孔，从该孔被吸进的空气里含有水分或杂质，水分会被制动液吸收或溶解，因此含有水分的制动油沸点会降低。当汽车长时间行驶制动时，制动系统的温度升高，制动管路容易产生气阻，空气被压缩，从而造成制动力下降或制动失灵的可能。因此为了您的行车安全，刹车油必须定期更换。\n更换周期:一般车辆每40000公里更换一次(或参照车辆保养手册)",
                 @"(冷却液)防冻液也称冷却液，是汽车发动机工作降温保证正常工作的条件，锈迹和水垢会限制防冻液在冷却系统中的流动，降低散热作用，导致发动机过热，甚至造成发动机损坏。防冻液氧化还会形成酸性物质，腐蚀水箱的金属部件，造成水箱破损、渗漏。所以要按时清洗，更换或添加防冻液，以提高沸点，延长使用寿命，防止产生水垢、锈蚀及提升散热效果，使水泵产生润滑作用，避免与消除气泡引起瞬间高温所造成的对发动机的伤害。\n更换周期:一般车辆每40000公里更换一次(或参照车辆保养手册)",
                 @"刹车片由两部分组成:一层是金属制的基盘，一层是摩擦片。 刹车时，摩擦片与刹车盘接触产生摩擦，起到刹车的作用。 摩擦片会越来越薄。 新刹车片的摩擦片部分一般是10毫米， 当剩下5毫米时，就该考虑更换刹车片了。 剩下2毫米时就相当危险了，必须立即更换刹车片。否则会导致刹车失灵酿成事故。\n检查周期:一般车辆每5000公里一次",
                 @"车辆的驱动方式一般分为前驱、后驱和四驱，驱动轮的磨损速度会更快，汽车行驶一定里程后，各不同部位的轮胎在疲劳和磨损程度上就会出现差别，经常换位绝对有助于保证轮胎的均匀磨耗，从而延长轮胎的使用寿命。因此建议您根据行驶的里程数或道路情况适时的进行轮胎换位。\n更换周期:一般车辆每20000公里更换一次",
                 @"为了保障汽车在行驶、转弯状况下的安全性、稳定性，轮胎安装是都有一定的倾斜度(称四轮定位)，以达到最佳行驶的效果。车辆经过一段时间的使用，特别在车辆运行时发生行驶跑偏，方向盘抖动，行驶稳定性差，“吃胎”、“肯胎”现象或发出尖锐声时，需要对四轮进行重新检测、调整定位，确保车辆始终处于良好的行驶状态，以减少对轮胎、悬挂系统零件的非正常磨损。\n保养周期:一般车辆每20000公里一次",
                 @"随着车辆的使用，积碳也逐渐的增多，会导致发动机性能变差:怠速抖动、加速不良、油耗增加、尾气超标等不良现象。如果喷油嘴和节气门长时间不清洗，不仅油耗会增加，同时车辆在加速和收油时会出现明显顿挫感，会降低车辆的舒适性。\n保养周期:一般车辆每20000公里保养一次",
                 @"由于原油成分、炼油工艺以及储存原因，造成在汽油辛烷比例高、硫等杂质多。当这种汽油在发动机内部燃烧时，容易形成坚硬的积碳，沉积在节气门、喷油嘴、进气阀和燃烧室等部位。导致发动机的运行不稳定，如启动困难、怠速不稳、行车无力、油耗上升等现象，并容易损坏氧传感器、三元催化，导致发动机烧机油，缩短火花塞等零件的使用寿命。因此应定期对油路进行清洁。\n保养周期:一般车辆每50000公里保养一次",
                 @"进气道的清洁非常重要，如进气道阻塞导致空气供应不足，会影响发动机的工作效率，燃油燃烧不充分，动力下降，发动机寿命缩短。如车辆出现着车后怠速不稳、加速不畅、油耗偏高的现象，应检查进气道的清洁程度。\n保养周期:一般车辆每20000公里保养一次",
                 @"车辆年检，就是指每个车辆都必须要的一项检测，相当于给车辆做体检，及时消除车辆安全隐患，减少交通事故的发生也就是我们平时所说的验车。",
                 @"  ",
                 @" ",
                 @"  ",
                 @" ",
                 @" ",
                 @" ",nil];
    serverAddr=@"http://www.qcygl.com/";
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    //.
    numberFormater=[NSNumberFormatter new];
    [numberFormater setUsesGroupingSeparator:YES];
    [numberFormater setGroupingSize:3];
    [numberFormater setGroupingSeparator:@","];
    
}

-(TracingCarViewController *)getTracingCarViewController
{
    return [self tracingCarViewController];
}

-(void) saveCurrentCarInfo
{
    NSLog(@"saveCurrentCarInfo is called carid=%d",(int)currentCar.car_id);
 //   [defaults setValue:[NSString stringWithFormat:@"%ld",currentCar.car_id] forKey:@"currrentCarId"];
    [defaults setInteger:currentCar.car_id forKey:@"currrentCarId"];
    [defaults synchronize];
    /*
    NSMutableData *data=[[NSMutableData alloc] init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeInt:currentCar.car_id forKey:kCarIdKey];
  //  NSData *tData=[ownerTel dataUsingEncoding:NSUTF8StringEncoding];
    [archiver finishEncoding];
    [data writeToFile:[self archiveFilePath] atomically:YES];
    */
}

-(void)updateCurrentCarInfo
{
    //INIT_MILES,TOTAL_OILVOLUME,TOTAL_OILCOST    
    NSString *sql=[NSString stringWithFormat: @"update CARS_TABLE set CURRENT_MILES=%d,INIT_MILES=%d,TOTAL_OILVOLUME=%f,TOTAL_OILCOST=%f,FUELING_INFO='%@' where CAR_ID=%d",(int)currentCar.currentMiles,(int)currentCar.initMiles,currentCar.totalOilConsumption,currentCar.totalOilCost,currentCar.fuelingInfo,(int)currentCar.car_id];
 //   sqlite3_stmt *statement;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error in updating CURRENT_MILES of CAR_TABLE");
        sqlite3_close(database);        
    }
   
    NSLog(@"updateCurrentCarInfo is worked! miles:%d,car_id %d",(int)currentCar.currentMiles,(int)currentCar.car_id);
    if (!getDataFromCloud && ![self.ownerTel isEqualToString:@"none"]) {
        [self updateCloudInfoWithCar:currentCar];
    }
    
    
}

-(void) updateCarInfo:(Car *)aCar
{
    NSString *sql=[NSString stringWithFormat: @"update CARS_TABLE set LICENSE='%@' , INSPECT_DATE='%@' ,INSPECT_INTERVAL=%d, INSURANCE_DATE='%@', INSURANCE_INTERVAL=%d where CAR_ID=%d",aCar.license,aCar.inspectDay,(int)aCar.inspectInterval,aCar.insuranceDay,(int)aCar.insuranceInterval,(int)aCar.car_id];
    //   sqlite3_stmt *statement;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error in updating CARINFO of CAR_TABLE");
        sqlite3_close(database);
    }
    
    if (!getDataFromCloud && ![self.ownerTel isEqualToString:@"none"]) {
        [self updateCloudInfoWithCar:currentCar];
    }
}

-(void) reSetCurrentCarWithCar:(Car *)aCar
{
    currentCar=aCar;
    [self.tracingCarViewController refreshView];
    
}

-(void)updateMaintainInfo
{
    NSString *sql=[NSString stringWithFormat: @"update CARS_TABLE set MAINTAIN_INFO=%@ where CAR_ID=%d",currentCarMaintainInfo,(int)currentCarId];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
    {
        NSLog(@"error in updating MAINTAIN_INFO of CAR_TABLE");
        sqlite3_close(database);
    }}

-(void)selectCurrentCarInfo
{
    /*
     @"CREATE TABLE IF NOT EXISTS  CARS_TABLE (CAR_ID INTEGER PRIMARY KEY , CURRENT_MILES INTEGER , LICENSE TEXT)";    */
    NSString *sql=[NSString stringWithFormat:@"select CURRENT_MILES,LICENSE from CARS_TABLE where CAR_ID=%d ",(int)currentCarId];
    NSLog(@"selectCurrentCarInfo is worked sql=%@",sql);
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            currentCar.currentMiles=sqlite3_column_int(statement, 0);
            char* tLicense=(char*)sqlite3_column_text(statement, 1);
            if(tLicense==NULL) break;
            currentCar.license=[[NSString alloc] initWithUTF8String:tLicense];
        }
    }
}
-(void) selectMaintainTableWithCarId:(NSInteger)Carid ToBuffer:(NSMutableArray *)buffer
{
    
    [buffer removeAllObjects];
    NSString *sql=[NSString stringWithFormat: @"select ITEM_ID,ITEM_NAME,LIFE_MILES,LATEST_MAINTAIN_MILES,LEFT_PERCENT,LEFT_MILES,LIFE_TIME,LATEST_MAINTAIN_TIME,TIME_LEFT_PERCENT,APPLY_MARK from MAINTAIN_ITEMS_TABLE where CAR_ID=%d  ORDER BY APPLY_MARK DESC,LEFT_MILES ASC,ITEM_ID ASC",(int)Carid];
    sqlite3_stmt *statement;
    MaintainItem *item;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        NSInteger itemId,lifeMiles,latestMtMiles,leftPercent,leftMiles,lifeTime,apply_mark;
        char *str;        
        NSString *itemName,*latestTime;        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            itemId=sqlite3_column_int(statement, 0);
            str=(char*)sqlite3_column_text(statement, 1);
            if(str==NULL) break;
            itemName=[[NSString alloc] initWithUTF8String:str];
           
            lifeMiles=sqlite3_column_int(statement, 2);
            latestMtMiles=sqlite3_column_int(statement, 3);
            leftPercent=sqlite3_column_int(statement, 4);
            leftMiles=sqlite3_column_int(statement, 5);
            apply_mark=sqlite3_column_int(statement, 9);
            item=[[MaintainItem alloc] initWithCarId:Carid ItemId:itemId itemName:itemName lifeMiles:lifeMiles latestMaintinMiles:latestMtMiles leftPercent:leftPercent leftMiles:leftMiles  APPLYMARK:apply_mark];
            lifeTime=sqlite3_column_int(statement, 6);
            str=(char*)sqlite3_column_text(statement, 7);
            latestTime=[[NSString alloc] initWithUTF8String:str];
            [item computePastTimeWithLastMaintainTime:latestTime LifeTime:lifeTime];
         
            [buffer addObject:item];
        }
    }else{
        NSLog(@"selectMaintainTableWithCarId error! sql=%@",sql);
    }
}

-(void)selectMaintainRecordsWithItemId:(NSInteger)iId toBuffer:(NSMutableArray *)recordsBuffer
{
    NSString *sql;
    if(iId<0)
        sql=[[NSString alloc] initWithFormat:@"select ITEM_ID , ITEM_NAME ,MAINTAIN_MILES , MAINTAIN_COST ,MAINTAIN_DATE from MAINTAIN_RECORD_TABLE where CAR_ID=%d ",(int)currentCar.car_id];
    else 
        sql=[[NSString alloc] initWithFormat:@"select ITEM_ID , ITEM_NAME ,MAINTAIN_MILES , MAINTAIN_COST ,MAINTAIN_DATE from MAINTAIN_RECORD_TABLE where CAR_ID=%d and ITEM_ID=%d ",(int)currentCar.car_id,(int)iId];
    sqlite3_stmt *statement;
    MaintainRecord *record;
    NSInteger itemId,miles;
    char *str;
    NSString *itemName,*date;
    CGFloat artiCost;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
        while ((sqlite3_step(statement)==SQLITE_ROW)) {
            itemId=sqlite3_column_int(statement,0);
            str=(char*)sqlite3_column_text(statement, 1);
            itemName=[[NSString alloc] initWithUTF8String:str];
            miles=sqlite3_column_int(statement, 2);
            artiCost=sqlite3_column_double(statement, 3);
            str=(char*)sqlite3_column_text(statement, 4);
            date=[[NSString alloc] initWithUTF8String:str];
            record=[[MaintainRecord alloc] initWithCarCode:currentCar.car_id Item_id:itemId itemName:itemName MaintainMiles:miles Cost:artiCost Date:date];
            [recordsBuffer addObject:record];
        }
    }
}

-(void)selectMaintainAllRecordsToBuffer:(NSMutableArray *)recordsBuffer
{
    //ITEM_ID INTEGER , CAR_ID INTEGER , ITEM_NAME TEXT,MAINTAIN_MILES INTEGER, MAINTAIN_COST FLOAT,MAINTAIN_DATE TEXT
    NSString *sql=[[NSString alloc] initWithFormat:@"select ITEM_ID , ITEM_NAME ,MAINTAIN_MILES , MAINTAIN_COST ,MAINTAIN_DATE from MAINTAIN_RECORD_TABLE where CAR_ID=%d ",(int)currentCar.car_id];
    sqlite3_stmt *statement;
    MaintainRecord *record;
    NSInteger itemId,miles;
    char *str;
    NSString *itemName,*date;
    CGFloat artiCost;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
        while ((sqlite3_step(statement)==SQLITE_ROW)) {
            itemId=sqlite3_column_int(statement,0);
            str=(char*)sqlite3_column_text(statement, 1);
            itemName=[[NSString alloc] initWithUTF8String:str];
            miles=sqlite3_column_int(statement, 2);
            artiCost=sqlite3_column_double(statement, 3);
            str=(char*)sqlite3_column_text(statement, 4);
            date=[[NSString alloc] initWithUTF8String:str];
            record=[[MaintainRecord alloc] initWithCarCode:currentCar.car_id Item_id:itemId itemName:itemName MaintainMiles:miles Cost:artiCost Date:date];
            [recordsBuffer addObject:record];
        }
    }
  //  NSLog(@"selectMaintainAllRecordsToBuffer count:%ld",[recordsBuffer count]);
}

-(void)updateMaintainItemInfoOfCar:(Car *)aCar WithBuffer:(NSMutableArray *)buffer
{
    NSString *sql;
    MaintainItem *item;
  //  sqlite3_stmt *statement;
    for (int i=0; i<[buffer count]; i++) {
        item=[buffer objectAtIndex:i];
        if (item.applyMark==0) {
            continue;
        }
        sql=[NSString stringWithFormat:@"update MAINTAIN_ITEMS_TABLE set LIFE_MILES=%d ,LIFE_TIME=%d, LATEST_MAINTAIN_MILES=%d,LEFT_MILES=%d,LATEST_MAINTAIN_TIME='%@' , LEFT_PERCENT=%d,TIME_LEFT_PERCENT=%d where ITEM_ID=%d and CAR_ID=%d",(int)item.lifeMiles,(int)item.lifeTime,(int)item.latestMaintainMiles,(int)item.leftMiles,item.latestMaintainDate,(int)item.leftPercent,(int)item.timeLeftPercent ,(int)item.itemId,(int)aCar.car_id];
       
        if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
        {
            NSLog(@"error in update MAINTAIN_ITEMS_TABLE");
            sqlite3_close(database);            
        }
        if (item.lifeTime>0) {
      //      NSLog(@"updateMaintainItemInfo withlifetime name:%@ lifetime=%ld",item.itemName,item.lifeTime);
        }
        
    }
  //  NSLog(@"updateMaintainInfo is worked. carId=%ld",aCar.car_id);
    if (!getDataFromCloud && ![self.ownerTel isEqualToString:@"none"]) {
        [self updateMaintainCloudInfoWithBuffer:buffer Car:aCar];
    }
}

-(void) updateSignalMaintainItemWithMaintianItem:(MaintainItem *)item
{
    NSString *sql=[NSString stringWithFormat:@"update MAINTAIN_ITEMS_TABLE set LIFE_MILES=%d , LATEST_MAINTAIN_MILES=%d , LEFT_PERCENT=%d,LEFT_MILES=%d, LIFE_TIME=%d , LATEST_MAINTAIN_TIME='%@' ,APPLY_MARK=%d where ITEM_ID=%d and CAR_ID=%d",(int)item.lifeMiles,(int)item.latestMaintainMiles,(int)item.leftPercent,(int)item.leftMiles,(int)item.lifeTime,item.latestMaintainDate ,(int)item.applyMark,(int)item.itemId,(int)item.carId];
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error in update signal MAINTAIN_ITEMS_TABLE");
        sqlite3_close(database);            
    } 
    NSLog(@"updateSignalMaintainItemWithMaintianItem is worked sql=%@",
          sql);
    
}

-(void) selectRespairItems
{
    [respairItems removeAllObjects];
    NSString *sql=[[NSString alloc] initWithFormat:@"select NAMES ,COST , DATE,MILES  FROM RESPAIR_TABLE WHERE CAR_ID=%d ORDER BY DATE DESC ",(int)currentCar.car_id];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement,NULL)==SQLITE_OK)
    {
        CGFloat cost;
        char *str;
        NSString *date,*names;
        RespairItem *item;
        NSInteger miles;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            str=(char*)sqlite3_column_text(statement, 0);
            names=[[NSString alloc] initWithUTF8String:str];
            NSLog(@"select repair table itemnames:%@",names);
            
            cost=sqlite3_column_double(statement, 1);
            str=(char*)sqlite3_column_text(statement, 2);
            date=[[NSString alloc] initWithUTF8String:str];
            miles=sqlite3_column_int(statement, 3);
            item=[[RespairItem alloc] initWithNames:names Miles:miles Cost:cost Date:date];
            [item analyzeSubItems];
            [respairItems addObject:item];
        }
    }else
    {
        NSLog(@"error in seclect respair table.");
    }
 //   NSLog(@"selectRespairItems is worked. carId=%ld,count:%ld",currentCar.car_id,[respairItems count]);
}


-(void) selectFuelingItems
{
    [fuelingItems removeAllObjects];
    NSString *sql=[[NSString alloc] initWithFormat:@"select OIL_VOLUME ,OIL_COST,LAST_LEFT_VOLUME , CURRENT_MILES , DATE,AV_OIL,AV_COST,ADD_MILES  FROM FUELING_TABLE WHERE CAR_ID=%d    ORDER BY CURRENT_MILES DESC ",(int)currentCar.car_id];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement,NULL)==SQLITE_OK)
    {
        CGFloat volume,cost,leftVol;
        NSInteger miles;
        char *tDate;
        NSString *date;
        FuelingItem *item;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            volume=sqlite3_column_double(statement, 0);
            cost=sqlite3_column_double(statement, 1);
            leftVol=sqlite3_column_double(statement, 2);
            miles=sqlite3_column_int(statement, 3);
            tDate=(char*)sqlite3_column_text(statement, 4);
            date=[[NSString alloc] initWithUTF8String:tDate];
            item=[[FuelingItem alloc] initWithCurrentMiles:miles LeftVol:leftVol Volume:volume Cost:cost Date:date];
            volume=sqlite3_column_double(statement, 5);
            item.avOil=volume;
            cost=sqlite3_column_double(statement, 6);
            item.avCost=cost;
            miles=sqlite3_column_int(statement, 7);
            item.addMiles=miles;
            [fuelingItems addObject:item];
            
        }
    } else
    {
        NSLog(@"error select fueling table");
    }
 //   NSLog(@"selectFuelingItems is worked. carId=%d,count:%d",(int)currentCar.car_id,(int)[fuelingItems count]);
    
}

-(void)selectAllFuelingItems
{
  //  [fuelingItems removeAllObjects];
    NSString *sql=[[NSString alloc] initWithFormat:@"select OIL_VOLUME ,OIL_COST,LAST_LEFT_VOLUME , CURRENT_MILES , DATE,AV_OIL,AV_COST,ADD_MILES  FROM FUELING_TABLE   ORDER BY CURRENT_MILES DESC "];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement,NULL)==SQLITE_OK)
    {
        CGFloat volume,cost,leftVol;
        NSInteger miles;
        char *tDate;
        NSString *date;
        FuelingItem *item;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            volume=sqlite3_column_double(statement, 0);
            cost=sqlite3_column_double(statement, 1);
            leftVol=sqlite3_column_double(statement, 2);
            miles=sqlite3_column_int(statement, 3);
            tDate=(char*)sqlite3_column_text(statement, 4);
            if (tDate!=NULL) {
                date=[[NSString alloc] initWithUTF8String:tDate];
            }else date=@"";
            
            item=[[FuelingItem alloc] initWithCurrentMiles:miles LeftVol:leftVol Volume:volume Cost:cost Date:date];
            volume=sqlite3_column_double(statement, 5);
            item.avOil=volume;
            cost=sqlite3_column_double(statement, 6);
            item.avCost=cost;
            miles=sqlite3_column_int(statement, 7);
            item.addMiles=miles;
      //      [fuelingItems addObject:item];
       //     NSLog(@"all fueling items miles:%ld",miles);
            
        }
    } else
    {
        NSLog(@"error select fueling table");
    }
    
}

-(NSInteger)getNewCarId
{
    NSString *sql=@"SELECT MAX(CAR_ID) FROM CARS_TABLE";
    sqlite3_stmt *statement;
    NSInteger tCarId=1;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
        while (sqlite3_step(statement)==SQLITE_ROW) {
            tCarId=sqlite3_column_int(statement, 0);
        }
        tCarId++;
    };    
    return tCarId;
}

-(void)insertNewCar:(Car *)car
{
    
    NSString *insertSql=[[NSString alloc] initWithFormat:@"INSERT INTO CARS_TABLE(CAR_ID, LICENSE, BRAND_NAME ,BRAND_MODEL, CURRENT_MILES , INIT_MILES , TOTAL_OILVOLUME ,OILBOX_VOLUME, MAINTAIN_INFO,FUELING_INFO,RESPAIR_INFO,INSPECT_DATE,INSPECT_INTERVAL,INSURANCE_DATE,INSURANCE_INTERVAL , FLAG ) VALUES(%d,'%@','%@','%@',%ld,%ld,%f,%f,'%@','%@','%@','%@',%d,'%@',%d,%d);",(int)car.car_id,car.license,car.brandName,car.brandModel,(long)car.currentMiles,(long)car.initMiles,car.totalOilConsumption,car.oilBoxVolume,car.maintainInfo,car.fuelingInfo,car.respairInfo,car.inspectDay,(int)car.inspectInterval,car.insuranceDay,(int)car.insuranceInterval,(int)car.flag];
    //  sqlite3_stmt *statement;
    char *errMsg;
    if(sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, &errMsg)!=SQLITE_OK)
    {
        NSLog(@"error insert new car record! errMsg:%@",[[NSString alloc] initWithCString:errMsg encoding:NSASCIIStringEncoding ]);
     //   NSAssert1(0, @"err insert new car %s", errMsg);
   //     sqlite3_free(errMsg);
        sqlite3_close(database);
        return;
    }    
    [cars addObject:car];
    
    if (!getDataFromCloud && ![self.ownerTel isEqualToString:@"none"]) {
        [self updateCloudInfoWithCar:car];
    }
    
}

-(void)insertMaintainItem:(MaintainItem *)mItem
{
    if (mItem.itemId<0) {
        [personalCenterViewController.carManageViewController addNewMaintainItem:mItem];
    }
    
    //  createSQL=@"CREATE TABLE IF NOT EXISTS  MAINTAIN_ITEMS_TABLE (ITEM_ID INTEGER , CAR_ID INTEGER , ITEM_NAME TEXT, LIFE_MILES INTEGER,LIFE_TIME INTEGER, LATEST_MAINTAIN_MILES INTEGER, LATEST_MAINTAIN_TIME TEXT, LEFT_PERCENT INTEGER, TIME_LEFT_PERCENT INTEGER, LEFT_MILES INTEGER , LEFT_DAYS INTEGER ,APPLY_MARK INTEGER,TAG INTEGER, PRIMARY KEY(ITEM_ID,CAR_ID))";
    
    
    NSString *insertSql=[[NSString alloc] initWithFormat:@"INSERT INTO MAINTAIN_ITEMS_TABLE(ITEM_ID , CAR_ID , ITEM_NAME , LIFE_MILES , LATEST_MAINTAIN_MILES , LEFT_PERCENT,LEFT_MILES, LIFE_TIME, LATEST_MAINTAIN_TIME , TIME_LEFT_PERCENT, APPLY_MARK ) VALUES(%d,%d,'%@',%d,%d,%d,%d,%d,'%@',%d,%d)",  (int)mItem.itemId,(int)mItem.carId,mItem.itemName,(int)mItem.lifeMiles,(int)mItem.latestMaintainMiles,(int)mItem.leftPercent,(int)mItem.leftMiles,(int)mItem.lifeTime,mItem.latestMaintainDate,(int)mItem.timeLeftPercent,(int)mItem.applyMark];
    //  sqlite3_stmt *statement;
    NSLog(@"insertMaintainItem  %@",insertSql);
    char *errMsg;
    if(sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, &errMsg)!=SQLITE_OK)
    {
        NSLog(@"error insert maintain Item! name:%@, errMsg:%@",mItem.itemName,[[NSString alloc] initWithCString:errMsg encoding:NSASCIIStringEncoding ]);
        sqlite3_close(database);
    }    
    
  //  NSLog(@"insertMaintainItem is worked. sql=%@",insertSql);
}

-(void)insertmaintainRecord:(MaintainRecord *)record
{
    
    NSString *sql=[[NSString alloc] initWithFormat:@"INSERT INTO  MAINTAIN_RECORD_TABLE(ITEM_ID , CAR_ID , ITEM_NAME ,MAINTAIN_MILES , MAINTAIN_COST ,MAINTAIN_DATE ) VALUES(%d,%d,'%@',%d,%f,'%@')",(int)record.item_id,(int)record.car_code,record.itemname,(int)record.maintainMiles,record.cost1,record.date];
    if(sqlite3_exec(database, [sql UTF8String] , NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error insert maintain record");
        sqlite3_close(database);
    }
  //  NSLog(@"insertmaintainRecord id:%ld name:%@ cost:%f date:%@",record.item_id,record.itemname,record.cost1,record.date);
}

-(void)insertRespairRecord:(RespairItem *)rItem
{                                                              //      RESPAIR_TABLE
    NSString *insertSql=[[NSString alloc] initWithFormat:@"INSERT INTO RESPAIR_TABLE(CAR_ID ,NAMES,MILES ,COST, DATE ) VALUES(%d,'%@',%d,%f,'%@');",
                         (int)rItem.carId,rItem.names,(int)rItem.miles,rItem.cost,rItem.date];
  //  sqlite3_stmt *statement;
    /*
    if(sqlite3_prepare_v2(database, [insertSql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
    {
        NSLog(@"error insert respair record!");
        sqlite3_close(database);
    }*/
    if(sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error insert respair record!");
        sqlite3_close(database);
    }    
    
   //  NSLog(@"insertRespairRecord is worked. carId=%d",(int)currentCar.car_id);
}


-(void) insertFuelingRecord:(FuelingItem *)fItem
{
    //OIL_VOLUME ,OIL_COST,LAST_LEFT_VOLUME , CURRENT_MILES , DATE,AV_OIL,AV_COST,ADD_MILES
    
    NSString *insertSql=[[NSString alloc] initWithFormat:@"INSERT INTO FUELING_TABLE(CAR_ID ,OIL_VOLUME ,OIL_COST,LAST_LEFT_VOLUME , CURRENT_MILES , DATE,AV_OIL,AV_COST,ADD_MILES ) VALUES(%d,%f,%f,%f,%d,'%@',%f,%f,%d)",
                         (int)fItem.carId,fItem.volume,fItem.cost,fItem.leftVol,(int)fItem.miles,fItem.date,fItem.avOil,fItem.avCost,(int)fItem.addMiles];
   // sqlite3_stmt *statement;
    if(sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error insert fueling record!");
        sqlite3_close(database);
    }
    /*
    if(sqlite3_prepare_v2(database, [insertSql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
       {
           NSLog(@"error insert fueling record!");
           sqlite3_close(database);
       }
    */
  //   NSLog(@"insertFuelingRecord is worked. carId=%ld",currentCar.car_id);
    
    
}

-(void) updateFuelingRecord:(FuelingItem *)fItem
{
    NSString *insertSql=[[NSString alloc] initWithFormat:@"UPDATE FUELING_TABLE SET AV_OIL=%f,AV_COST=%f,ADD_MILES=%d where CAR_ID=%d and  CURRENT_MILES=%ld",
                         fItem.avOil,fItem.avCost,(int)fItem.addMiles,(int)currentCar.car_id,(long)fItem.miles];
    // sqlite3_stmt *statement;
    if(sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error upate fueling record!");
        sqlite3_close(database);
    }
    NSLog(@"updateFuelingRecord is worked. carId=%d",(int)currentCar.car_id);

}

-(BOOL) checkFuelingMiles:(NSInteger)miles
{
    NSString *sql=[[NSString alloc] initWithFormat:@"select  CURRENT_MILES   FROM FUELING_TABLE  WHERE  CURRENT_MILES=%ld ",(long)miles];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement,NULL)==SQLITE_OK)
    {
       
        while (sqlite3_step(statement)==SQLITE_ROW) {
            return FALSE;
        }
        return TRUE;
    } else{
        return FALSE;
    }
    
}

-(void) loadMaintainItemInitView:(BOOL)flag ItemIndex:(NSInteger)index
{
    NSLog(@"loadMaintainItemInitView flag:%d, index:%d",flag,(int)index);
    [maintainItemInitViewController setNewItemIndex:index];
    [autoNavigationController.view setHidden:NO];
    [self.autoNavigationController pushViewController:maintainItemInitViewController animated:YES];
    /*
    if (!flag) {
        NSLog(@"navigationController pop!");
        
        
    }else{
      //  [maintainItemInitViewController setNewItemIndex:index];
        [self.leftNavigationController pushViewController:maintainItemInitViewController animated:YES];
    }
    */
    
}

-(void) loadFunctionViewController:(UIViewController *)viewController
{
    [autoNavigationController.view setHidden:NO];
    [autoNavigationController pushViewController:viewController animated:YES];
}

-(void) removeFunctionViewController:(UIViewController *)viewController
{
    [autoNavigationController.view setHidden:YES];
  //  [viewController removeFromParentViewController];
  //  [autoNavigationController popViewControllerAnimated:<#(BOOL)#>];
  //  [self.autoNavigationController popToRootViewControllerAnimated:YES];
}


-(IBAction)finishMaintainItemInitialization:(id)sender
{
    
}

-(BOOL)showMaintainItemInitView
{
    /*
    if (maintainItemInitView.center.x>0) {
        return TRUE;
    } else return FALSE;
    */
    return  [maintainItemInitViewController isFirstResponder];
   // return [maintainItemInitViewController isViewLoaded];
}

-(BOOL)showCarsTableView
{
    NSLog(@"showCarsTableView %d",(int)carsTableView.view.tag);
    if (carsTableView.view.tag==1) {
        return YES;
    }else return NO;
}

-(IBAction)returnMaintainItemInitView:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        maintainItemInitView.center=CGPointMake(maintainItemInitView.center.x-self.screenWidth, maintainItemInitView.center.y);
    }];
    [self.tracingCarViewController setCanMoveAway:true];
}

-(void) loadCarsTableView
{
    if (carsTableView.view.tag==0) {
        [self.window addSubview:carsTableView.view];
        carsTableView.view.tag=1;
        [carsTableView refreshCarsTableView];
        [carsTableView.table reloadData];
    }
    
}

-(void)takeAwayCarsTableView
{
    if (carsTableView.view.tag==1) {
        [carsTableView.view removeFromSuperview];
        carsTableView.view.tag=0;
    }
    
}



-(void) showWelcomeView
{
    UIScrollView *_scrollView=[[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*4,[UIScreen mainScreen].bounds.size.height );
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.delegate=self;
    _scrollView.tag=101;
    for (int i=0; i<4; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        UIImage *image=[UIImage imageNamed:[[NSString alloc] initWithFormat:@"welcomeview%d",(i+1)]];
        imageView.image=image;
        [_scrollView addSubview:imageView];
    }
    //
    UIPageControl *pageControll=[[UIPageControl alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50)/2, [UIScreen mainScreen].bounds.size.height-60, 50, 40)];
    pageControll.numberOfPages=4;
    pageControll.tag=201;
    [self.window addSubview:_scrollView];
    [self.window addSubview:pageControll];
    
    
}

-(void) removeWelcomeView
{
    UIScrollView *scrollView=(UIScrollView*)[self.window viewWithTag:101];
    UIPageControl *pageControll=(UIPageControl*)[self.window viewWithTag:201];
    [UIView animateWithDuration:3.0f animations:^{
        scrollView.center=CGPointMake(self.window.frame.size.width/2, 1.5*self.window.frame.size.height);
    }completion:^(BOOL finished){
        [scrollView removeFromSuperview];
        [pageControll removeFromSuperview];
    }];
    
    [ defaults setValue:@"YES" forKey:@"isFirstLoad"];
    
}

-(void) lazyLoadOperations
{
    activityIndicatorView=[[UIActivityIndicatorView alloc] init];
    [activityIndicatorView setFrame:CGRectMake(screenWidth/2-20, screenHeight/2-20, 40, 40)];
    [self.window addSubview:activityIndicatorView];
  //  [activityIndicatorView setHidden:YES];
  //  [activityIndicatorView setHidesWhenStopped:YES];
}

-(void)showActivityViewIndicator
{
  //  [activityIndicatorView setHidden:NO];
    [activityIndicatorView startAnimating];
}

-(void) hideActivityViewIndicator
{
    NSLog(@"hideActivityViewIndicator");
    [activityIndicatorView stopAnimating];
  //   [activityIndicatorView setHidden:YES];
}
                

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self legalNumberFormatter];
    [self initDataBase];
    [self initBrandDictionary];
      
    [self initGlobalData];
    
    //get screen size.
    CGRect rect=[[UIScreen mainScreen] bounds];
    screenWidth=rect.size.width;
    screenHeight=rect.size.height;
    
  //  oilPrice=5.21;
    self.tracingCarViewController = [[TracingCarViewController alloc] initWithNibName:@"TracingCarViewController" bundle:nil] ;
    createNewCarViewController=[[CreateNewCarViewController alloc] initWithNibName:@"CreateNewCarViewController" bundle:nil];
    maintainItemInitViewController=[[MaintainItemInitViewController alloc] initWithNibName:@"MaintainItemInitViewController" bundle:nil];
    self.loginViewController=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.personalCenterViewController=[[PersonalCenterViewController alloc] initWithNibName:@"PersonalCenterViewController" bundle:nil];
    tracingCarViewController.title=@"主页";
    navigationController=[[UINavigationController alloc] init];
    leftNavigationController=[[UINavigationController alloc] init];
    autoNavigationController=[[UINavigationController alloc] init];
    
    navigationController.navigationBar.backgroundColor=[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f];
    [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1) {
        
        
        navigationController.navigationBar.tintColor=[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f];
        leftNavigationController.navigationBar.tintColor=[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f];
        
    } else{
        navigationController.navigationBar.barTintColor =[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f];
        leftNavigationController.navigationBar.barTintColor=[UIColor colorWithRed:33/255.0f green:45/255.0f blue:54/255.0f alpha:1.0f];
        
        
    }
    
   [navigationController pushViewController:tracingCarViewController animated:NO];
    [leftNavigationController pushViewController:personalCenterViewController animated:NO];
    
  //  [self.window addSubview:tracingCarViewController.view];
    [self.window addSubview:navigationController.view];
    [self.window insertSubview:leftNavigationController.view belowSubview:navigationController.view];
    [self.window addSubview:autoNavigationController.view];
    [autoNavigationController.view setHidden:YES];
   
    self.window.backgroundColor = [UIColor whiteColor];
    
    //concerned share views
    notificationInfo=[[NotificationLabel alloc] initWithFrame:CGRectMake(0, screenHeight-100, 100, 40)];
    [notificationInfo setRootView:self.window];
    spinnerView=[[SpinnerViewController alloc] init];
    movingInfo=[[MovingInformation alloc] init];
    [self initMyQuartzView];
    
    //maintian item init set view
    NSArray *nibView=[[NSBundle mainBundle] loadNibNamed:@"maintainItemSetView" owner:self options:nil];
    maintainItemInitView=[nibView objectAtIndex:0];
    
    //common date inputview
    NSMutableArray *tbItems=[NSMutableArray array];
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishMaintainDateSet)];
    [tbItems addObject:barButtonItem];
    [accessoryView setItems:[[NSArray alloc] initWithObjects:barButtonItem, nil]];

    
    defaults=[NSUserDefaults standardUserDefaults];
    
    ownerTel=[defaults stringForKey:@"owner"];
    memberType=[defaults integerForKey:@"memberType"];
    currentCarId=[defaults integerForKey:@"currrentCarId"];
    currentOilPrice=[defaults floatForKey:@"currentOilPrice"];
    if (currentOilPrice==0) {
        currentOilPrice=6.75;
    }
    
     [self getAllCars];
    
    NSLog(@"+++owner=%@,  memberType=%d, car count:%d, currentCarId=%d",ownerTel,(int)memberType,(int)[cars count],(int)currentCarId);
    
    /*
    if(ownerTel==nil ||[ownerTel isEqualToString:@""])
    {
        ownerTel=@"none";
        [navigationController pushViewController:loginViewController animated:NO];        
        
    } */
    
    //carsTable.
    carsTableView=[[CarsTableView alloc] initWithPlot:0 AppDelegate:self];
    
    //微信注册    wx7acf62724b9dcb00        wxbe41ebca760466e
    [WXApi registerApp:@"wx7acf62724b9dcb00"];
    
    getDataFromCloud=FALSE;
    
    [self getRelatedGarages];
    
    NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(lazyLoadOperations) object:nil];
   
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
    [self.window makeKeyAndVisible];
    
    //init JPUSHService.
    [self initJPUSHService];
  //  [self getRunTimeOilPrice];
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)onReq:(BaseReq *)req
{
    NSLog(@"onReq");
}

-(void)onResp:(BaseResp *)resp
{
    NSLog(@"onResp");
}

-(void)sendTextToWeiXin:(NSString *)msg
{
    //https://itunes.apple.com/cn/app/qi-che-yun-guan-li/id1006122455?l=en&mt=8
    
    WXMediaMessage *message=[WXMediaMessage message];
    message.title=@"保养提醒，油耗统计，维修记录。";
    message.description=@"汽车云管理";
    [message setThumbImage:[UIImage imageNamed:@"icon.png"]];
    WXWebpageObject *webpageObject=[WXWebpageObject object];
    webpageObject.webpageUrl=@"https://itunes.apple.com/cn/app/qi-che-yun-guan-li/id1006122455?l=en&mt=8";
    message.mediaObject=webpageObject;
    
    
    
    SendMessageToWXReq *req=[[SendMessageToWXReq alloc] init];
  //  req.text=msg;
    req.bText=NO;
    req.message=message;
   
    req.scene=WXSceneTimeline;
    [WXApi sendReq:req];
    
}


-(void) unlogin
{
    [defaults setObject:@"" forKey:@"owner"];
    [defaults synchronize];
    self.ownerTel=@"none";
    [self clearDataBase];
}

-(void) loginWithTel:(NSString *)tel Type:(NSInteger)type Garage:(Garage*) ga
{
  //  NSLog(@"login with owner:%@",tel);
    [defaults setObject:tel forKey:@"owner"];
    ownerTel=[NSString stringWithFormat:@"%@",tel];
    [defaults setInteger:type forKey:@"memberType"];
    memberType=type;
    NSDate *sendDate=[NSDate date];
    NSString *date=[dateFormatter stringFromDate:sendDate];    
    
    [defaults setObject:date forKey:@"loginDate"];
    [defaults synchronize];
    /*
    [defaults setObject:garage.name forKey:@"garageName"];
    [defaults setObject:garage.tel forKey:@"garageTel"];
    [defaults setObject:garage.addr forKey:@"garageAddr"];
     */
    
}

-(void) initMyQuartzView
{
    // 创建掩模视图，其尺寸与所要裁减的视图的尺寸一样
   //. _myQuartzView = [[MyQuartzView alloc] init];
    
    //init scanLine.
    scanLine=[[UIImageView alloc] initWithFrame:CGRectMake(44, 90, screenWidth - 2 * 40-4, 10)];
    [scanLine setImage:[UIImage imageNamed:@"scan_line.png"]];
    
    //init animation.
    slowDownAnimation  = [CABasicAnimation animationWithKeyPath:@"position"];
    slowDownAnimation.fromValue =  [NSValue valueWithCGPoint: scanLine.layer.position];
    CGPoint toPoint = scanLine.layer.position;
    toPoint.y += (screenWidth-100);
    slowDownAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    [slowDownAnimation setDuration:2.0f];
    [slowDownAnimation setRepeatCount:HUGE_VALF];
    [slowDownAnimation setAutoreverses:YES];
 //   [scanLine.layer addAnimation:slowDownAnimation forKey:@"flow_down"];
    
  //  [self.window addSubview:_myQuartzView];
  //  [_myQuartzView startScan];
  //  [self startScanQRCode];
    //other
    _scanBackBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 20, 20, 20)];
   // [_scanBackBtn.titleLabel setText:@"返回"];
   // [_scanBackBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_scanBackBtn setBackgroundImage:[self image:[UIImage  imageNamed:@"slidedown.png"] rotation:UIImageOrientationRight] forState:UIControlStateNormal];
     [_scanBackBtn setBackgroundImage:[self image:[UIImage  imageNamed:@"slidedown.png"] rotation:UIImageOrientationRight] forState:UIControlStateHighlighted];
    [_scanBackBtn addTarget:self action:@selector(stopScan) forControlEvents:UIControlEventTouchUpInside];
    
    _scanTitle=[[UILabel alloc] initWithFrame:CGRectMake((screenWidth-128)/2, 16, 128, 32)];
    [_scanTitle setTextColor:[UIColor whiteColor]];
    [_scanTitle setText:@"扫描汽修编码"];
    
 //.   [_myQuartzView addSubview:_scanTitle];
  //.  [_myQuartzView addSubview:_scanBackBtn];
    
}

-(void)setMyScanOperationFlag:(NSInteger)flag
{
    _scanOperationFlag=flag;
}

-(void) loadConcernScanViews
{
    [self.window addSubview:_myQuartzView];
    [self.window addSubview:scanLine];
    [scanLine.layer addAnimation:slowDownAnimation forKey:@"flow_down"];
}

-(void) startScanQRCode
{
    [self.window addSubview:_myQuartzView];
    [self.window addSubview:scanLine];
    [scanLine.layer addAnimation:slowDownAnimation forKey:@"flow_down"];
}

-(void) stopScan
{
    NSLog(@"stop animation!");
    CFTimeInterval pausedTime = [scanLine.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    scanLine.layer.speed = 0.0;
    scanLine.layer.timeOffset = pausedTime;
    [scanLine.layer removeAllAnimations];
    [scanLine removeFromSuperview];
 //.   [_myQuartzView removeFromSuperview];
    [_scanPreviewLayer removeFromSuperlayer];
    
}

-(void) updateOilPrice:(CGFloat)newOilPrice
{
    currentOilPrice=newOilPrice;
    [defaults setObject:[NSString stringWithFormat:@"%f",newOilPrice] forKey:@"currentOilPrice"];
    [defaults synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    
}

-(void) legalNumberFormatter
{
    /*
    numberFormatter=[NSNumberFormatter new];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    */
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text=[textField.text stringByReplacingCharactersInRange:range withString:string ];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumber *number=[NSNumber numberWithInt:[text intValue]];
    [textField setText:[numberFormater stringFromNumber:number] ];
    return NO;
}

-(NSString*) dataToCloud
{
    NSDictionary *dictionary;
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    NSString *car_id,*item_id,*name,*lifeMiles,*leftPercent,*latestMiles;
    for(MaintainItem *item in maintainItems)
    {
        car_id=[NSString stringWithFormat:@"%d",(int)currentCar.car_id];
        item_id=[NSString stringWithFormat:@"%d",(int)item.itemId];
        name=item.itemName;
        lifeMiles=[NSString stringWithFormat:@"%ld",(long)item.lifeMiles];
        leftPercent=[NSString stringWithFormat:@"%d",(int)item.leftPercent];
        latestMiles=[NSString stringWithFormat:@"%d",(int)item.latestMaintainMiles];
        dictionary=[NSDictionary dictionaryWithObjectsAndKeys:ownerTel,@"owner",car_id ,@"car_code",item_id,@"id",name,@"itemname",lifeMiles,@"lifemiles",leftPercent,@"leftpercent",latestMiles,@"latestupdatedmiles", nil];
        [arr addObject:dictionary];
    }
    NSError *error=nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsondata:%@",jsonString);
    return jsonString;
}

-(void) updateCloudInfoWithCar:(Car *)aCar
{
    //commit post info to server.
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/insertNewCar.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"ownerTel=%@&code=%d&license=%@&brand=%@&color=%@&current_miles=%d&init_miles=%d&oilbox_volume=%f&total_oilvolume=%f&total_fuelingcost=%f&fueling_info=%@&flag=%d",ownerTel,(int)aCar.car_id,aCar.license,aCar.brandName,@"color",(int)aCar.currentMiles,(int)aCar.initMiles,aCar.oilBoxVolume,aCar.totalOilConsumption,aCar.totalOilCost,aCar.fuelingInfo,(int)aCar.flag];
 //   NSLog(@"post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"post carInfo successful responseInfo:%@",reponseString);
        }
        else NSLog(@"post carInfo error!");
    }];
    
    
    
}
-(void) updateMaintainCloudInfoWithBuffer:(NSMutableArray *)tMaintainItems Car:(Car *)aCar
{
    
    //generate maintain json data.
    NSDictionary *dictionary;
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    MaintainItem *item;
    for (int i=0; i<[tMaintainItems count]; i++) {
        item=[tMaintainItems objectAtIndex:i];
        dictionary=[[NSDictionary alloc] initWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%d",(int)item.carId],@"car_code",aCar.license,@"car_license",[NSString stringWithFormat:@"%d",(int)item.itemId],@"id",item.itemName,@"itemname"
                    ,[NSString stringWithFormat:@"%d",(int)item.leftMiles],@"safemiles",[NSString stringWithFormat:@"%d",(int)item.leftTime],@"leftdays",
                    [NSString stringWithFormat:@"%d",(int)item.lifeMiles],@"lifemiles",[NSString stringWithFormat:@"%d",(int)item.lifeTime],@"intervalyear",[NSString stringWithFormat:@"%d",(int)item.leftPercent],@"leftpercent",[NSString stringWithFormat:@"%d",(int)item.timeLeftPercent],@"timeleftpercent",[NSString stringWithFormat:@"%d",(int)item.latestMaintainMiles],@"latestupdatedmiles",item.latestMaintainDate,@"latestupdateddate",[NSString stringWithFormat:@"%d",(int)item.applyMark],@"applymark",nil];

        [arr addObject:dictionary];
    }
    NSError *error=nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // commit jsoninfo to cloud.
    
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/postMaintainInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"maintainjson=%@",jsonString];
 //   NSLog(@"post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
               NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"post maintaininfo successful！ response:%@",reponseString);
        }
        else NSLog(@"post maintaininfo error!");
    }];
    
}

-(void) postMaintainRecordsOfCar:(Car *)aCar Buffer:(NSMutableArray *)array
{
    
    //generate maintain Record json data.
    NSDictionary *dictionary;
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    MaintainRecord *record;
    for (int i=0; i<[array count]; i++) {
        record=[array objectAtIndex:i];
        dictionary=[[NSDictionary alloc] initWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%d",(int)aCar.car_id],@"car_code",aCar.license,@"car_license",[NSString stringWithFormat:@"%d",(int)record.item_id],@"item_id",record.itemname,@"itemname"
                    ,[NSString stringWithFormat:@"%d",(int)record.maintainMiles],@"miles",[NSString stringWithFormat:@"%d",(int)record.lifeMiles],@"lifemiles",
                    [NSString stringWithFormat:@"%f",record.cost1],@"cost",[NSString stringWithFormat:@"%f",record.cost2],@"cost_at",record.date,@"date",nil];
       
        [arr addObject:dictionary];
    }
    NSError *error=nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // commit jsoninfo to cloud.
    
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/post_maintain_record.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"maintainRecordJson=%@",jsonString];
    NSLog(@"post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"post maintainrecord successful！ response:%@",reponseString);
        }
        else NSLog(@"post maintainrecord error!");
    }];
}

-(void)postFuelingRecordOfCar:(Car *)aCar Record:(FuelingItem *)item
{
    //generate fueling item json.
    NSDictionary *dictionary;
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    dictionary=[[NSDictionary alloc] initWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%d",(int)aCar.car_id],@"car_code",aCar.license,@"car_license",[NSString stringWithFormat:@"%f",item.volume],@"volume",[NSString stringWithFormat:@"%f",item.cost],@"cost"
                ,[NSString stringWithFormat:@"%d",(int)item.miles],@"miles",[NSString stringWithFormat:@"%d",(int)item.addMiles],@"add_miles",
                [NSString stringWithFormat:@"%f",item.avCost],@"avcost",[NSString stringWithFormat:@"%f",item.avOil],@"avoil",item.date,@"date",nil];
    
    [arr addObject:dictionary];

    NSError *error=nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // commit jsoninfo to cloud.
    NSString *postUrl=[[NSString alloc] initWithFormat:@"%@postFuelingInfo.php",self.serverAddr];
    NSURL *url=[NSURL URLWithString:postUrl];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"fuelingjson=%@",jsonString];
    NSLog(@"post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"post fuelingItem successful！ response:%@",reponseString);
        }
        else NSLog(@"post fuelingItem error!");
    }];
    
    
    
}

-(void) postRepairRecordOfCar:(Car *)aCar Record:(RespairItem *)item
{
    //post respair info.
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/postRespairInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&car_code=%d&car_license=%@&item=%@&cost=%f&miles=%d&date=%@&note=%@",ownerTel,(int)aCar.car_id,aCar.license,item.names,item.cost,(int)item.miles,item.date,@"**"];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(error==nil)
        {
            
            NSLog(@"post repair record successfully!");
        } else NSLog(@"post repair record error! res:%@",reponseString);
    }];
}



-(NSString*) carsJson
{
    NSDictionary *dictionary;
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    NSString *car_id,*current_miles,*init_miles,*oilVolume;
    for(Car *car in cars)
    {
        car_id=[NSString stringWithFormat:@"%d",(int)car.car_id];
        current_miles=[NSString stringWithFormat:@"%d",(int)car.currentMiles];
        init_miles=[NSString stringWithFormat:@"%d",(int)car.initMiles];
        oilVolume=[NSString stringWithFormat:@"%f",car.totalOilConsumption];
        dictionary=[NSDictionary dictionaryWithObjectsAndKeys:ownerTel,@"owner",car_id ,@"code",car.license,@"license",car.brandName,@"brand",current_miles,@"current_miles",init_miles,@"init_miles",oilVolume,@"oilvolumn", nil];
        [arr addObject:dictionary];
    }
    NSError *error=nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsondata:%@",jsonString);
    return jsonString;
    
    
}

-(NSString*) fuelingJson
{
    NSDictionary *dictionary;
    NSMutableArray *arr=[[NSMutableArray alloc] init];    
    NSString *sql=[[NSString alloc] initWithFormat:@"select OIL_VOLUME ,OIL_COST,LAST_LEFT_VOLUME , CURRENT_MILES , DATE,CAR_ID  FROM FUELING_TABLE WHERE DATE>='%@' ",loginDate];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement,NULL)==SQLITE_OK)
    {
        CGFloat volume,cost;
        NSInteger miles,car_id;
        char *tDate;
        NSString *date;
     //   FuelingItem *item;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            volume=sqlite3_column_double(statement, 0);
            cost=sqlite3_column_double(statement, 1);
       //     leftVol=sqlite3_column_double(statement, 2);
            miles=sqlite3_column_int(statement, 3);
            tDate=(char*)sqlite3_column_text(statement, 4);
            date=[[NSString alloc] initWithUTF8String:tDate];
            car_id=sqlite3_column_int(statement, 5);
            dictionary=[NSDictionary dictionaryWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%d",(int)car_id] ,@"car_code",[NSString stringWithFormat:@"%f",volume], @"volume",[NSString stringWithFormat:@"%f",cost],@"cost",[NSString stringWithFormat:@"%d",(int)miles],@"miles",date,@"date", nil];
            [arr addObject:dictionary];
            
        }
    } else
    {
        NSLog(@"error select all fueling items");
    }
    NSError *error=nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsondata:%@",jsonString);
    return jsonString;      
}

-(NSString*) respairJson
{
    NSDictionary *dictionary;
    NSMutableArray *arr=[[NSMutableArray alloc] init];    
    NSString *sql=[[NSString alloc] initWithFormat:@"select NAMES ,COST , DATE,MILES,CAR_ID  FROM RESPAIR_TABLE WHERE DATE>='%@' ",loginDate];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement,NULL)==SQLITE_OK)
    {
        CGFloat cost;
        char *str;
        NSString *date,*names;
        NSInteger miles,car_id;
        while (sqlite3_step(statement)==SQLITE_ROW) {
            str=(char*)sqlite3_column_text(statement, 0);
            names=[[NSString alloc] initWithUTF8String:str];
            cost=sqlite3_column_double(statement, 1);
            str=(char*)sqlite3_column_text(statement, 2);
            date=[[NSString alloc] initWithUTF8String:str];
            miles=sqlite3_column_int(statement, 3);
            car_id=sqlite3_column_int(statement, 4);
            dictionary=[NSDictionary dictionaryWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%d",(int)car_id] ,@"car_code",names, @"item",[NSString stringWithFormat:@"%f",cost],@"cost",[NSString stringWithFormat:@"%d",(int)miles],@"miles",date,@"date", nil];
            [arr addObject:dictionary];
            
        }
    } else
    {
        NSLog(@"error select all fueling items");
    }
    NSError *error=nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsondata:%@",jsonString);
    return jsonString;    

}

-(void) showSpinnerView
{
    [self.window addSubview:spinnerView.view];
    spinnerView.view.tag=1;
}

-(void) takeOffSpinnerView
{
    if (spinnerView.view.tag>0) {
        spinnerView.view.tag=0;
        [spinnerView.view removeFromSuperview];
    }
}

-(void) showNotification:(NSString *)info
{
    [notificationInfo showNotificationWithStr:info];
}

-(void) dataToView
{
    NSLog(@"dataToView cars count:%d",(int)[cars count]);
    if([cars count]==0)
    {
     //   [[self carManageViewController] loadAddCarView:nil];        
    }else
    {
        currentCar=[cars objectAtIndex:0];
    //    [self selectMaintainTable];
        [self selectFuelingItems];
     //   [self selectRespairItems];
        [self.tracingCarViewController refreshView];
    }
    [navigationController popViewControllerAnimated:YES];
}


-(void) getUsefulInfo
{
    /*
    NSURL *url=[NSURL URLWithString:@"http://php.weather.sina.com.cn/iframe/index/w_cl.php?code=js&day=0&city=&dfc=1&charset=utf-8"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"%@",@""];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //  NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"get weather successful result:%@",reponseString);
            NSArray *array1=[reponseString componentsSeparatedByString:@"="];
            NSArray *array2,*array3;
            NSString *subinfo1,*subinfo2,*lowTmp,*highTmp;
         //   NSLog(@"array1 count:%lu",[array1 count] );
            if ([reponseString containsString:@"!DOCTYPE"] || [array1 count]<2) {
                weatherInfo=@"网络异常";
            }else{
                
                array2=[(NSString*)[array1 objectAtIndex:1] componentsSeparatedByString:@"'"];
                if ([array2 count]==0) {
                    city=@"";
                } else city=[array2 objectAtIndex:1];
                array2=[(NSString*)[array1 objectAtIndex:2] componentsSeparatedByString:@","];
            //    NSLog(@"array2 count:%lu",[array2 count] );
                if ([array2 count]>3) {
                    array3=[(NSString*)[array2 objectAtIndex:0] componentsSeparatedByString:@"'"];
                //    NSLog(@"array3 count:%lu",[array3 count] );
                    if ([array3 count]>1) {
                        subinfo1=(NSString*)[array3 objectAtIndex:1];
                    }
                    array3=[(NSString*)[array2 objectAtIndex:1] componentsSeparatedByString:@"'"];
                    if ([array3 count]>1) {
                        subinfo2=(NSString*)[array3 objectAtIndex:1];
                    }
                    array3=[(NSString*)[array2 objectAtIndex:4] componentsSeparatedByString:@"'"];
                    if ([array3 count]>1) {
                        lowTmp=(NSString*)[array3 objectAtIndex:1];
                    }
                    array3=[(NSString*)[array2 objectAtIndex:5] componentsSeparatedByString:@"'"];
                    if ([array3 count]>1) {
                        highTmp=(NSString*)[array3 objectAtIndex:1];
                    }
             //       NSLog(@"%@,%@,%@,%@",subinfo1,subinfo2,lowTmp,highTmp);
                    if (subinfo1!=nil&& subinfo2!=nil && lowTmp!=nil && highTmp!=nil) {
                        weatherInfo=[NSString stringWithFormat:@"%@ 转 %@ %@℃~%@℃",subinfo1,subinfo2,lowTmp,highTmp];
                    }else weatherInfo=@"网络异常";
                    
                }else weatherInfo=@"";
            }
     */
    //get concerned weather info .
    NSString *tCity=[city substringToIndex:[city length]-1];
   
    NSString *wUrl= [[NSString alloc] initWithFormat:@"http://wthrcdn.etouch.cn/WeatherApi?city=%@",tCity];;
    
    NSString *escapedUrl=[wUrl  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"city:%@  escapedPath: %@",tCity ,escapedUrl);
    NSURL *url1=[NSURL URLWithString:escapedUrl];
    //  NSString *post=nil;
    //  post=[NSString stringWithFormat:@"%@",@""];
    //  NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //  NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
    NSMutableURLRequest *request1=[[NSMutableURLRequest alloc] init];
    [request1 setURL:url1];
    [request1 setHTTPMethod:@"GET"];
    [request1 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // [request setHTTPBody:postData];
    NSOperationQueue *queue1=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request1 queue:queue1 completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            [self parseXmlWithData:data];
           // NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //  NSLog(@"get weather successful result:%@",reponseString);
        }else{
            NSLog(@"get weather error result:%@",[error description]);
        }
    }
     ];

    
    
            
            // get carlimit info.
            NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps;
            NSInteger unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
            NSDate *now=[NSDate date];
            comps=[calendar components:unitFlags fromDate:now];
            NSInteger week,day;
       //     NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        //    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            week=[comps weekday]-1;
            day=[comps day];
         //   NSLog(@"weekday:%ld day:%ld",week,day);
            switch (week) {
                case 1:
                    dateInfo=@"星期一";
                    break;
                case 2:
                    dateInfo=@"星期二";
                    break;
                case 3:
                    dateInfo=@"星期三";
                    break;
                case 4:
                    dateInfo=@"星期四";
                    break;
                case 5:
                    dateInfo=@"星期五";
                    break;
                case 6:
                    dateInfo=@"星期六";
                    break;
                case 0:
                    week=7;
                    dateInfo=@"星期日";
                    break;
                    
                default:
                    break;
            }
            //obtion limit_info.
            NSURL *Url=[NSURL URLWithString:@"http://www.qcygl.com/get_limitnumber_info.php"];
            NSString *post=nil;
            post=[NSString stringWithFormat:@"city=%@",tCity];
            NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
            NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
            [request setURL:Url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:postData];
            
            NSOperationQueue *queue=[[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
                if(error==nil)
                {
                    carLimitInfo=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    movingInfo.date=[dateFormatter stringFromDate:now];
                    movingInfo.date=dateInfo;
                    movingInfo.city=city;
                //    movingInfo.weather=weatherInfo;
                    movingInfo.limitNumber=carLimitInfo;
                    movingInfo.other=[currentCar getDaysConcernedInfo];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //    NSTimer *aTimer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(testTimer) userInfo:nil repeats:YES];
            [self.tracingCarViewController startMoveLabel:[movingInfo toString]];
                        
                        
                    });
                    [self checkHolidayInfo];
                    
                }
            }];
            
    
 //   [self getRunTimeOilPrice];
    
}

-(NSString*) md5_encode:(NSString*)input
{
    const char *cStr=[input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), digest);
    NSMutableString *output=[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    
    NSLog(@" md5_encode input:%@   output:%@",input,output);
    return output;
    
}

-(NSData*) toNSdata:(NSDictionary*)dictionary
{
    NSMutableData *data=[[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dictionary forKey:@"Some Key Value"];
    [archiver finishEncoding];
    return data;
}

-(void) getRunTimeOilPrice
{
    
    NSLog(@"*** getRunTimeOilPrice  province:%@",self.province);
    if ( self.province==nil || [self.province isEqual:@""]) {
        return;
    }
    NSString *tProvince;
    NSRange cRange=[province rangeOfString:@"市"];
    NSRange pRange=[province rangeOfString:@"省"];
    if (cRange.length>0 || pRange.length>0) {
        tProvince=[self.province substringToIndex:self.province.length-1];
    }
    NSString* url=[[NSString alloc] initWithFormat:@"http://route.showapi.com/138-46?showapi_appid=%@&prov=%@&showapi_sign=%@",@"20365",tProvince,@"2a919a5e6f0248588401f3a116ec2cf0"];
    
    NSLog(@"oilPrice url:%@",url);
    NSString *cURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSURL *aURl=[NSURL URLWithString:cURL];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:aURl];
 //   [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:5];
    NSString *post=@"";
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"0" forHTTPHeaderField:@"Content-Length"];
     [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError==nil) {
            NSString *result=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      //      NSLog(@" oil price result:%@",result);
            NSRange range1=[result rangeOfString:@"[{"];
           
            NSString *list=[result substringFromIndex:range1.location+2];
          //  NSLog(@" oil price list:%@",list);
             NSRange range2=[list rangeOfString:@"}]"];
            list=[list substringToIndex:range2.location];
        //    NSLog(@" oil price list:%@",list);
           
            oilPriceInfo=[[NSMutableString alloc] init];
            [oilPriceInfo appendFormat:@"%@油价信息\n",self.province];
            NSArray *array=[list componentsSeparatedByString:@","];
            for (int i=0; i<[array count]; i++) {
                NSString *str1=[array objectAtIndex:i];
                NSArray *array1=[str1 componentsSeparatedByString:@":"];
                NSString *str2=[array1 objectAtIndex:0];
                NSString *str3=[array1 objectAtIndex:1];
                if (![str2 isEqualToString:@"\"prov\""] && ![str2 isEqualToString:@"\"ct\""]) {
                    [oilPriceInfo appendFormat:@"%@:%@\n",str2,str3];
                }
            }
            NSRange range3=NSMakeRange(0, [oilPriceInfo length]);
            [oilPriceInfo replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:range3];
            /*
            NSLog(@" oil price result:%@",result);
             NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *showapi_res_body=[dictionary objectForKey:@"showapi_res_body"];
            NSLog(@" oil price showapi_res_body:%@",showapi_res_body);
        //    NSDictionary *dic01=[NSJSONSerialization JSONObjectWithData:[showapi_res_body dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSMutableString *list=[showapi_res_body objectForKeyedSubscript:@"list"];
            NSLog(@" oil price list:%@",list);
        
            NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:[self toNSdata:list] options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *dic=[arr objectAtIndex:0];
            NSLog(@" oil price dic:%@",arr);
            NSString *p0=[dic objectForKey:@"p0"];
            NSString *p90=[dic objectForKey:@"p90"];
            NSString *p93=[dic objectForKey:@"p93"];
            NSString *p97=[dic objectForKey:@"p97"];
            self.oilPriceInfo=[[NSString alloc] initWithFormat:@"  %@油价信息\n  p0:%@\n  p90:%@\n  p93:%@\n  p97:%@",self.province,p0,p90,p93,p97];
            */
        }else {
            NSLog(@"oil_price error:%@",connectionError );
        }
        
    }];
}
-(void) checkHolidayInfo
{
  //  NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
   // [dateFormatter setDateFormat:@"YYYYMMdd"];
    
    NSString *checkUrl=[[NSString alloc] initWithFormat:@"http://www.easybots.cn/api/holiday.php?d=%@",[dateFormatter stringFromDate:[NSDate date]]];
    
    NSURL *url=[NSURL URLWithString:checkUrl];
   NSString *post=@"";
  //  post=[NSString stringWithFormat:@"city=%@",city];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
 //   NSString *postLength=[NSString stringWithFormat:@"%ld",(long)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"0" forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
           NSString*  reponseInfo=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"check holiday result:%@",reponseInfo);
            NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *flag=[dictionary objectForKey:[dateFormatter stringFromDate:[NSDate date]]];
            if ([flag integerValue]==2) {
                movingInfo.limitNumber=@"不限号";
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tracingCarViewController startMoveLabel:[movingInfo toString]];
                    
                    
                });
            }
            
        }
    }];

}

-(void) getRelatedGarages
{
    NSLog(@"*** getRelatedGarages membertype:%d",(int)memberType);
    [relatedGarages removeAllObjects];
    if (memberType>=2) {
        [relatedGarages addObject:customGarage];
        return;
    }
    
    NSString *address=[[NSString alloc] initWithFormat:@"%@get_related_garages.php",serverAddr];
    NSURL *url=[NSURL URLWithString:address];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"owner=%@&mac=%@",ownerTel,@"apple iphone"];
    //  NSLog(@"getCarInfo is work post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            //    NSLog(@"post successful");
       //     NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       //     NSLog(@"get_related_garages reponseString:%@",reponseString);
            
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            if(jsonObject!=nil)
            {
                NSError *error;
                NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                //   NSArray *array=[[NSArray alloc] initWithArray:jsonObject];
                //   NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
                NSDictionary *dictionary;
                NSString *garageId,*tGarageTel,*garageContact,*garageName,*garageShortName,*garageAddr,*garageBusiness,*garageFlag;
                NSInteger level;
                NSLog(@"*** related garages count:%d",(int)[arr count]);
            //    [relatedGarages removeAllObjects];
                for(int i=0;i<[arr count]; i++)
                {
                    dictionary=[arr objectAtIndex:i];
                    garageId=[dictionary objectForKey:@"id"];
                    tGarageTel=[dictionary objectForKey:@"tel"];
                    garageContact=[dictionary objectForKey:@"contact"];
                    garageName=[dictionary objectForKey:@"name"];
                    garageShortName=[dictionary objectForKey:@"shortname"];
                    garageBusiness=[dictionary objectForKey:@"business"];
                    garageAddr=[dictionary objectForKey:@"addr"];
                    garageFlag=[dictionary objectForKey:@"passed"];
                    level=[[dictionary objectForKey:@"level"] intValue];
                    Garage *oneGarage=[[Garage alloc] initWithShortName:garageShortName Name:garageName Tel:tGarageTel Contact:garageContact Business:garageBusiness Addr:garageAddr Flag:[garageFlag intValue] ];
                    oneGarage.id_code=garageId;
                    oneGarage.directLevel=level;
              //      NSLog(@"garage:%@",[oneGarage getCheckInfo]);
                    [relatedGarages addObject:oneGarage];
                    if (level==1) {
                        [directRelatedGarages addObject:oneGarage];
                    //    NSLog(@"directed garage %@",[oneGarage getCheckInfo]);
                    }
                    /*
                    if (oneGarage.passed==2) {
                        [passedGarages addObject:oneGarage];
                    } else [checkGarages addObject:oneGarage];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //   NSLog(@"this printf in main thread.");
                        [checkedGaragesTable reloadData];
                    }); */
                    
                }
            }
            /*
            if ([relatedGarages count]==0) {
                [relatedGarages addObject:[[Garage alloc] init] ];
            } */
            
            
        }
        else NSLog(@"post error!");
    }];
    
    
    
}

-(BOOL) stringIsNull:(id)object
{
    // judge  null string
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (object==nil){
        return YES;
    }
    return NO;
}

-(void) testTimer
{
    NSLog(@"appdelegate test Timer.");
}

-(void) setDateInputView:(UITextField *)textField
{
    [textField setInputView:customInput];
    [textField setInputAccessoryView:accessoryView];
}
-(void)finishMaintainDateSet
{
    NSLog(@"finishMaintainDateSet is called!");
    [currentInputDate resignFirstResponder];
    [currentInputDate setText:[dateFormatter stringFromDate:customInput.date]];
    /*
    switch (customInput.tag) {
        case 0:
            [inspectDay setText:[dateFormatter stringFromDate:customInput.date]];
            [inspectDay resignFirstResponder];
            
            break;
        case 1:
            [insuranceDay setText:[dateFormatter stringFromDate:customInput.date]];
            [insuranceDay resignFirstResponder];
            
            break;
        case 2:
            [itemInitLatestMaintainMiles resignFirstResponder];
            [itemInitMaintainLifeMiles resignFirstResponder];
            [itemInitLatestMaintainDate resignFirstResponder];
            [itemInitLatestMaintainDateDiv resignFirstResponder];
            [itemInitLatestMaintainDate setText:[dateFormatter stringFromDate:customInput.date]];
            break;
        case 3:
            [currentInputDate resignFirstResponder];
            [currentInputDate setText:[dateFormatter stringFromDate:customInput.date]];
            currentEditItem.latestMaintainDate=currentInputDate.text;
            break;
        case 4:
            [insuranceDay setText:[dateFormatter stringFromDate:customInput.date]];
            [insuranceDay resignFirstResponder];
            break;
        default:
            break;
    } */
    
}
 
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error get weather!");
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int current=scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    UIPageControl *page=(UIPageControl*)([self.window viewWithTag:201] );
    page.currentPage=current;
    if (current==3) {
        [self removeWelcomeView];
    }
    
}

-(void) parseXmlWithData:(NSData*) data
{
    NSXMLParser *xmlParser=[[NSXMLParser alloc] initWithData:data];
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //  NSLog(@"elementName:%@ namespaceURI:%@ qualifiedName:%@",elementName,namespaceURI,qName);
    if ([elementName isEqualToString:@"city"]) {
       // cityInfo=currentVal;
    }else if (parseCount==0){
        if ([elementName isEqualToString:@"high"]) {
            [ weatherInfo appendString:currentVal];
        } else if([elementName isEqualToString:@"low"]){
            [ weatherInfo appendString:@" "];
            [ weatherInfo appendString:currentVal];
        } else if ([elementName isEqualToString:@"type"]){
            [ weatherInfo appendString:@" "];
            [ weatherInfo appendString:currentVal];
            parseCount++;
        }
    }else if(parseCount==1){
        if ([elementName isEqualToString:@"type"]){
            [ weatherInfo appendString:@"转"];
            [ weatherInfo appendString:currentVal];
            parseCount++;
        }
    }else if(parseCount==3 && [elementName isEqualToString:@"detail"]){
        [ weatherInfo appendString:@" "];
        [ weatherInfo appendString:currentVal];
        parseCount++;
    }
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // NSLog(@"elementName:%@, qualifiedName:%@",elementName,qName);
    if ([elementName isEqualToString:@"city"]) {
        currentElementName=elementName;
    }else if (parseCount==0&&([elementName isEqualToString:@"high"]||[elementName isEqualToString:@"low"] || [elementName isEqualToString:@"type"])) {
        currentElementName=elementName;
    } else if(parseCount==1){
        if ([elementName isEqualToString:@"type"]) {
            currentElementName=elementName;
        }
    } else if(parseCount==3 && [elementName isEqualToString:@"detail"]){
        currentElementName=elementName;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElementName isEqualToString:@"city"]) {
        currentVal=string;
    }else if(parseCount==0){
        if ([currentElementName isEqualToString:@"high"]||[currentElementName isEqualToString:@"low"] || [currentElementName isEqualToString:@"type"]) {
            currentVal=string;
        }
    }else if (parseCount==1){
        if([currentElementName isEqualToString:@"type"]){
            currentVal=string;
        }
    }else if([string isEqualToString:@"洗车指数"])
        parseCount++;
    else if (parseCount==3 && [currentElementName isEqualToString:@"detail"])
        currentVal=string;
    
    //  NSLog(@"foundCharacters:%@",string);
}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    parseCount=0;
    weatherInfo=[[NSMutableString alloc] init];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"weatherInfo:%@",weatherInfo);
    movingInfo.weather=weatherInfo;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tracingCarViewController startMoveLabel:[movingInfo toString]];
        
        
    });
    
    
}

-(void) initJPUSHService
{
    /*.
    if ([[UIDevice currentDevice].systemVersion floatValue]>8.0) {
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert) categories:nil];
    }else{
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    */
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"**didRegisterForRemoteNotificationsWithDeviceToken");
   //. [JPUSHService registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"**didReceiveRemoteNotification %@",userInfo);
  //.  [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

-(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

- (void)setupCapture {
    dispatch_async(dispatch_get_main_queue(), ^{
        _scanSession = [[AVCaptureSession alloc] init];
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error;
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (deviceInput) {
            [_scanSession addInput:deviceInput];
            
            AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [_scanSession addOutput:metadataOutput]; // 这行代码要在设置 metadataObjectTypes 前
            metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
            
            _scanPreviewLayer= [[AVCaptureVideoPreviewLayer alloc] initWithSession:_scanSession];
            _scanPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            _scanPreviewLayer.frame = self.window.frame;
          //  [self.window.layer insertSublayer:previewLayer atIndex:0];
            [self.window.layer addSublayer:_scanPreviewLayer];
         //   [self.view.layer insertSublayer:previewLayer atIndex:0];
            
            //       __weak typeof(self) weakSelf = self;
            /*
            [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                              object:nil
                                                               queue:[NSOperationQueue currentQueue]
                                                          usingBlock: ^(NSNotification *_Nonnull ) {
                                                           //   screenWidth=appDelegate.screenWidth;
                                                              CGRect rect = CGRectMake(40, 80, screenWidth - 80, screenWidth - 80);
                                                              CGRect intertRect=[previewLayer metadataOutputRectOfInterestForRect:rect];
                                                              CGRect layerRect=[previewLayer rectForMetadataOutputRectOfInterest:intertRect];
                                                              NSLog(@" %@, %@,  %@",NSStringFromCGRect(rect),NSStringFromCGRect(intertRect),NSStringFromCGRect(layerRect));
                                                              metadataOutput.rectOfInterest=intertRect;
                                                              
                                                              
                                                              //    metadataOutput.rectOfInterest = [previewLayer metadataOutputRectOfInterestForRect:weakSelf.scanRect]; // 如果不设置，整个屏幕都可以扫
                                                          }]; */
          
            [self loadConcernScanViews];
            [_scanSession startRunning];
        } else {
            NSLog(@"%@", error);
        }
    });
}

-(void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count ] > 0 )
        
    {
        // 停止扫描
        [_scanSession stopRunning ];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        stringValue = metadataObject. stringValue ;
   //     addedGarageNum.text=stringValue;
        [self stopScan];
        if (_scanOperationFlag==1) {
            [self addGarage:stringValue];
        }
    //    [_scanPreviewLayer removeFromSuperlayer];
        //concernd followed operation
        
    }
}

-(void)addGarage:(NSString *)garageID{
    
    //   NSString *garageId=addedGarageNum.text;//oneGarageNum.text;
    //   if ([garageId isEqualToString:@""]) {
    //       return;
    //  }
   // [[NSString alloc] initWithFormat:@"%@owner_add_garage.php",self.serverAddr];
    NSURL *url=[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@owner_add_garage.php",self.serverAddr]];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"tel=%@&garage=%@",ownerTel ,garageID];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error==nil)
        {
            NSLog(@"owner_add_garage  post successful");
            NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"get data:%@",reponseString);
            if ([self stringIsNull:reponseString]) {
                NSLog(@"invalided garage id!");
                return ;
            }
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            
            NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:jsonObject];
            NSDictionary *dictionary;
            NSString *garageId,*name,*shortname,*tel,*contact,*addr,*business;
            Garage *aGarage;
            //   NSLog(@"count %d:%d",[array count],[arr count]);
            for(int i=0;i<[arr count]; )
            {
                dictionary=[arr objectAtIndex:i];
                garageId=[dictionary objectForKey:@"id"];
                name=[dictionary objectForKey:@"name"];
                shortname=[dictionary objectForKey:@"shortname"];
                tel=[dictionary objectForKey:@"tel"];
                contact=[dictionary objectForKey:@"contact"];
                addr=[dictionary objectForKey:@"addr"];
                business=[dictionary objectForKey:@"business"];
                aGarage=[[Garage alloc] initWithShortName:shortname Name:name Tel:tel Contact:contact Business:business Addr:addr Flag:1];
                aGarage.id_code=garageId;
                break;
                
            }
            
            [self.relatedGarages insertObject:aGarage atIndex:[self.directRelatedGarages count]];
            [self.directRelatedGarages addObject:aGarage];
            
            dispatch_async(dispatch_get_main_queue(),^{
              //  [garageTable reloadData];
            });
        }
        else{
            NSLog(@"owner_add_garage post error!");
        }
    }];
    
    //  [oneGarageNum resignFirstResponder];
    
}

-(void) addRedPointNotification
{
  //  CGFloat ver=[XWGlobalHelper syst]
    UIUserNotificationSettings *settings=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:3];
                                          
    
}

-(NSString*) getEndDate:(NSString *)startDate life:(NSInteger)lifeDays
{
    NSDate *sDate=[dateFormatter dateFromString:startDate];
    NSDate *eDate;
    NSTimeInterval oneDay=24*60*60;
    eDate=[sDate initWithTimeIntervalSinceNow:oneDay*lifeDays];
  //  [eDate initWithTimeInterval:oneDay*lifeDays sinceDate:sDate];
    return [dateFormatter stringFromDate:eDate];
}



@end
