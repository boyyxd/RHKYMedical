//
//  UserGuideViewController.m
//  RHKYMedical
//
//  Created by 杨小东 on 16/3/24.
//  Copyright © 2016年 杨小东. All rights reserved.
//

#import "UserGuideViewController.h"
#import "ViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuide];   //加载新用户指导页面
}
- (void)initGuide
{
      UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
      [scrollView setContentSize:CGSizeMake(self.view.frame.size.width*4, 0)];
      [scrollView setPagingEnabled:YES];  //视图整页显示
      //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
   
      UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
      [imageview setImage:[UIImage imageNamed:@"1.jpg"]];
      [scrollView addSubview:imageview];
   
      UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
      [imageview1 setImage:[UIImage imageNamed:@"2.jpg"]];
      [scrollView addSubview:imageview1];
   
      UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight)];
      [imageview2 setImage:[UIImage imageNamed:@"3.jpg"]];
      [scrollView addSubview:imageview2];
   
      UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*3, 0, ScreenWidth, ScreenHeight)];
      [imageview3 setImage:[UIImage imageNamed:@"4.jpg"]];
      imageview3.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
      [scrollView addSubview:imageview3];
   
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
//      [button setTitle:@"进入" forState:UIControlStateNormal];
      [button setFrame:self.view.frame];
      [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
      [imageview3 addSubview:button];
      
      [self.view addSubview:scrollView];
}

- (void)firstpressed
{
    // 从storyboard创建MainViewController
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *rootVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewControllerID"];
    UINavigationController * rootNavController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self presentViewController:rootNavController animated:NO completion:nil];  //点击button跳转到根视图

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
