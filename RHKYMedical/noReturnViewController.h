//
//  noReturnViewController.h
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/8.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface noReturnViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *noReturnTableView;

@end
