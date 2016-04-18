//
//  LoginViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/16.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface LoginViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)tapBackKeyboardAction:(id)sender;
@property(nonatomic) BOOL login;


@end
