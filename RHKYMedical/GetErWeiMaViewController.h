//
//  GetErWeiMaViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/3.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface GetErWeiMaViewController : UIViewController<MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UILabel *zhuangTaiLabel;
@property (weak, nonatomic) IBOutlet UIView *erWeiMaView;
@property (weak, nonatomic) IBOutlet UIImageView *erWeiMaImageView;
//@property (weak, nonatomic) IBOutlet UIButton *getErWeiMaButton;
//- (IBAction)getErWeiMaAction:(id)sender;

@end
