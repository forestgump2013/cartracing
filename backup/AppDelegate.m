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
#import "LoginViewController.h"
#import "CarManageViewController.h"
#import "PersonalCenterViewController.h"
#import "CarsTableView.h"
#import "Car.h"
#import "Garage.h"
#import "NotificationLabel.h"
#import "SpinnerViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize memberType,getDataFromCloud;
@synthesize currentCarId;
@synthesize notificationInfo;
//@synthesize currentCarLicense;
@synthesize oilPrice,screenWidth,screenHeight;
@synthesize loginDate,ownerTel,garageTel,dateInfo,city,weatherInfo,carLimitInfo;
@synthesize currentCar,garage,currentInputDate,currentEditItem;
@synthesize  tracingCarViewController;
@synthesize loginViewController;
@synthesize carsTableView,spinnerView;
@synthesize personalCenterViewController;
@synthesize database,carBrandDataBase,brandDictionary,areaCodeArray,carCheckYearUnits,itemDetails;
@synthesize maintainItems,maintainRecords;
//@synthesize waitedMaintainItems;
@synthesize fuelingItems,respairItems;
@synthesize cars,deletedCars;
@synthesize navigationController,leftNavigationController,rightNavigationController;
@synthesize itemInitItemName,itemInitLatestMaintainMiles,addMaintainItemName,itemInitMaintainLifeMiles,itemInitLatestMaintainDate,itemInitLatestMaintainDateDiv,accessoryView,customInput,maintainItemSetScrollView,maintainItemInitView;

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
    NSString *createSQL=@"CREATE TABLE IF NOT EXISTS  CARS_TABLE (CAR_ID INTEGER PRIMARY KEY , BRAND_NAME TEXT,BRAND_MODEL TEXT , CURRENT_MILES INTEGER ,INIT_MILES INTEGER, TOTAL_OILVOLUME REAL,TOTAL_OILCOST REAL,OILBOX_VOLUME REAL, LICENSE TEXT,MAINTAIN_INFO TEXT,FUELING_INFO TEXT,RESPAIR_INFO TEXT, FLAG INTEGER)";
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
  //  [self.carManageViewController setDatabase:database];
  
}

-(void) restoreOneCar:(Car *)aCar
{
    //UPDATE FALAG
    NSString *sql=[NSString stringWithFormat:@"UPDATE CARS_TABLE SET FLAG=1   WHERE CAR_ID=%ld ",aCar.car_id];
    char *msg;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in restoreOneCar", msg);
    }
    
    /*
    //return restored car.
    NSString *query=[NSString stringWithFormat:@"select CAR_ID,BRAND_NAME,CURRENT_MILES,LICENSE,INIT_MILES,TOTAL_OILVOLUME,TOTAL_OILCOST,FUELING_INFO FROM CARS_TABLE WHERE LICENSE=%@",car_license];
    sqlite3_stmt *statement;
    NSInteger init_miles;
    CGFloat oilVolume,oilCost;
    char* str;
    NSString *fuelingInfo,*brandName;
    
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSInteger carid=sqlite3_column_int(statement, 0);
            char *tbrandName=(char*)sqlite3_column_text(statement, 1);
            brandName=[[NSString alloc] initWithUTF8String:tbrandName];
            NSInteger currentMiles=sqlite3_column_int(statement,2);
            char *tlicense=(char*)sqlite3_column_text(statement, 3);
            init_miles=sqlite3_column_int(statement, 4);
            oilVolume=sqlite3_column_double(statement, 5);
            oilCost=sqlite3_column_double(statement, 6);
            
            if(tlicense==NULL)
            {
                tlicense="nullString";
                break;
            }
            NSString *license=[[NSString alloc] initWithUTF8String:tlicense];
            str=(char*)sqlite3_column_text(statement, 7);
            fuelingInfo=[[NSString alloc] initWithUTF8String:str];
            Car *oneCar=[[Car alloc] initWithCarId:carid currentMiles:currentMiles license:license brand:brandName];
            [oneCar setBrandName:brandName];
            oneCar.initMiles=init_miles;
            oneCar.totalOilCost=oilCost;
            oneCar.totalOilConsumption=oilVolume;
            [oneCar.fuelingInfo setString:fuelingInfo];
            [oneCar initOilConsumeRecordsWithFuelingInfo] ;
            return oneCar;
        }
    }
    
    return nil; */
}

-(void) deleteOneCar:(NSInteger)car_id
{
    NSString *sql=[NSString stringWithFormat:@"UPDATE CARS_TABLE  SET FLAG=0  WHERE CAR_ID=%ld ",car_id];
    char *msg;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in delete from cars_table", msg);
    }/*
    sql=[NSString stringWithFormat:@"UPDATE SET FLAG=0  MAINTAIN_ITEMS_TABLE WHERE CAR_ID=%ld ",car_id];
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in delete from maintain_table", msg);
    }   
    sql=[NSString stringWithFormat:@"DELETE FROM FUELING_TABLE WHERE CAR_ID=%ld ",car_id];
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in delete from fueling_table", msg);
    } 
    sql=[NSString stringWithFormat:@"DELETE FROM RESPAIR_TABLE WHERE CAR_ID=%ld ",car_id];
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0, @"error in delete from respair_table", msg);
    }      */
}

-(void)clearDataBase
{
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
 //   cars=[NSMutableArray array];
    //INIT_MILES INTEGER, TOTAL_OILVOLUME REAL,TOTAL_OILCOST REAL    
    
    NSString *query=@"select CAR_ID,BRAND_NAME,CURRENT_MILES,LICENSE,INIT_MILES,TOTAL_OILVOLUME,TOTAL_OILCOST,FUELING_INFO, FLAG FROM CARS_TABLE ORDER BY CAR_ID ASC";
    sqlite3_stmt *statement;
    NSInteger init_miles,currentMiles,flag;
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
            NSLog(@"get one car flag:%ld!",flag);
            if (flag==1) {
                [cars addObject:oneCar];
            }else [deletedCars addObject:oneCar];
            
            NSLog(@"add a car %@,carId=%ld",license,carid);
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
    /*
     "机油","机油滤芯","空气滤清器","空调滤清器",
     "汽油滤清器","变速箱油","转向助力油","火花塞",
     "刹车油","防冻液","检查刹车片","轮胎换位",
     "四轮定位","清洗喷油嘴","清洗油路","清洗进气道"};
     */
    
    
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:9 itemName:@"刹车油" lifeMiles:30000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:10 itemName:@"防冻液" lifeMiles:40000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:11 itemName:@"检查刹车片" lifeMiles:40000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:12 itemName:@"轮胎换位" lifeMiles:40000 latestMaintinMiles:0 leftPercent:100]];
    
    
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:13 itemName:@"四轮定位" lifeMiles:50000 latestMaintinMiles:0 leftPercent:100]];
    //---
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:14 itemName:@"清洗喷油嘴" lifeMiles:10000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:15 itemName:@"清洗油路" lifeMiles:20000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:16 itemName:@"清洗进气道" lifeMiles:30000 latestMaintinMiles:0 leftPercent:100]];
    
    /*
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:16 itemName:@"发动机内部积炭" lifeMiles:50000 latestMaintinMiles:0 leftPercent:100]];
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:17 itemName:@"三元催化器" lifeMiles:50000 latestMaintinMiles:0 leftPercent:100]];    
    [maintainItems addObject:[[MaintainItem alloc] initWithItemId:18 itemName:@"进气道" lifeMiles:50000 latestMaintinMiles:0 leftPercent:100]];       
    */
    
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
    areaCodeArray=[[NSArray alloc] initWithObjects:@"京",@"津",@"沪",@"渝",@"鲁",@"皖",@"苏",@"浙",nil];
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
    
}

-(TracingCarViewController *)getTracingCarViewController
{
    return [self tracingCarViewController];
}

-(void) saveCurrentCarInfo
{
    NSLog(@"saveCurrentCarInfo is called carid=%ld",currentCar.car_id);
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
    NSString *sql=[NSString stringWithFormat: @"update CARS_TABLE set CURRENT_MILES=%ld,INIT_MILES=%ld,TOTAL_OILVOLUME=%f,TOTAL_OILCOST=%f,FUELING_INFO='%@' where CAR_ID=%ld",currentCar.currentMiles,currentCar.initMiles,currentCar.totalOilConsumption,currentCar.totalOilCost,currentCar.fuelingInfo,currentCar.car_id];
 //   sqlite3_stmt *statement;
    if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error in updating CURRENT_MILES of CAR_TABLE");
        sqlite3_close(database);        
    }
   
    NSLog(@"updateCurrentCarInfo is worked! miles:%ld,car_id %ld",currentCar.currentMiles,currentCar.car_id);
    if (!getDataFromCloud && ![self.ownerTel isEqualToString:@"none"]) {
        [self updateCloudInfoWithCar:currentCar];
    }
    
    
}

-(void) updateCarInfo:(Car *)aCar
{
    NSString *sql=[NSString stringWithFormat: @"update CARS_TABLE set LICENSE='%@'where CAR_ID=%ld",aCar.license,aCar.car_id];
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
    NSString *sql=[NSString stringWithFormat: @"update CARS_TABLE set MAINTAIN_INFO=%@ where CAR_ID=%ld",currentCarMaintainInfo,currentCarId];
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
    NSString *sql=[NSString stringWithFormat:@"select CURRENT_MILES,LICENSE from CARS_TABLE where CAR_ID=%ld ",currentCarId];
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
    NSString *sql=[NSString stringWithFormat: @"select ITEM_ID,ITEM_NAME,LIFE_MILES,LATEST_MAINTAIN_MILES,LEFT_PERCENT,LEFT_MILES,LIFE_TIME,LATEST_MAINTAIN_TIME,TIME_LEFT_PERCENT,APPLY_MARK from MAINTAIN_ITEMS_TABLE where CAR_ID=%ld  ORDER BY APPLY_MARK DESC,LEFT_MILES ASC",Carid];
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
            /*
            if(itemName.length>4) 
            {
                NSMutableString *str1=[[NSMutableString alloc] initWithString:itemName];
                [str1 insertString:@"\n" atIndex:4];
                itemName=str1;
            }            */
            lifeMiles=sqlite3_column_int(statement, 2);
            latestMtMiles=sqlite3_column_int(statement, 3);
            leftPercent=sqlite3_column_int(statement, 4);
            leftMiles=sqlite3_column_int(statement, 5);
            apply_mark=sqlite3_column_int(statement, 9);
            item=[[MaintainItem alloc] initWithCarId:Carid ItemId:itemId itemName:itemName lifeMiles:lifeMiles latestMaintinMiles:latestMtMiles leftPercent:leftPercent leftMiles:leftMiles  APPLYMARK:apply_mark];
        //    item=[[MaintainItem alloc] initWithItemId:itemId itemName:itemName lifeMiles:lifeMiles latestMaintinMiles:latestMtMiles leftPercent:leftPercent];
            lifeTime=sqlite3_column_int(statement, 6);
            if (lifeTime>0) {
                str=(char*)sqlite3_column_text(statement, 7);
                latestTime=[[NSString alloc] initWithUTF8String:str];
         //       timeLeftPercent=sqlite3_column_int(statement, 7);
                [item configrationTimeWithLifeTime:lifeTime latestMaintainTime:latestTime];
            }
            /*
            if (item.lifeTime>0) {
                [item updateLeftTime];
            } */
            [buffer addObject:item];
        }
    }else{
        NSLog(@"selectMaintainTableWithCarId error! sql=%@",sql);
    }
  //  [tracingCarViewController.maintainItemsTable reloadData];
 //   NSLog(@"select maintaininfo is worked carId=%ld,count=%ld",Carid,[buffer count]);
}

-(void)selectMaintainRecordsWithItemId:(NSInteger)iId toBuffer:(NSMutableArray *)recordsBuffer
{
    NSString *sql;
    if(iId<0)
        sql=[[NSString alloc] initWithFormat:@"select ITEM_ID , ITEM_NAME ,MAINTAIN_MILES , MAINTAIN_COST ,MAINTAIN_DATE from MAINTAIN_RECORD_TABLE where CAR_ID=%ld ",currentCar.car_id];
    else 
        sql=[[NSString alloc] initWithFormat:@"select ITEM_ID , ITEM_NAME ,MAINTAIN_MILES , MAINTAIN_COST ,MAINTAIN_DATE from MAINTAIN_RECORD_TABLE where CAR_ID=%ld and ITEM_ID=%ld ",currentCar.car_id,iId];
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
     NSLog(@"selectMaintainRecordsWithItemId:%ld count:%ld",iId,[recordsBuffer count]);
}

-(void)selectMaintainAllRecordsToBuffer:(NSMutableArray *)recordsBuffer
{
    //ITEM_ID INTEGER , CAR_ID INTEGER , ITEM_NAME TEXT,MAINTAIN_MILES INTEGER, MAINTAIN_COST FLOAT,MAINTAIN_DATE TEXT
    NSString *sql=[[NSString alloc] initWithFormat:@"select ITEM_ID , ITEM_NAME ,MAINTAIN_MILES , MAINTAIN_COST ,MAINTAIN_DATE from MAINTAIN_RECORD_TABLE where CAR_ID=%ld ",currentCar.car_id];
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
    NSLog(@"selectMaintainAllRecordsToBuffer count:%ld",[recordsBuffer count]);
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
        sql=[NSString stringWithFormat:@"update MAINTAIN_ITEMS_TABLE set LIFE_MILES=%ld ,LIFE_TIME=%ld, LATEST_MAINTAIN_MILES=%ld,LEFT_MILES=%ld,LATEST_MAINTAIN_TIME='%@' , LEFT_PERCENT=%ld,TIME_LEFT_PERCENT=%ld where ITEM_ID=%ld and CAR_ID=%ld",item.lifeMiles,item.lifeTime,item.latestMaintainMiles,item.leftMiles,item.latestMaintainDate,item.leftPercent,item.timeLeftPercent ,item.itemId,aCar.car_id];
       
        if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
        {
            NSLog(@"error in update MAINTAIN_ITEMS_TABLE");
            sqlite3_close(database);            
        }
        if (item.lifeTime>0) {
            NSLog(@"updateMaintainItemInfo withlifetime name:%@ lifetime=%ld",item.itemName,item.lifeTime);
        }
        
    }
    NSLog(@"updateMaintainInfo is worked. carId=%ld",aCar.car_id);
    if (!getDataFromCloud && ![self.ownerTel isEqualToString:@"none"]) {
        [self updateMaintainCloudInfoWithBuffer:buffer Car:aCar];
    }
}

-(void) updateSignalMaintainItemWithMaintianItem:(MaintainItem *)item
{
    NSString *sql=[NSString stringWithFormat:@"update MAINTAIN_ITEMS_TABLE set LIFE_MILES=%ld , LATEST_MAINTAIN_MILES=%ld , LEFT_PERCENT=%ld,LEFT_MILES=%ld, LIFE_TIME=%ld , LATEST_MAINTAIN_TIME='%@' ,APPLY_MARK=%ld where ITEM_ID=%ld and CAR_ID=%ld",item.lifeMiles,item.latestMaintainMiles,item.leftPercent,item.leftMiles,item.lifeTime,item.latestMaintainDate ,item.applyMark,item.itemId,item.carId];
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
    NSString *sql=[[NSString alloc] initWithFormat:@"select NAMES ,COST , DATE,MILES  FROM RESPAIR_TABLE WHERE CAR_ID=%ld ORDER BY DATE DESC ",currentCar.car_id];
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
    NSLog(@"selectRespairItems is worked. carId=%ld,count:%ld",currentCar.car_id,[respairItems count]);    
}


-(void) selectFuelingItems
{
    [fuelingItems removeAllObjects];
    NSString *sql=[[NSString alloc] initWithFormat:@"select OIL_VOLUME ,OIL_COST,LAST_LEFT_VOLUME , CURRENT_MILES , DATE,AV_OIL,AV_COST,ADD_MILES  FROM FUELING_TABLE WHERE CAR_ID=%ld    ORDER BY CURRENT_MILES DESC ",currentCar.car_id];
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
    NSLog(@"selectFuelingItems is worked. carId=%ld,count:%ld",currentCar.car_id,[fuelingItems count]);      
    
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
            date=[[NSString alloc] initWithUTF8String:tDate];
            item=[[FuelingItem alloc] initWithCurrentMiles:miles LeftVol:leftVol Volume:volume Cost:cost Date:date];
            volume=sqlite3_column_double(statement, 5);
            item.avOil=volume;
            cost=sqlite3_column_double(statement, 6);
            item.avCost=cost;
            miles=sqlite3_column_int(statement, 7);
            item.addMiles=miles;
      //      [fuelingItems addObject:item];
            NSLog(@"all fueling items miles:%ld",miles);
            
        }
    } else
    {
        NSLog(@"error select fueling table");
    }
    NSLog(@"selectAllFuelingItems is worked. ");       
    
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
    
    NSString *insertSql=[[NSString alloc] initWithFormat:@"INSERT INTO CARS_TABLE(CAR_ID, LICENSE, BRAND_NAME ,BRAND_MODEL, CURRENT_MILES , INIT_MILES , TOTAL_OILVOLUME ,OILBOX_VOLUME, MAINTAIN_INFO,FUELING_INFO,RESPAIR_INFO , FLAG ) VALUES(%ld,'%@','%@','%@',%ld,%ld,%f,%f,'%@','%@','%@',%ld);",car.car_id,car.license,car.brandName,car.brandModel,car.currentMiles,car.initMiles,car.totalOilConsumption,car.oilBoxVolume,car.maintainInfo,car.fuelingInfo,car.respairInfo,car.flag];
    //  sqlite3_stmt *statement;
    char *errMsg;
    if(sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, &errMsg)!=SQLITE_OK)
    {
        NSLog(@"error insert new car record!");
        NSAssert1(0, @"err insert new car %s", errMsg);
        sqlite3_free(errMsg);
        sqlite3_close(database);
    }    
    [cars addObject:car];
    
    NSLog(@"insertNewCar is worked. carId=%ld",currentCar.car_id);
    
    if (!getDataFromCloud && ![self.ownerTel isEqualToString:@"none"]) {
        [self updateCloudInfoWithCar:car];
    }
    
}

-(void)insertMaintainItem:(MaintainItem *)mItem
{
    
    NSString *insertSql=[[NSString alloc] initWithFormat:@"INSERT INTO MAINTAIN_ITEMS_TABLE(ITEM_ID , CAR_ID , ITEM_NAME , LIFE_MILES , LATEST_MAINTAIN_MILES , LEFT_PERCENT,LEFT_MILES, LIFE_TIME, LATEST_MAINTAIN_TIME , TIME_LEFT_PERCENT, APPLY_MARK ) VALUES(%ld,%ld,'%@',%ld,%ld,%ld,%ld,%ld,'%@',%ld,%ld);",
                         mItem.itemId,mItem.carId,mItem.itemName,mItem.lifeMiles,mItem.latestMaintainMiles,mItem.leftPercent,mItem.leftMiles,mItem.lifeTime,mItem.latestMaintainDate,mItem.timeLeftPercent,mItem.applyMark];
    //  sqlite3_stmt *statement;
   
    if(sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error insert maintain Item! name:%@",mItem.itemName);
        sqlite3_close(database);
    }    
    
    NSLog(@"insertMaintainItem is worked. sql=%@",insertSql);
}

-(void)insertmaintainRecord:(MaintainRecord *)record
{
    
    NSString *sql=[[NSString alloc] initWithFormat:@"INSERT INTO  MAINTAIN_RECORD_TABLE(ITEM_ID , CAR_ID , ITEM_NAME ,MAINTAIN_MILES , MAINTAIN_COST ,MAINTAIN_DATE ) VALUES(%ld,%ld,'%@',%ld,%f,'%@')",record.item_id,record.car_code,record.itemname,record.maintainMiles,record.cost1,record.date];
    if(sqlite3_exec(database, [sql UTF8String] , NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error insert maintain record");
        sqlite3_close(database);
    }
    NSLog(@"insertmaintainRecord id:%ld name:%@ cost:%f date:%@",record.item_id,record.itemname,record.cost1,record.date);
}

-(void)insertRespairRecord:(RespairItem *)rItem
{                                                              //      RESPAIR_TABLE
    NSString *insertSql=[[NSString alloc] initWithFormat:@"INSERT INTO RESPAIR_TABLE(CAR_ID ,NAMES,MILES ,COST, DATE ) VALUES(%ld,'%@',%ld,%f,'%@');",
                         rItem.carId,rItem.names,rItem.miles,rItem.cost,rItem.date];
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
    
     NSLog(@"insertRespairRecord is worked. carId=%ld",currentCar.car_id);    
}


-(void) insertFuelingRecord:(FuelingItem *)fItem
{
    //OIL_VOLUME ,OIL_COST,LAST_LEFT_VOLUME , CURRENT_MILES , DATE,AV_OIL,AV_COST,ADD_MILES
    
    NSString *insertSql=[[NSString alloc] initWithFormat:@"INSERT INTO FUELING_TABLE(CAR_ID ,OIL_VOLUME ,OIL_COST,LAST_LEFT_VOLUME , CURRENT_MILES , DATE,AV_OIL,AV_COST,ADD_MILES ) VALUES(%ld,%f,%f,%f,%ld,'%@',%f,%f,%ld);",
                         fItem.carId,fItem.volume,fItem.cost,fItem.leftVol,fItem.miles,fItem.date,fItem.avOil,fItem.avCost,fItem.addMiles];
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
     NSLog(@"insertFuelingRecord is worked. carId=%ld",currentCar.car_id); 
    
    
}

-(void) updateFuelingRecord:(FuelingItem *)fItem
{
    NSString *insertSql=[[NSString alloc] initWithFormat:@"UPDATE FUELING_TABLE SET AV_OIL=%f,AV_COST=%f,ADD_MILES=%ld where CAR_ID=%ld and  CURRENT_MILES=%d;",
                         fItem.avOil,fItem.avCost,fItem.addMiles,currentCar.car_id,fItem.miles];
    // sqlite3_stmt *statement;
    if(sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, NULL)!=SQLITE_OK)
    {
        NSLog(@"error upate fueling record!");
        sqlite3_close(database);
    }
    NSLog(@"updateFuelingRecord is worked. carId=%ld",currentCar.car_id); 

}

-(BOOL) checkFuelingMiles:(NSInteger)miles
{
    NSString *sql=[[NSString alloc] initWithFormat:@"select  CURRENT_MILES   FROM FUELING_TABLE  WHERE  CURRENT_MILES=%ld ",miles];
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

-(IBAction)loadMaintainItemInitView:(id)sender
{
    
    [maintainItemSetScrollView setContentSize:CGSizeMake(self.screenWidth-10, 900)];
    [maintainItemSetScrollView setContentOffset:CGPointMake(0, 0)];
    
    CGRect frame=maintainItemInitView.frame;
    if (addMaintainItemName.tag==0) {
        // maintain item init set.
        addMaintainItemName.hidden=YES;
        MaintainItem *item=[self.maintainItems objectAtIndex:itemInitItemName.tag ];
      //  itemInitItemName.tag=index;
        NSString *str=[NSString stringWithFormat:@"%@\n%@",item.itemName,[self.itemDetails objectAtIndex:item.itemId-1]];
        
        [itemInitItemName setText:str];
        NSLog(@"%@",str);
        [itemInitItemName sizeToFit];
        [maintainItemInitView setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 360+itemInitItemName.frame.size.width)];
    }else{
        // add maintain item.
        [itemInitItemName setText:@"名称"];
        [maintainItemInitView setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 360)];
        
    }
    
    [itemInitLatestMaintainMiles setText:@""];
    [itemInitMaintainLifeMiles setText:@""];
    [itemInitLatestMaintainDate setText:@""];
    [itemInitLatestMaintainDateDiv setText:@""];
    
    [UIView animateWithDuration:1.0 animations:^{
        maintainItemInitView.center=CGPointMake(maintainItemInitView.center.x+self.screenWidth, maintainItemInitView.center.y);
    }];
    
}

-(IBAction)finishMaintainItemInitialization:(id)sender
{
    
    NSInteger latestMaintainMiles=[[itemInitLatestMaintainMiles.text stringByReplacingOccurrencesOfString:@"," withString:@""] intValue];
    NSInteger lifeMiles=[[itemInitMaintainLifeMiles.text stringByReplacingOccurrencesOfString:@"," withString:@""] intValue];
    if ((latestMaintainMiles+lifeMiles)>0 &&latestMaintainMiles*lifeMiles==0) {
        [self showNotification:@"里程保养数据有误！"];
        return;
    }
    CGFloat intervalYear=[itemInitLatestMaintainDateDiv.text floatValue];
    NSString *date=itemInitLatestMaintainDate.text;
    if (intervalYear>0 && [date isEqualToString:@""]) {
        [self showNotification:@"时间保养数据有误！"];
        return;
    }
    //return view.
    [UIView animateWithDuration:1.0 animations:^{
        maintainItemInitView.center=CGPointMake(maintainItemInitView.center.x-self.screenWidth, maintainItemInitView.center.y);
    }];
    [itemInitLatestMaintainMiles resignFirstResponder];
    [itemInitMaintainLifeMiles resignFirstResponder];
    [itemInitLatestMaintainDate resignFirstResponder];
    [itemInitLatestMaintainDateDiv resignFirstResponder];
    
    MaintainItem *item;
    if (addMaintainItemName.tag==0) {
        // init maintain item
        item=[self.maintainItems objectAtIndex:itemInitItemName.tag];
        [item editItemWithCurrentMiles:self.currentCar.currentMiles LatestMaintainMiles:latestMaintainMiles  LifeMiles:lifeMiles  latestDate:date DateLife:intervalYear*12];
        [self updateSignalMaintainItemWithMaintianItem:item];
        [self.tracingCarViewController.maintainItemsTable reloadData];
        
    } else{
        // add new maintain item.
        NSInteger itemId=[self.personalCenterViewController.carManageViewController. editingCarMaintainItems count]+21;
        item=[[MaintainItem alloc] initWithCarId:self.personalCenterViewController.carManageViewController.editCar.car_id ItemId:itemId itemName:addMaintainItemName.text lifeMiles:lifeMiles latestMaintinMiles:latestMaintainMiles leftPercent:100 leftMiles:lifeMiles APPLYMARK:1];
        [item editItemWithCurrentMiles:self.currentCar.currentMiles LatestMaintainMiles:latestMaintainMiles  LifeMiles:lifeMiles  latestDate:date DateLife:intervalYear*12];
        [self insertMaintainItem:item];
        [self.personalCenterViewController.carManageViewController. editingCarMaintainItems addObject:item];
        [self.personalCenterViewController.carManageViewController.maintainItemsTable reloadData];
        
        
    }
 
    
}

-(BOOL)showMaintainItemInitView
{
    if (maintainItemInitView.center.x>0) {
        return TRUE;
    } else return FALSE;
}

-(BOOL)showCarsTableView
{
    
    return  [carsTableView isVisible] ;
}

-(IBAction)returnMaintainItemInitView:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        maintainItemInitView.center=CGPointMake(maintainItemInitView.center.x-self.screenWidth, maintainItemInitView.center.y);
    }];
}

-(void) loadCarsTableView
{
    [self.window addSubview:carsTableView.view];
    carsTableView.view.tag=1;
   // [titleView setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner_up.png"]]];
    [carsTableView refreshCarsTableView];
    [carsTableView.table reloadData];
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
                

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   // self.currentCar=[[Car alloc] init];
    garage=[[Garage alloc] init];
    [self legalNumberFormatter];
    [self initDataBase];
    [self initBrandDictionary];
      
    [self initGlobalData];
    
    //get screen size.
    CGRect rect=[[UIScreen mainScreen] bounds];
    screenWidth=rect.size.width;
    screenHeight=rect.size.height;
    
 //   memberType=2;
    oilPrice=5.21;
    self.tracingCarViewController = [[TracingCarViewController alloc] initWithNibName:@"TracingCarViewController" bundle:nil] ;
    self.loginViewController=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.personalCenterViewController=[[PersonalCenterViewController alloc] initWithNibName:@"PersonalCenterViewController" bundle:nil];
    tracingCarViewController.title=@"汽车云管理";
    navigationController=[[UINavigationController alloc] init];
    leftNavigationController=[[UINavigationController alloc] init];
    
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
  //  leftNavigationController.navigationBar.hidden=YES;
    
    
    
    [self.window addSubview:navigationController.view];
    [self.window insertSubview:leftNavigationController.view belowSubview:navigationController.view];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //concerned share views
    notificationInfo=[[NotificationLabel alloc] initWithFrame:CGRectMake(0, screenHeight-100, 100, 40)];
    [notificationInfo setRootView:self.window];
    spinnerView=[[SpinnerViewController alloc] init];
    
    //maintian item init set view
    NSArray *nibView=[[NSBundle mainBundle] loadNibNamed:@"maintainItemSetView" owner:self options:nil];
    maintainItemInitView=[nibView objectAtIndex:0];
    maintainItemInitView.frame=CGRectMake(-self.screenWidth+5, 64, self.screenWidth-10, self.screenHeight-100);
    [self.window addSubview:maintainItemInitView];
    [maintainItemSetScrollView setContentSize:CGSizeMake(self.screenWidth-10, 900)];
    [addMaintainItemName setTintColor:[UIColor whiteColor]];
    [itemInitLatestMaintainMiles setTintColor:[UIColor whiteColor]];
    [itemInitMaintainLifeMiles setTintColor:[UIColor whiteColor]];
    [itemInitLatestMaintainDate setTintColor:[UIColor whiteColor]];
    [itemInitLatestMaintainDateDiv setTintColor:[UIColor whiteColor]];
    
    
    
 
    
     
    //get register info.
    /*
    NSData *data=[[NSMutableData alloc] initWithContentsOfFile:[self archiveFilePath]];
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    currentCarId=[unarchiver decodeIntForKey:kCarIdKey];
  //  ownerTel=[unarchiver decodeObjectForKey:@"Owner"];
    [unarchiver finishDecoding]; */
    defaults=[NSUserDefaults standardUserDefaults];
    
    if (![@"YES" isEqualToString:[defaults stringForKey:@"isFirstLoad"]]) {
        [self showWelcomeView];
    }
    
    ownerTel=[defaults stringForKey:@"owner"];
    memberType=[defaults integerForKey:@"memberType"];
    currentCarId=[defaults integerForKey:@"currrentCarId"];
    NSLog(@"+++++++++++++++owner=%@,  memberType=%i, currentCarId=%i",ownerTel,memberType,currentCarId);
    /*
    if(ownerTel==nil ||[ownerTel isEqualToString:@""])
    {
        ownerTel=@"none";
        [navigationController pushViewController:loginViewController animated:NO];        
        
    } else
    {
         [self getAllCars];
        if ([cars count]>0) {
            [self.tracingCarViewController refreshView];
        }else   [self.tracingCarViewController showRegisterNewCar];
    } */
    
    [self getAllCars];
    if ([cars count]>0) {
        [self.tracingCarViewController refreshView];
    }else   [self.tracingCarViewController showRegisterNewCar];
    
    
    //carsTable.
    carsTableView=[[CarsTableView alloc] initWithPlot:0 AppDelegate:self];
    
    //微信注册    wx7acf62724b9dcb00        wxbe41ebca760466e
    [WXApi registerApp:@"wx7acf62724b9dcb00"];
    
    getDataFromCloud=FALSE;
    
    [self getUsefulInfo];
    
    
      [self.window makeKeyAndVisible];
    
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
    SendMessageToWXReq *req=[[SendMessageToWXReq alloc] init];
    req.text=msg;
    req.bText=YES;
   // req.scene=_scene;
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
    NSLog(@"login with owner:%@",tel);
    [defaults setObject:tel forKey:@"owner"];
    ownerTel=[NSString stringWithFormat:@"%@",tel];
    [defaults setInteger:type forKey:@"memberType"];
    memberType=type;
    NSDate *sendDate=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *date=[dateFormatter stringFromDate:sendDate];    
    
    [defaults setObject:date forKey:@"loginDate"];
    [defaults synchronize];
    /*
    [defaults setObject:garage.name forKey:@"garageName"];
    [defaults setObject:garage.tel forKey:@"garageTel"];
    [defaults setObject:garage.addr forKey:@"garageAddr"];
     */
    
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
    numberFormatter=[NSNumberFormatter new];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text=[textField.text stringByReplacingCharactersInRange:range withString:string ];
    text=[text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumber *number=[NSNumber numberWithInt:[text intValue]];
    [textField setText:[numberFormatter stringFromNumber:number] ];
    return NO;
}

-(NSString*) dataToCloud
{
    NSDictionary *dictionary;
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    NSString *car_id,*item_id,*name,*lifeMiles,*leftPercent,*latestMiles;
    for(MaintainItem *item in maintainItems)
    {
        car_id=[NSString stringWithFormat:@"%i",currentCar.car_id];
        item_id=[NSString stringWithFormat:@"%ld",item.itemId];
        name=item.itemName;
        lifeMiles=[NSString stringWithFormat:@"%ld",item.lifeMiles];
        leftPercent=[NSString stringWithFormat:@"%ld",item.leftPercent];
        latestMiles=[NSString stringWithFormat:@"%ld",item.latestMaintainMiles];
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
    post=[NSString stringWithFormat:@"ownerTel=%@&code=%ld&license=%@&brand=%@&color=%@&current_miles=%ld&init_miles=%ld&oilbox_volume=%f&total_oilvolume=%f&total_fuelingcost=%f&fueling_info=%@&flag=%ld",ownerTel,aCar.car_id,aCar.license,aCar.brandName,@"color",aCar.currentMiles,aCar.initMiles,aCar.oilBoxVolume,aCar.totalOilConsumption,aCar.totalOilCost,aCar.fuelingInfo,1];
    NSLog(@"post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
        dictionary=[[NSDictionary alloc] initWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%ld",item.carId],@"car_code",aCar.license,@"car_license",[NSString stringWithFormat:@"%ld",item.itemId],@"id",item.itemName,@"itemname"
                    ,[NSString stringWithFormat:@"%ld",item.leftMiles],@"safemiles",[NSString stringWithFormat:@"%ld",item.leftTime],@"leftdays",
                    [NSString stringWithFormat:@"%ld",item.lifeMiles],@"lifemiles",[NSString stringWithFormat:@"%ld",item.lifeTime],@"intervalyear",[NSString stringWithFormat:@"%ld",item.leftPercent],@"leftpercent",[NSString stringWithFormat:@"%ld",item.timeLeftPercent],@"timeleftpercent",[NSString stringWithFormat:@"%ld",item.latestMaintainMiles],@"latestupdatedmiles",item.latestMaintainDate,@"latestupdateddate",[NSString stringWithFormat:@"%ld",item.applyMark],@"applymark",nil];
        /*
         
         */
    //    dictionary=[NSDictionary dictionaryWithObjectsAndKeys:ownerTel,@"owner",item.carId,@"car_code",aCar.license,@"car_license",item.itemId,"id",item.itemName,@"itemname",item.leftMiles,@"safemiles",item.leftTime,@"leftdays",item.lifeMiles,@"lifemiles",item.lifeTime,@"intervalyear",item.leftPercent,@"leftpercent",item.timeLeftPercent,@"timeleftpercent",item.latestMaintainMiles,@"latestupdatedmiles",item.latestMaintainDate,@"latestupdateddate", nil];
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
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
        dictionary=[[NSDictionary alloc] initWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%ld",aCar.car_id],@"car_code",aCar.license,@"car_license",[NSString stringWithFormat:@"%ld",record.item_id],@"item_id",record.itemname,@"itemname"
                    ,[NSString stringWithFormat:@"%ld",record.maintainMiles],@"miles",[NSString stringWithFormat:@"%ld",record.lifeMiles],@"lifemiles",
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
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
    dictionary=[[NSDictionary alloc] initWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%ld",aCar.car_id],@"car_code",aCar.license,@"car_license",[NSString stringWithFormat:@"%f",item.volume],@"volume",[NSString stringWithFormat:@"%f",item.cost],@"cost"
                ,[NSString stringWithFormat:@"%ld",item.miles],@"miles",[NSString stringWithFormat:@"%ld",item.addMiles],@"add_miles",
                [NSString stringWithFormat:@"%f",item.avCost],@"avcost",[NSString stringWithFormat:@"%f",item.avOil],@"avoil",item.date,@"date",nil];
    
    [arr addObject:dictionary];

    NSError *error=nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // commit jsoninfo to cloud.
    
    NSURL *url=[NSURL URLWithString:@"http://www.qcygl.com/postFuelingInfo.php"];
    NSString *post=nil;
    post=[NSString stringWithFormat:@"fuelingjson=%@",jsonString];
    NSLog(@"post:%@",post);
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
    post=[NSString stringWithFormat:@"owner=%@&car_code=%ld&car_license=%@&item=%@&cost=%f&miles=%ld&date=%@&note=%@",ownerTel,aCar.car_id,aCar.license,item.names,item.cost,item.miles,item.date,@"**"];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%ld",[postData length]];
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
        car_id=[NSString stringWithFormat:@"%ld",car.car_id];
        current_miles=[NSString stringWithFormat:@"%ld",car.currentMiles];
        init_miles=[NSString stringWithFormat:@"%ld",car.initMiles];
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
            dictionary=[NSDictionary dictionaryWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%ld",car_id] ,@"car_code",[NSString stringWithFormat:@"%f",volume], @"volume",[NSString stringWithFormat:@"%f",cost],@"cost",[NSString stringWithFormat:@"%ld",miles],@"miles",date,@"date", nil];
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
    /*
     NSString *sql=[[NSString alloc] initWithFormat:@"select NAMES ,COST , DATE,MILES  FROM RESPAIR_TABLE WHERE CAR_ID=%ld ORDER BY DATE DESC ",currentCar.car_id];
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
     cost=sqlite3_column_double(statement, 1);
     str=(char*)sqlite3_column_text(statement, 2);
     date=[[NSString alloc] initWithUTF8String:str];
     miles=sqlite3_column_int(statement, 3);
     item=[[RespairItem alloc] initWithNames:names Miles:miles Cost:cost Date:date];
     [respairItems addObject:item];
     
     }
     }else
     
    */
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
            dictionary=[NSDictionary dictionaryWithObjectsAndKeys:ownerTel,@"owner",[NSString stringWithFormat:@"%ld",car_id] ,@"car_code",names, @"item",[NSString stringWithFormat:@"%f",cost],@"cost",[NSString stringWithFormat:@"%ld",miles],@"miles",date,@"date", nil];
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
}

-(void) showNotification:(NSString *)info
{
    [notificationInfo showNotificationWithStr:info];
}

-(void) dataToView
{
    NSLog(@"dataToView cars count:%ld",[cars count]);
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
            if ([array1 count]<2) {
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
            
            /*
            NSString *s1,*t1,*t2;
            NSRange range1;
            range1=[reponseString rangeOfString:@"['"];
            city=[reponseString substringFromIndex:range1.location+2];
            range1=[city rangeOfString:@"']"];
            city=[city substringToIndex:range1.location];
            
            
            range1=[reponseString rangeOfString:@"[{"];
            
            weatherInfo=[reponseString substringFromIndex:range1.location+1];
            range1=[weatherInfo rangeOfString:@"}]"];
            weatherInfo=[weatherInfo substringToIndex:range1.location+1];
     //       NSLog(@"city:%@  weather info:%@",city,weatherInfo);
            
            // get info
         //   range1=[weatherInfo rangeOfString:@"'"];
            weatherInfo=[weatherInfo substringFromIndex:5];
         //   NSLog(@"raw s1:%@",weatherInfo);
            range1=[weatherInfo rangeOfString:@"'"];
            s1=[weatherInfo substringToIndex:range1.location];
            
            // get tempture1
            range1=[weatherInfo rangeOfString:@"t1"];
            weatherInfo=[weatherInfo substringFromIndex:range1.location+1];
            range1=[weatherInfo rangeOfString:@"'"];
            weatherInfo=[weatherInfo substringFromIndex:range1.location+1];
            range1=[weatherInfo rangeOfString:@"'"];
            t1=[weatherInfo substringToIndex:range1.location];
            
            // get tempture2
            range1=[weatherInfo rangeOfString:@"t2"];
            weatherInfo=[weatherInfo substringFromIndex:range1.location+1];
            range1=[weatherInfo rangeOfString:@"'"];
            weatherInfo=[weatherInfo substringFromIndex:range1.location+1];
            range1=[weatherInfo rangeOfString:@"'"];
            t2=[weatherInfo substringToIndex:range1.location];
            //32℃/27℃
            weatherInfo=[NSString stringWithFormat:@"%@ %@℃~%@℃",s1,t1,t2];
             */
            // get carlimit info.
            NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps;
            NSInteger unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
            NSDate *now=[NSDate date];
            comps=[calendar components:unitFlags fromDate:now];
            NSInteger week,day,diffWeeks,number1,number2;
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
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
                    dateInfo=@"星期日";
                    break;
                    
                default:
                    break;
            }
            
            if (week==0|| week==6) {
                carLimitInfo=@"不限";
            }else if ([city isEqualToString:@"北京"]) {
                
                NSDate *fDate=[dateFormatter dateFromString:@"2015/01/11"];
                NSDateComponents *comps1=[calendar components:NSCalendarUnitDay fromDate:fDate toDate:now options:0];
                day=[comps1 day];
                diffWeeks=day/(7*13);
                number1=(week+1+diffWeeks*5)%6;
                number2=(number1+5)%10;
          //      NSLog(@"北京限号 %ld,%ld",number1,number2);
             //   return [NSString stringWithFormat:@"限:%ld %ld",number1,number2];
                carLimitInfo=[NSString stringWithFormat:@"限:%ld %ld",number1,number2];
            } else if([city isEqualToString:@"长春"]){
              //  return [NSString stringWithFormat:@"限:%ld ",day%10];
                carLimitInfo=[NSString stringWithFormat:@"限:%ld ",day%10];
            }
         //   [self.tracingCarViewController startMoveLabel:[NSString stringWithFormat:@"%@ %@ %@ %@ %@",[dateFormatter stringFromDate:now],dateInfo ,city,weatherInfo,carLimitInfo]];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
            //    NSTimer *aTimer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(testTimer) userInfo:nil repeats:YES];
                [self.tracingCarViewController startMoveLabel:[NSString stringWithFormat:@"%@ %@ %@ %@ %@",[dateFormatter stringFromDate:now],dateInfo ,city,weatherInfo,carLimitInfo]];
                

            });
            
        }
        else {
            [self.tracingCarViewController startMoveLabel:@"网络有误，无法读取天气，限行信息"];
            NSLog(@"post error!");
        }
    }];

    
}

-(void) testTimer
{
    NSLog(@"appdelegate test Timer.");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error=nil;    
    
     NSString *reponseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"get weather successful result:%@",reponseString);
    NSDictionary *rootDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];      
    NSDictionary *weatherData=[rootDic objectForKey:@"weatherinfo"];
    weatherInfo=[NSString stringWithFormat:@"%@ %@~%@",[weatherData objectForKey:@"weather"],[weatherData objectForKey:@"temp1"],[weatherData objectForKey:@"temp2"]];
    [self.tracingCarViewController startMoveLabel:weatherInfo];
    NSLog(@"%@",weatherInfo);
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




@end
