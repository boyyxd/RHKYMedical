//
//  ViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/2/16.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.erWeiMaButton.layer.borderColor = [UIColor colorWithRed:62/255.00 green:125/255.00 blue:81/255.00 alpha:1.0].CGColor;
    self.erWeiMaButton.layer.borderWidth = 1.0;
    self.erWeiMaButton.layer.cornerRadius = 5.0;
    self.erWeiMaButton.layer.masksToBounds = YES;//遮挡边界
    
    self.applyButton.layer.borderColor = [UIColor colorWithRed:62/255.00 green:125/255.00 blue:81/255.00 alpha:1.0].CGColor;
    self.applyButton.layer.borderWidth = 1.0;
    self.applyButton.layer.cornerRadius = 5.0;
    self.applyButton.layer.masksToBounds = YES;//遮挡边界
    
    self.lookApplyButton.layer.borderColor = [UIColor colorWithRed:62/255.00 green:125/255.00 blue:81/255.00 alpha:1.0].CGColor;
    self.lookApplyButton.layer.borderWidth = 1.0;
    self.lookApplyButton.layer.cornerRadius = 5.0;
    self.lookApplyButton.layer.masksToBounds = YES;//遮挡边界
    
    self.lookOperationButton.layer.borderColor = [UIColor colorWithRed:62/255.00 green:125/255.00 blue:81/255.00 alpha:1.0].CGColor;
    self.lookOperationButton.layer.borderWidth = 1.0;
    self.lookOperationButton.layer.cornerRadius = 5.0;
    self.lookOperationButton.layer.masksToBounds = YES;//遮挡边界
    
    self.noReturnButton.layer.borderColor = [UIColor colorWithRed:62/255.00 green:125/255.00 blue:81/255.00 alpha:1.0].CGColor;
    self.noReturnButton.layer.borderWidth = 1.0;
    self.noReturnButton.layer.cornerRadius = 5.0;
    self.noReturnButton.layer.masksToBounds = YES;//遮挡边界
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    navigationBar.tintColor = nil;
    //创建UINavigationItem
//    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"主页1"];
//
//    UIView *textView1=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
//    textView1.backgroundColor=[UIColor whiteColor];
//    [self.navigationItem setTitleView:textView1];
//    [self.view addSubview: navigationBar];
    self.navigationItem.title = @"主页";
    
}

- (void)viewDidAppear:(BOOL)animated{
    if (self.login == NO) {
        self.login = YES;
        LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
