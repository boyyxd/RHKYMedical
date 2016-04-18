//
//  DetailsTableViewCell.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/8.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *RankLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;

@end
