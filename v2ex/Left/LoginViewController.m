//
//  LoginViewController.m
//  v2ex
//
//  Created by ChenZuo on 16/7/20.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "CommonUtil.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

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

- (void)setUserInfo
{
    ///api/members/show.json
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * userName = [userDefaults objectForKey:@"userName"];
    
    
    NSString * uri =@"https://www.v2ex.com/api/members/show.json?username=";
    uri = [NSString stringWithFormat:@"%@%@",uri,userName];
    NSLog(@"%@",uri);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:uri parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary * dict = responseObject;
        [userDefaults setObject:dict forKey:@"userInfoDic"];
        [self backClicek:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (IBAction)click:(id)sender {
    
    NSString * userName = self.userNameTextField.text;
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if (![CommonUtil isEmpty:userName]) {
        [userDefaults setObject:userName forKey:@"userName"];
        [self setUserInfo];
    }
    
}


- (IBAction)backClicek:(id)sender {
    
    MainViewController *nextController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:nextController animated:YES];
    
}

@end
