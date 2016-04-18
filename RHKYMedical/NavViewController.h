//
//  NavViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/18.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavViewController : UINavigationController
@property (weak, nonatomic) IBOutlet UIButton *erWeiMaButton;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UIButton *lookApplyButton;
@property(nonatomic) BOOL login;
@property (weak, nonatomic) IBOutlet UIButton *noReturnButton;

@end
