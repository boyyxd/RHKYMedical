//
//  LookDetailsViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/8.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookDetailsViewController : UIViewController

@property(nonatomic,retain) NSDictionary *detailsDic;//属性传值
@property (weak, nonatomic) IBOutlet UILabel *RankLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;
@property (weak, nonatomic) IBOutlet UIView *erWeiMaView;
@property (weak, nonatomic) IBOutlet UILabel *huanZheLabel;
@property (weak, nonatomic) IBOutlet UILabel *canYuZheLabel;
@property (weak, nonatomic) IBOutlet UIImageView *erWeiMaImageView;

@end
