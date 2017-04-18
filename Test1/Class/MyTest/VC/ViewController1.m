//
//  ViewController1.m
//  Test1
//
//  Created by 小雨科技 on 2017/4/5.
//  Copyright © 2017年 小雨科技有限公司. All rights reserved.
//

#import "ViewController1.h"
#define _WIDTH [UIScreen mainScreen].bounds.size.width
#define _HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController1 ()<UIScrollViewDelegate>{
    UIScrollView *scrollView;
}

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self mineScrollerInit];
}
-(void)mineScrollerInit{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT)];
    scrollView.backgroundColor = [UIColor whiteColor];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    // 设置内容大小
    scrollView.contentSize = CGSizeMake(_WIDTH, _HEIGHT*1.2);
    // 是否反弹
    //    scrollView.bounces = NO;
    // 是否分页
    //    scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    //    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
    //    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
    //    scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
    //    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    // 提示用户,Indicators flash
    [scrollView flashScrollIndicators];
    // 是否同时运动,lock
    scrollView.directionalLockEnabled = YES;
    [self.view addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
    label.backgroundColor = [UIColor yellowColor];
    label.text = @"学习scrolleview";
    [scrollView addSubview:label];
    
    UIButton *button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(0, 100, _WIDTH, 50)];
    [button1 addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor=[UIColor clearColor];
    button1.tag=1;
    [button1 setTitle:@"拍一张" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button1.titleLabel.font=[UIFont systemFontOfSize:16];
    [scrollView addSubview:button1];

 }
-(void)actionButton:(UIButton*)sender{
    int x = arc4random() % 5;
    scrollView.contentSize = CGSizeMake(_WIDTH, _HEIGHT*x);
    NSLog(@"%f",scrollView.contentSize.height);
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
