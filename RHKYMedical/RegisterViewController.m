//
//  RegisterViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/16.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "AFHTTPSessionManager.h"
#import "UrlFile.h"
#import "LoginViewController.h"
#import "ViewController.h"

@interface RegisterViewController ()
{
    NSArray *keShiArray;
//    UIPickerView *keShiPickerView;//选择科室picker
    NSArray *positionArray;
//    UIPickerView *positionPickerView;//选择职位picker
    UILabel *timerShowLabel;//倒计时label
    MBProgressHUD *HUD;
    BOOL checkEmail;
    BOOL CheckKeShi;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    self.nameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.passwordAgainTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.securityCodeTextField.delegate = self;
    //开启密码隐藏
    self.passwordTextField.secureTextEntry = YES;
    self.passwordAgainTextField.secureTextEntry = YES;
    
    self.registerButton.layer.cornerRadius = 5;
    self.rewriteButton.layer.cornerRadius = 5;
    self.getSecurityCodeButton.layer.cornerRadius = 5;
    
    //textField右视图
/*    UIImageView *rightView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.keShiTextField.frame.size.height, self.keShiTextField.frame.size.height)];
    rightView1.image = [UIImage imageNamed:@"下拉1"];
    self.keShiTextField.rightViewMode = UITextFieldViewModeAlways;
    self.keShiTextField.rightView = rightView1;
    
    UIImageView *rightView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.positionTextField.frame.size.height, self.positionTextField.frame.size.height)];
    rightView2.image = [UIImage imageNamed:@"下拉1"];
    self.positionTextField.rightViewMode = UITextFieldViewModeAlways;
    self.positionTextField.rightView = rightView2;
    
    keShiPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];
    
    // 显示选中框
    keShiPickerView.showsSelectionIndicator=YES;
    keShiPickerView.dataSource = self;
    keShiPickerView.delegate = self;
    [keShiPickerView reloadAllComponents];//刷新UIPickerView
    keShiPickerView.showsSelectionIndicator=YES;
    self.keShiTextField.inputView = keShiPickerView;
    
    
    positionPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];
    // 显示选中框
    positionPickerView.showsSelectionIndicator=YES;
    positionPickerView.dataSource = self;
    positionPickerView.delegate = self;
    [positionPickerView reloadAllComponents];//刷新UIPickerView
    positionPickerView.showsSelectionIndicator=YES;
    self.positionTextField.inputView = positionPickerView;
    positionArray = [NSArray arrayWithObjects:@"医生",@"护士",@"其他",nil];
    [self getKeShi];
 */

}

/*
-(void)getKeShi{
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"科室获取中";
    [HUD  show:YES];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer.timeoutInterval = 15;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager GET:GET_Department_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HUD hide:YES afterDelay:0.3];
        NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
        NSArray *responseObjectArray = (NSArray *)[[responseObjectDic objectForKey:@"body"]objectForKey:@"datalist"];
        NSLog(@"str----------%@/n%@",responseObjectDic,responseObjectArray);
        keShiArray = responseObjectArray;
        CheckKeShi = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CheckKeShi = NO;
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD hide:YES afterDelay:1.5];
        NSLog(@"%@",error);
    }];
}


//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == keShiPickerView) {
        return [keShiArray count];
    }else
        return [positionArray count];
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.0f;
}
//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.view.frame.size.width;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    if (!view){
//        view = [[UIView alloc]init];
//    }
//    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    text.textAlignment = NSTextAlignmentCenter;
//    text.text = [keShiArray objectAtIndex:row];
//    [view addSubview:text];
//    
//    return view;
//}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == keShiPickerView) {
        NSString *str = [NSString stringWithFormat:@"%@室:%@",[[keShiArray objectAtIndex:row]objectForKey:@"Deptcode"], [[keShiArray objectAtIndex:row]objectForKey:@"Deptname"]];
        return str;
    }
    else
    {
        NSString *str = [positionArray objectAtIndex:row];
        return str;
    }
    
}
//显示的标题字体、颜色等属性
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSString *str = [keShiArray objectAtIndex:row];
//    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
//    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
//    
//    return AttributedString;
//}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == keShiPickerView) {
        self.keShiTextField.text = [NSString stringWithFormat:@"%@",[[keShiArray objectAtIndex:row]objectForKey:@"Deptcode"]];
        
    }
    if (pickerView == positionPickerView) {
        self.positionTextField.text = [positionArray objectAtIndex:row];
        
    }
}
 */

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


- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点屏幕空白地方收起键盘
- (IBAction)tapBackKeyBoardAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.passwordAgainTextField resignFirstResponder];
//    [self.keShiTextField resignFirstResponder];
//    [self.positionTextField resignFirstResponder];
    [self.securityCodeTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}


//重填信息
- (IBAction)rewriteAction:(id)sender {
    self.nameTextField.text = nil;
    self.passwordTextField.text = nil;
    self.passwordAgainTextField.text = nil;
//    self.keShiTextField.text = nil;
//    self.positionTextField.text = nil;
    self.emailTextField.text = nil;
    self.securityCodeTextField.text = nil;
    
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.passwordAgainTextField resignFirstResponder];
//    [self.keShiTextField resignFirstResponder];
//    [self.positionTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.securityCodeTextField resignFirstResponder];
}

//注册
- (IBAction)registerAction:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.passwordAgainTextField resignFirstResponder];
//    [self.keShiTextField resignFirstResponder];
//    [self.positionTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.securityCodeTextField resignFirstResponder];

    if ([self.nameTextField.text isEqualToString:@""] ||
        [self.passwordTextField.text isEqualToString:@""] ||
        [self.passwordAgainTextField.text isEqualToString:@""] ||
//        [self.keShiTextField.text isEqualToString:@""] ||
//        [self.positionTextField.text isEqualToString:@""] ||
        [self.emailTextField.text isEqualToString:@""] ||
        [self.securityCodeTextField.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写完整信息！" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"继续填写" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //取消按钮
        }];
        [alertController addAction:okAction];
        // 将UIAlertController模态出来 相当于UIAlertView show 的方法
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        if (![self.passwordTextField.text isEqualToString:self.passwordAgainTextField.text]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码输入不一致！" preferredStyle:(UIAlertControllerStyleAlert)];
            
            // 创建按钮
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //取消按钮
                self.passwordTextField.text = nil;
                self.passwordAgainTextField.text = nil;
            }];
            [alertController addAction:okAction];
            // 将UIAlertController模态出来 相当于UIAlertView show 的方法
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            //满足条件，注册
            
            NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:self.nameTextField.text,@"username",self.passwordAgainTextField.text,@"password",@"",@"department_code",self.securityCodeTextField.text,@"check_code",nil];
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
            [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
            [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
            sessionManager.requestSerializer.timeoutInterval = 15;
            sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            [sessionManager POST:REGISTER_URL parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
                
                NSString *str = [NSString stringWithFormat:@"%@",[[responseObjectDic objectForKey:@"header"]objectForKey:@"result"]];
                NSString *code = [NSString stringWithFormat:@"%@",[[responseObjectDic objectForKey:@"header"]objectForKey:@"code"]];
                NSLog(@"str = %@\ncode = %@",responseObjectDic,code);
                if ([str isEqualToString:@"1"]) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜！注册成功！" preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    // 创建按钮
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //取消按钮
                        // 从storyboard创建MainViewController
//                        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//                        ViewController *rootVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewControllerID"];
//                        
//                        UINavigationController * rootNavController = [[UINavigationController alloc] initWithRootViewController:rootVC];
//                        
//                        rootVC.login = YES;
//                        [self presentViewController:rootNavController animated:YES completion:nil];
//                        LoginViewController *vc = [[LoginViewController alloc]init];
//                        vc.login = YES;
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alertController addAction:okAction];
                    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else{
                    
                    if([code isEqualToString:@"2"]){
                        HUD.mode = MBProgressHUDModeText;
                        HUD.labelText = @"工号已存在";
                        [HUD show:YES];
                        [HUD hide:YES afterDelay:2];
                    }
                    else if([code isEqualToString:@"3"]){
                        HUD.mode = MBProgressHUDModeText;
                        HUD.labelText = @"该邮箱已被注册";
                        [HUD show:YES];
                        [HUD hide:YES afterDelay:2];
                    }
                    
                
                    else if([code isEqualToString:@"5"]){
                        HUD.mode = MBProgressHUDModeText;
                        HUD.labelText = @"验证码错误或已经失效,或与注册信息不符";
                        [HUD show:YES];
                        [HUD hide:YES afterDelay:2];
                    }
                    
                    else if([code isEqualToString:@"7"]){
                        HUD.mode = MBProgressHUDModeText;
                        HUD.labelText = @"需要单位Code的操作，单位未找到";
                        [HUD show:YES];
                        [HUD hide:YES afterDelay:2];
                    }
                    
                    else if([code isEqualToString:@"6"] || [code isEqualToString:@"10"]){
                        HUD.mode = MBProgressHUDModeText;
                        HUD.labelText = @"工号未找到";
                        [HUD show:YES];
                        [HUD hide:YES afterDelay:2];
                    }
                    
                    
                    else if([code isEqualToString:@"500"]){
                        HUD.mode = MBProgressHUDModeText;
                        HUD.labelText = @"服务器内部错误";
                        [HUD show:YES];
                        [HUD hide:YES afterDelay:2];
                    }
                    else{
                        HUD.mode = MBProgressHUDModeText;
                        HUD.labelText = @"其他错误，重新注册";
                        [HUD show:YES];
                        [HUD hide:YES afterDelay:2];
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

/*
- (IBAction)keShiAction:(id)sender {
    if (CheckKeShi == NO) {
        [self getKeShi];
        
    }
    if (keShiArray.count > 0) {
        [self.keShiTextField becomeFirstResponder];
    }

}

- (IBAction)positionAction:(id)sender {
    [self.positionTextField becomeFirstResponder];

}
 */

//获取二维码
- (IBAction)getSecurityCodeAction:(id)sender {
    if ([self.emailTextField.text isEqualToString:@""]||[self.nameTextField.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"工号和邮箱不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重新填写" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //取消按钮
        }];
        [alertController addAction:okAction];
        // 将UIAlertController模态出来 相当于UIAlertView show 的方法
        [self presentViewController:alertController animated:YES completion:nil];
    }
        else
    {
        if ([self isValidateEmail:self.emailTextField.text] == NO) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写正确的邮箱地址" preferredStyle:(UIAlertControllerStyleAlert)];
            
            // 创建按钮
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重新填写" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //取消按钮
                self.emailTextField.text = @"";
            }];
            [alertController addAction:okAction];
            // 将UIAlertController模态出来 相当于UIAlertView show 的方法
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
            HUD.mode = MBProgressHUDModeIndeterminate;
            HUD.labelText = @"检测邮箱...";
            [HUD  show:YES];
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
            [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
            [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
            sessionManager.requestSerializer.timeoutInterval = 15;
            sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:self.emailTextField.text,@"email",nil];
            
            [sessionManager POST:CHECK_REGISTER_URL parameters:postDic progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
                NSString *checkStr = [NSString stringWithFormat:@"%@",[[[responseObjectDic objectForKey:@"body"]objectForKey:@"data"]objectForKey:@"hasused"]];
                NSLog(@"checkStr= %@",responseObjectDic);
                if ([checkStr isEqualToString:@"0"]) {
                    checkEmail = YES;
                    [self getSecurityCode];
                }else
                {
                    HUD.mode= MBProgressHUDModeIndeterminate;
                    HUD.labelText = @"邮箱已被注册";
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1.5];
                    checkEmail = NO;
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                HUD.mode= MBProgressHUDModeText;
                HUD.labelText = @"网络连接失败";
                [HUD hide:YES afterDelay:1.5];
            }];

        }
        
    }
}

- (void)getSecurityCode{
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:self.nameTextField.text,@"username",self.emailTextField.text,@"email",nil];
    //iOS9 af请求新用法
    NSLog(@"postStr = %@",postDic);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    sessionManager.requestSerializer.timeoutInterval = 15;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager POST:GET_SecurityCode_URL parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
        NSLog(@"2wm=%@",responseObjectDic);
        NSString *str = [NSString stringWithFormat:@"%@",[[responseObjectDic objectForKey:@"header"]objectForKey:@"result"]];
        NSString *code = [NSString stringWithFormat:@"%@",[[responseObjectDic objectForKey:@"header"]objectForKey:@"code"]];
        
        if ([str isEqualToString:@"1"]) {
            [self timeCount];
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"验证码发送成功,请到邮箱查看";
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
        }else{
            if([code isEqualToString:@"500"]){
                HUD.mode = MBProgressHUDModeText;
                HUD.labelText = @"服务器内部错误,请稍后重试";
                [HUD show:YES];
                [HUD hide:YES afterDelay:2];
            }else{
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"验证码发送失败,请稍后重试";
            [HUD show:YES];
                [HUD hide:YES afterDelay:2];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD hide:YES afterDelay:1.5];
        NSLog(@"%@",error);
    }];
}

//利用正则表达式验证邮箱格式
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//检测邮箱是否被注册
-(BOOL)checkEmail:(NSString *)email {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    sessionManager.requestSerializer.timeoutInterval = 15;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
     NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:self.emailTextField.text,@"email",nil];
    
    [sessionManager POST:CHECK_REGISTER_URL parameters:postDic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * responseObjectDic = (NSDictionary *)responseObject;
        NSString *checkStr = [NSString stringWithFormat:@"%@",[[[responseObjectDic objectForKey:@"body"]objectForKey:@"data"]objectForKey:@"hasused"]];
        NSLog(@"checkStr= %@",responseObjectDic);
        if ([checkStr isEqualToString:@"0"]) {
            checkEmail = YES;
            HUD.mode= MBProgressHUDModeIndeterminate;
            HUD.labelText = @"邮箱未被注册,点击获取二维码";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1.5];
            [self.getSecurityCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        }else
        {
            HUD.mode= MBProgressHUDModeIndeterminate;
            HUD.labelText = @"邮箱已被注册";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1.5];
            checkEmail = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HUD.mode= MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD hide:YES afterDelay:1.5];
    }];
    
    return checkEmail;
}

- (void)timeCount{//倒计时函数
    [self.getSecurityCodeButton setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    timerShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.getSecurityCodeButton.frame.size.width, self.getSecurityCodeButton.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
    [self.getSecurityCodeButton addSubview:timerShowLabel];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timerShowLabel andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"倒计时ss秒";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = [UIColor whiteColor];//倒计时字体颜色
    timer_cutDown.timeLabel.layer.cornerRadius = 5.0;
    [[timer_cutDown.timeLabel layer] setMasksToBounds:YES];
    timer_cutDown.timeLabel.backgroundColor = [UIColor grayColor];
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:13.0];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    self.getSecurityCodeButton.userInteractionEnabled = NO;//按钮禁止点击
    [timer_cutDown start];//开始计时
}

//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [self.getSecurityCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    [timerShowLabel removeFromSuperview];//移除倒计时模块
    self.getSecurityCodeButton.userInteractionEnabled = YES;//按钮可以点击
}

@end
