//
//  LookOperationViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/17.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "LookOperationViewController.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import "JSONKit.h"
#import "UrlFile.h"
#import "MJRefresh.h"
#import "LookOperationDetailsViewController.h"
#import "OperationTableViewCell.h"


@interface LookOperationViewController ()
{
    NSArray *numberArray;
//    NSArray *detailsArray1;
//    NSArray *detailsArray2;
//    NSArray *detailsArray3;
//    NSArray *detailsArray4;
//    NSArray *detailsArray5;
//    NSArray *detailsArray6;
//    NSArray *detailsArray7;
//    NSArray *detailsArray8;
//    NSArray *detailsArray9;
//    NSArray *detailsArray10;
//    NSArray *detailsArray11;
//    NSArray *detailsArray12;
//    NSArray *detailsArray13;
//    NSArray *detailsArray14;
//    NSArray *detailsArray15;
//    NSArray *detailsArray16;
    LookOperationDetailsViewController *lookOperationDetailsViewController;
    NSInteger arrayCount;
    MBProgressHUD *HUD;
}
@end

@implementation LookOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    detailsArray1 = [NSArray arrayWithObjects:@"1",@"2016-03-10",@"位置1",@"3",@"张一某", nil];
//    detailsArray2 = [NSArray arrayWithObjects:@"2",@"2016-03-11",@"位置2",@"6",@"张二某", nil];
//    detailsArray3 = [NSArray arrayWithObjects:@"3",@"2016-03-12",@"位置5",@"15",@"张三某", nil];
//    detailsArray4 = [NSArray arrayWithObjects:@"4",@"2016-03-13",@"位置2",@"4",@"张四某", nil];
//    detailsArray5 = [NSArray arrayWithObjects:@"5",@"2016-03-14",@"位置4",@"8",@"张一", nil];
//    detailsArray6 = [NSArray arrayWithObjects:@"6",@"2016-04-16",@"位置3",@"10",@"张二", nil];
//    detailsArray7 = [NSArray arrayWithObjects:@"7",@"2016-04-19",@"位置3",@"11",@"张三", nil];
//    detailsArray8 = [NSArray arrayWithObjects:@"8",@"2016-05-20",@"位置6",@"5",@"李一某", nil];
//    detailsArray9 = [NSArray arrayWithObjects:@"9",@"2016-05-22",@"位置3",@"9",@"李二某", nil];
//    detailsArray10 = [NSArray arrayWithObjects:@"10",@"2016-06-10",@"位置1",@"8",@"李三某", nil];
//    detailsArray11 = [NSArray arrayWithObjects:@"11",@"2016-07-01",@"位置5",@"6",@"李四某", nil];
//    detailsArray12 = [NSArray arrayWithObjects:@"12",@"2016-08-10",@"位置7",@"5",@"赵一", nil];
//    detailsArray13 = [NSArray arrayWithObjects:@"13",@"2016-09-15",@"位置7",@"4",@"杨五", nil];
//    detailsArray14 = [NSArray arrayWithObjects:@"14",@"2016-09-21",@"位置2",@"3",@"杨七七", nil];
//    detailsArray15 = [NSArray arrayWithObjects:@"15",@"2016-10-07",@"位置4",@"7",@"王二小", nil];
//    detailsArray16 = [NSArray arrayWithObjects:@"16",@"2016-11-17",@"位置1",@"5",@"王大", nil];
//    numberArray = [NSArray arrayWithObjects:detailsArray1,detailsArray2,detailsArray3,detailsArray4,detailsArray5,detailsArray6,detailsArray7,detailsArray8,detailsArray9,detailsArray10,detailsArray11,detailsArray12,detailsArray13,detailsArray14,detailsArray15,detailsArray16,detailsArray1,detailsArray2,detailsArray3,detailsArray4,detailsArray5,detailsArray6,detailsArray7,detailsArray8,detailsArray9,detailsArray10,detailsArray11,detailsArray12,detailsArray13,detailsArray14,detailsArray15,detailsArray16, nil];
    
    [self getList];
    
    self.operationTableView.delegate = self;
    self.operationTableView.dataSource = self;
    
    HUD = [[MBProgressHUD alloc]init];
    [self.view addSubview:HUD];
    HUD.delegate = self;
}

- (void)getList{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
    NSString * userid = [userDic objectForKey:@"qr_code"];
    NSString * token = [userDic objectForKey:@"token"];
    
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",@"2",@"page_no",token,@"token",nil];
    NSLog(@"userDic=%@",postDic);
    
    //iOS9 af请求新用法
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager POST:Operation_URL parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
        NSLog(@"===%@",responseObjectDic);
        NSString *str = [NSString stringWithFormat:@"%@",[[responseObjectDic objectForKey:@"header"]objectForKey:@"result"]];
        
        NSArray *applyListArray = [[responseObjectDic objectForKey:@"body"]objectForKey:@"datalist"];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:applyListArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"operationList"];
        
        if ([str isEqualToString:@"1"]) {
            HUD.mode= MBProgressHUDModeText;

            if (applyListArray.count == 0) {
                HUD.labelText = @"没有手术安排";
                [HUD show:YES];
                [HUD hide:YES afterDelay:1.5];
            }
            else{
            
                HUD.labelText = [NSString stringWithFormat:@"数据获取成功:共%ld条",applyListArray.count];
                [HUD show:YES];
                [HUD hide:YES afterDelay:1.5];

            }
            [self.operationTableView reloadData];


        }else{
            
            HUD.mode= MBProgressHUDModeText;
            HUD.labelText = @"数据获取失败";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1.5];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1.5];
        NSLog(@"%@",error);
        
    }];

}

#pragma -------tableview--------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"operationList"];
    numberArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%lu",numberArray.count);
    return numberArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * detailsCell = @"cell";
    
    OperationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailsCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OperationTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"operationList"];
    numberArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    cell.RankLabel.text = [NSString stringWithFormat:@"%@",[numberArray[indexPath.row] objectForKey:@"operation_name"]];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",[numberArray[indexPath.row] objectForKey:@"op_datetime"]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"operationList"];
    numberArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    lookOperationDetailsViewController = [[LookOperationDetailsViewController alloc]initWithNibName:@"LookOperationDetailsViewController" bundle:nil];
    lookOperationDetailsViewController.detailsDic = [numberArray objectAtIndex:indexPath.row];
    [self showViewController:lookOperationDetailsViewController sender:nil];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma -------tableview-----end--------

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

@end
