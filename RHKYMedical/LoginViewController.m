//
//  LoginViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/16.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "JSONKit.h"
#import "AFHTTPSessionManager.h"
#import "AFURLSessionManager.h"
#import "UrlFile.h"

@interface LoginViewController ()
{
    MBProgressHUD *HUD;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.passwordTextField.secureTextEntry=YES;//开启密码隐藏
    self.registerButton.layer.cornerRadius = 5;
    self.loginButton.layer.cornerRadius = 5;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated{
    if (self.login == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//回车回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//编码  URLEncodedString
//-(NSString *)URLEncodedString:(NSString *)str
//{
//    NSString *encodedString = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                              (CFStringRef)str,
//                                                              NULL,
//                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                              kCFStringEncodingUTF8));
//    
//    return encodedString;
//}

//解码  URLDecodedString
//-(NSString *)URLDecodedString:(NSString *)str
//{
//    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//    
//    return decodedString;
//}

//登录
- (IBAction)loginAction:(id)sender {
    if ([self.nameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"工号或密码不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //取消按钮
        }];
        [alertController addAction:okAction];
        // 将UIAlertController模态出来 相当于UIAlertView show 的方法
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"登录中";
        [HUD  show:YES];
        
        NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:self.nameTextField.text,@"username",self.passwordTextField.text,@"password",@"asdfgh",@"clientid",@"1",@"mobiletype",nil];
        
//        NSString * postStr = [postDic JSONString];
//
//        NSString *postStr1 = [postStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        
//        NSString *postStr2 = @"{\"username\":\"zhangsan\", \"password\":\"123456\",\"clientid\":\"asdfgh\", \"mobiletype\":\"0\"}";
        
//        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
//        
//        NSLog(@"postStr=%@\npostStr1=%@\npostStr2=%@",postStr,postStr1,postStr2 );
        
//        NSDictionary *postDic1 = [NSDictionary dictionaryWithObjectsAndKeys:postStr,@"json",nil];
        
        //iOS9 af请求新用法
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        sessionManager.requestSerializer.timeoutInterval = 15;
//        [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [sessionManager POST:LOGIN_URL parameters:postDic  progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [HUD hide:YES];
            NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
            
            NSLog(@"str----------%@/n%@",responseObjectDic,[[responseObjectDic objectForKey:@"header"]objectForKey:@"result"]);
        
            //保存登录获取的用户数据
            NSDictionary * userDic = [[responseObjectDic objectForKey:@"body"] objectForKey:@"data"] ;
            
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:userDic];
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userData"];
            
            NSString *str = [NSString stringWithFormat:@"%@",[[responseObjectDic objectForKey:@"header"]objectForKey:@"result"]];
            NSString *code = [NSString stringWithFormat:@"%@",[[responseObjectDic objectForKey:@"header"]objectForKey:@"code"]];
            
            if ([str isEqualToString:@"1"]) {
                [self dismissViewControllerAnimated:YES completion:nil];
                HUD.mode= MBProgressHUDModeText;
                HUD.labelText = @"登录成功";
                [HUD hide:YES afterDelay:1.5];
            }else{

                if([code isEqualToString:@"4"]||[code isEqualToString:@"6"] || [code isEqualToString:@"10"]){
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"工号或密码错误" preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    // 创建按钮
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //取消按钮
                        self.nameTextField.text = nil;
                        self.passwordTextField.text = nil;
                    }];
                    [alertController addAction:okAction];
                    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                
                else if([code isEqualToString:@"7"]){
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"需要单位Code的操作,单位未找到" preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    // 创建按钮
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //取消按钮
                        
                    }];
                    [alertController addAction:okAction];
                    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                else if([code isEqualToString:@"8"]){
                   
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"传入的其他参数错误" preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    // 创建按钮
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //取消按钮
                        
                    }];
                    [alertController addAction:okAction];
                    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else if([code isEqualToString:@"9"]){
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"传入的Token值错误" preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    // 创建按钮
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //取消按钮
                       
                    }];
                    [alertController addAction:okAction];
                    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
                    [self presentViewController:alertController animated:YES completion:nil];
            
                }
                
                else if([code isEqualToString:@"500"]){
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器内部错误" preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    // 创建按钮
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //取消按钮
                        
                    }];
                    [alertController addAction:okAction];
                    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
                    [self presentViewController:alertController animated:YES completion:nil];
                
                }
                else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"其他错误" preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    // 创建按钮
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //取消按钮
                        self.nameTextField.text = nil;
                        self.passwordTextField.text = nil;
                    }];
                    [alertController addAction:okAction];
                    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
                    [self presentViewController:alertController animated:YES completion:nil];
                
                }

            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            HUD.mode= MBProgressHUDModeText;
            HUD.labelText = @"网络连接失败";
            [HUD hide:YES afterDelay:1.5];
            NSLog(@"%@",error);
        }];
        
        
    }

}

//跳转到注册界面
- (IBAction)registerAction:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
//    [self presentViewController:registerVC animated:YES completion:nil];
    [self showViewController:registerVC sender:nil];
}

//点屏幕空白地方收起键盘
- (IBAction)tapBackKeyboardAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    CGRect frame = textField.frame;
    int offset = (frame.origin.y+140)-(self.view.frame.size.height-216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (offset > 0)
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{

    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
@end
