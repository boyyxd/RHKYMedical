//
//  RegisterViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/16.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
#import "MBProgressHUD.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate,
/*UIPickerViewDelegate,UIPickerViewDataSource,*/MZTimerLabelDelegate,MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainTextField;
- (IBAction)tapBackKeyBoardAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rewriteButton;
- (IBAction)rewriteAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerAction:(id)sender;
//@property (weak, nonatomic) IBOutlet UITextField *keShiTextField;
//@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
//- (IBAction)keShiAction:(id)sender;
//- (IBAction)positionAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeButton;
- (IBAction)getSecurityCodeAction:(id)sender;

@end
