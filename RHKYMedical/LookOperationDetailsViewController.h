//
//  LookOperationDetailsViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/29.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookOperationDetailsViewController : UIViewController
@property(nonatomic,retain) NSDictionary *detailsDic;//属性传值
@property (weak, nonatomic) IBOutlet UILabel *RankLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;//改为手术室名称
@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;//改为手术参与人
@property (weak, nonatomic) IBOutlet UIImageView *erWeiMaImageView;

@end
