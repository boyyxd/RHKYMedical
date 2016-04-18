//
//  LookApplyViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/17.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsTableViewCell.h"
#import "MBProgressHUD.h"

@interface LookApplyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

@end
