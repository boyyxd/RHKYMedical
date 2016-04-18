//
//  LookDetailsViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/8.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "LookDetailsViewController.h"
#import "QRCodeGenerator.h"

@interface LookDetailsViewController ()

@end

@implementation LookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"查看申请详情";

    //设置自动换行，防止显示不全
    self.timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.RankLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.peopleCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.patientNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.huanZheLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.canYuZheLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.timeLabel.numberOfLines = 0;
    self.addressLabel.numberOfLines = 0;
    self.RankLabel.numberOfLines = 0;
    self.peopleCountLabel.numberOfLines = 0;
    self.patientNameLabel.numberOfLines = 0;
    self.huanZheLabel.numberOfLines = 0;
    self.canYuZheLabel.numberOfLines = 0;
    
    self.RankLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"operation_name"]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"operation_time"]];
    self.addressLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"operating_room_name"]];
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"applytime"]];
    self.patientNameLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"status"]];
    self.huanZheLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"patient_name"]];
    self.canYuZheLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"participants"]];
    

    if (![self.patientNameLabel.text isEqualToString:@"已通过"]) {
        self.erWeiMaView.hidden = YES;
    }else{
        self.erWeiMaView.hidden = NO;
        NSString * str = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"qr_code"]];
        
        self.erWeiMaImageView.backgroundColor = [UIColor whiteColor];
        self.erWeiMaImageView.image = [QRCodeGenerator qrImageForString:
                                       str imageSize:self.erWeiMaImageView.bounds.size.width];
    }
    
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

@end
