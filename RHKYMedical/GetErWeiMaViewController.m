//
//  GetErWeiMaViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/3.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "GetErWeiMaViewController.h"
#import "MBProgressHUD.h"
#import "QRCodeGenerator.h"

@interface GetErWeiMaViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation GetErWeiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.getErWeiMaButton.layer.cornerRadius = 5;
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    NSDictionary * userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];//data文件转成字典
    NSString * str = [NSString stringWithFormat:@"%@",[userDic objectForKey:@"qr_code"]];
    NSString * str1 = [NSString stringWithFormat:@"%@", [userDic objectForKey:@"isthisdept"]];
    if (![str isEqualToString:@""]&&[str1 isEqualToString:@"1"]) {
        self.erWeiMaView.hidden = NO;
        self.zhuangTaiLabel.text = @"获取状态:成功(本科室)";
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"二维码获取成功";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1.5];
    }
    if ([str1 isEqualToString:@"0"]) {
        self.erWeiMaView.hidden = YES;
        self.zhuangTaiLabel.text = @"获取状态:失败(非本科室)";
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"非本科室不能查看二维码";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
    self.erWeiMaImageView.backgroundColor = [UIColor whiteColor];
    self.erWeiMaImageView.image = [QRCodeGenerator qrImageForString:
                                                          str imageSize:self.erWeiMaImageView.bounds.size.width];
    
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

//- (IBAction)getErWeiMaAction:(id)sender {
//    HUD.mode = MBProgressHUDModeIndeterminate;
//    HUD.labelText = @"获取中...";
//    [HUD show:YES];
//    [HUD hide:YES afterDelay:1.5];
//    
//}
@end
