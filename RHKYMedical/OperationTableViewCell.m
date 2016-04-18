//
//  OperationTableViewCell.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/29.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "OperationTableViewCell.h"

@implementation OperationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.RankLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.timeLabel.numberOfLines = 0;
    self.RankLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
