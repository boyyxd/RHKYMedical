//
//  DetailsTableViewCell.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/8.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "DetailsTableViewCell.h"

@implementation DetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //自动折行设置
    self.timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.RankLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.peopleCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.patientNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.timeLabel.numberOfLines = 0;
    self.addressLabel.numberOfLines = 0;
    self.RankLabel.numberOfLines = 0;
    self.peopleCountLabel.numberOfLines = 0;
    self.patientNameLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
