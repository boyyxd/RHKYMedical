//
//  LookOperationDetailsViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/29.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "LookOperationDetailsViewController.h"
#import "QRCodeGenerator.h"


@interface LookOperationDetailsViewController ()

@end

@implementation LookOperationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"手术排班详情";
    
    //设置自动换行，防止显示不全
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
    
    self.RankLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"operation_name"]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"op_datetime"]];
    self.addressLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"ward_name"]];
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"operating_room_name"]];
    self.patientNameLabel.text = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"participator"]];
    
    
    NSString * str = [NSString stringWithFormat:@"%@",[self.detailsDic objectForKey:@"qr_code"]];
    NSLog(@"erwm= %@",str);
    
    self.erWeiMaImageView.backgroundColor = [UIColor whiteColor];
    self.erWeiMaImageView.image = [QRCodeGenerator qrImageForString:
                                   str imageSize:self.erWeiMaImageView.bounds.size.width];
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
