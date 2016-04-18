//
//  noReturnTableViewCell.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/8.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "noReturnTableViewCell.h"

@implementation noReturnTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    self.rankLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.amountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.timeLabel.numberOfLines = 0;
    self.nameLabel.numberOfLines = 0;
//    self.rankLabel.numberOfLines = 0;
    self.amountLabel.numberOfLines = 0;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
