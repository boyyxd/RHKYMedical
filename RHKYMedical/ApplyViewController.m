//
//  ApplyViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/17.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "ApplyViewController.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import "JSONKit.h"
#import "UrlFile.h"
#import "JSONKit.h"

@interface ApplyViewController ()
{
    UIDatePicker *timePicker;
    NSMutableArray *paiBanArray;
    UIPickerView *paiBanPickerView;
    MBProgressHUD *HUD;
    NSString *scheduleIdStr;
}
@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.okButton.layer.cornerRadius = 5;
    //textField右视图
    UIImageView *rightView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.chooseTimeTextField.frame.size.height, self.chooseTimeTextField.frame.size.height)];
    rightView1.image = [UIImage imageNamed:@"下拉1"];
    self.chooseTimeTextField.rightViewMode = UITextFieldViewModeAlways;
    self.chooseTimeTextField.rightView = rightView1;
    
    UIImageView *rightView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.choosePaiBanTextField.frame.size.height, self.choosePaiBanTextField.frame.size.height)];
    rightView2.image = [UIImage imageNamed:@"下拉1"];
    self.choosePaiBanTextField.rightViewMode = UITextFieldViewModeAlways;
    self.choosePaiBanTextField.rightView = rightView2;
    
    //
    self.chooseTimeTextField.delegate = self;
    self.choosePaiBanTextField.delegate = self;
    
    
    // 创建datapikcer
    timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];;
    
    // 本地化
    timePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    
    // 日期控件格式
    timePicker.datePickerMode = UIDatePickerModeDate;
    
    // 设置textfield的键盘
    self.chooseTimeTextField.inputView = timePicker;
    [timePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    
    paiBanPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];
    // 显示选中框
    paiBanPickerView.showsSelectionIndicator=YES;
    paiBanPickerView.dataSource = self;
    paiBanPickerView.delegate = self;
    [paiBanPickerView reloadAllComponents];//刷新UIPickerView
    paiBanPickerView.showsSelectionIndicator=YES;
    self.choosePaiBanTextField.inputView = paiBanPickerView;
    
    HUD = [[MBProgressHUD alloc]init];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
}

- (void)getOpschedule{
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"排班信息获取中";
    [HUD  show:YES];
    
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
    NSLog(@"userDic=%@",userDic);
    NSString * departmentCode = [userDic objectForKey:@"department_code"];
    NSString * token = [userDic objectForKey:@"token"];

    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:departmentCode,@"department_code",self.chooseTimeTextField.text,@"operation_time",token,@"token",nil];
//    NSString * postStr = [postDic JSONString];
    
    //iOS9 af请求新用法
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager POST:Opschedule_URL parameters:postDic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HUD hide:YES afterDelay:0.3];
        NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
        NSMutableArray *responseObjectArray = [[responseObjectDic objectForKey:@"body"]objectForKey:@"datalist"];
        NSLog(@"str----------%@/n%@",responseObjectDic,responseObjectArray);
        paiBanArray = responseObjectArray;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD hide:YES afterDelay:1.5];
        NSLog(@"%@",error);
    }];

}

-(void)dateChanged:(id)sender{
    NSString *timeStr = [self stringFromDate:timePicker.date];
    self.chooseTimeTextField.text = timeStr;
    [self getOpschedule];
}

//data转string
- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [paiBanArray count];
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.0f;
}
//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.view.frame.size.width;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == paiBanPickerView) {
        NSString *str = [NSString stringWithFormat:@"%@",[[paiBanArray objectAtIndex:row]objectForKey:@"operation_name"]];
        return str;
    }
    else
        return nil;
    
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == paiBanPickerView) {
        self.choosePaiBanTextField.text = [NSString stringWithFormat:@"%@",[[paiBanArray objectAtIndex:row]objectForKey:@"operation_name"]];
        scheduleIdStr = [NSString stringWithFormat:@"%@",[[paiBanArray objectAtIndex:row]objectForKey:@"schedule_id"]];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.chooseTimeTextField) {
        NSString *timeStr = [self stringFromDate:timePicker.date];
        self.chooseTimeTextField.text = timeStr;
    }
    if (textField == self.choosePaiBanTextField && [self.choosePaiBanTextField.text isEqualToString:@""]) {
        self.choosePaiBanTextField.text = [NSString stringWithFormat:@"%@", [[paiBanArray objectAtIndex:0]objectForKey:@"operation_name"]];
        scheduleIdStr = [NSString stringWithFormat:@"%@",[[paiBanArray objectAtIndex:0]objectForKey:@"schedule_id"]];
    }
    return YES;
}

//回车回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

- (IBAction)chooseTimeAction:(id)sender {
    [self.chooseTimeTextField becomeFirstResponder];
}

- (IBAction)choosePaiBanAction:(id)sender {
    if ([self.chooseTimeTextField.text isEqualToString:@""]) {
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"请先选择手术日期";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1.5];
    }else{
        NSLog(@"count=%lu",(unsigned long)paiBanArray.count);
        if (paiBanArray.count > 0) {
            [self.choosePaiBanTextField becomeFirstResponder];
        }
        else{
            self.choosePaiBanTextField.text = @"";
            HUD.mode= MBProgressHUDModeText;
            HUD.labelText = @"该时间段内没有手术安排";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1.5];
        }
    }
    
    
}
- (IBAction)okAction:(id)sender {
    [self.chooseTimeTextField resignFirstResponder];
    [self.choosePaiBanTextField resignFirstResponder];
    if ([self.chooseTimeTextField.text isEqualToString:@""]||
        [self.choosePaiBanTextField.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择手术日期和排班信息" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //取消按钮
        }];
        [alertController addAction:okAction];
        // 将UIAlertController模态出来 相当于UIAlertView show 的方法
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
        NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
        NSString * userid = [userDic objectForKey:@"qr_code"];
        NSString * token = [userDic objectForKey:@"token"];
        
        
        NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"userid",token,@"token",scheduleIdStr,@"schedule_id",nil];
        NSLog(@"userDic=%@",postDic);

        //iOS9 af请求新用法
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [sessionManager POST:SUBMIT_APPLY_URL parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
            NSLog(@"===%@",responseObjectDic);
            NSString *str = [NSString stringWithFormat:@"%@",[[responseObjectDic objectForKey:@"header"]objectForKey:@"result"]];

            if ([str isEqualToString:@"1"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功！" preferredStyle:(UIAlertControllerStyleAlert)];
                
                // 创建按钮
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //返回按钮
                }];
                [alertController addAction:okAction];
                // 将UIAlertController模态出来 相当于UIAlertView show 的方法
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                HUD.mode= MBProgressHUDModeText;
                HUD.labelText = @"提交失败，请重试";
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
}

- (IBAction)tapBackKeyBoardAction:(id)sender {
    [self.chooseTimeTextField resignFirstResponder];
    [self.choosePaiBanTextField resignFirstResponder];
    
}

@end
