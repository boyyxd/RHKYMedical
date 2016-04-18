//
//  noReturnTableViewCell.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/8.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface noReturnTableViewCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;//数量转为类型
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
