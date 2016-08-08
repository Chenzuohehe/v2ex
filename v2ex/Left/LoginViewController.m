//
//  LoginViewController.m
//  v2ex
//
//  Created by ChenZuo on 16/7/20.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationController.navigationBarHidden = YES;
    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 33)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
    [leftBtn addTarget:self action:@selector(backClicek:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    
    
    
}


- (IBAction)backClicek:(id)sender {
    
    MainViewController *nextController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:nextController animated:YES];
    
}

@end
