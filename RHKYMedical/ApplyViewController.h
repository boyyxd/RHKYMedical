//
//  ApplyViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/17.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ApplyViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *chooseTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *choosePaiBanTextField;
- (IBAction)chooseTimeAction:(id)sender;
- (IBAction)choosePaiBanAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
- (IBAction)okAction:(id)sender;
- (IBAction)tapBackKeyBoardAction:(id)sender;

@end
