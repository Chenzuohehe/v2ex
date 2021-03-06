//
//  MainViewController.m
//  v2ex
//
//  Created by MAC on 16/6/29.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"

#import "FeedEntity.h"
#import "MainTableViewCell.h"
#import "CZFPSLabel.h"
#import "MJRefresh.h"

#import "LeftMenuViewController.h"

#import <UITableView+FDTemplateLayoutCell.h>

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (copy, nonatomic) NSArray * dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSArray array];
    
    [self registerCell];
    self.mainTableView.separatorStyle = NO;
    
    
    self.title = @"V2EX";
    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 33)];
    [leftBtn setImage:[UIImage imageNamed:@"leftBar"] forState:UIControlStateNormal];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
    [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 33)];
    [rightBtn setImage:[UIImage imageNamed:@"rightBar"] forState:UIControlStateNormal];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    [rightBtn addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.mainTableView.mj_header beginRefreshing];
    
    
    //监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needlogin) name:@"needlogin" object:nil];
    
    
    UIPanGestureRecognizer * moveGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMove:)];
    [self.view addGestureRecognizer:moveGesture];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSUserDefaults * userDefaulys = [NSUserDefaults standardUserDefaults];
//    NSDictionary * userInfoDic = [userDefaulys objectForKey:@"userInfoDic"];
//    if (![CommonUtil dictIsEmpty:userInfoDic]) {
//        NSLog(@"bu kong ");
//        RESideMenu * main = (RESideMenu *)[UIApplication sharedApplication].keyWindow.window.rootViewController;
//        LeftMenuViewController * leftMianView = (LeftMenuViewController *)main.leftMenuViewController;
//        leftMianView.userInfoDic = userInfoDic;
//        
//        main.leftMenuViewController = leftMianView;
//        [UIApplication sharedApplication].keyWindow.window.rootViewController = main;
//        
//    }else{
//        NSLog(@"kong ");
//    }
//}


- (void)panMove:(UIPanGestureRecognizer *)moveGesture
{
    CGPoint point = [moveGesture translationInView:self.view];
    if (point.x > 0) {
        NSLog(@">0");
    }else if (point.x < 0){
        NSLog(@"<0");
    }
}

- (void)registerCell
{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"Main"];
}


#pragma mark - 监听
- (void)needlogin{
    LoginViewController *nextController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:nextController]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];

//    [self.navigationController pushViewController:nextController animated:YES];
}



#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DetailViewController * detailController = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    
    FeedEntity * detail = self.dataArray[indexPath.row];
    detailController.identifier = detail.identifier;
    
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"Main" cacheByIndexPath:indexPath configuration:^(id cell) {
        
        FeedEntity * detail = self.dataArray[indexPath.row];
        [cell setFeedEntity:detail];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Main"];
    FeedEntity * detail = self.dataArray[indexPath.row];
    [cell setFeedEntity:detail];
    
    return cell;
}


/**
 *  获取html源码
 */
- (void)loadHtmlData
{
    NSString * uri;
    if ([CommonUtil isEmpty:self.topic]) {
        uri = @"https://www.v2ex.com/?tab=all";
    }else{
        uri = [NSString stringWithFormat:@"https://www.v2ex.com/?%@",self.topic];
    }
    
    //获取html源码方法1 但是会占据主线程
    //    NSString *dataString = [NSString stringWithContentsOfURL:[NSURL URLWithString:uri] encoding:NSUTF8StringEncoding error:nil];  //htmlString是html网页的地址
    
    NSDictionary *param = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/png",nil];
    
    //设置返回格式 改成二进制格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:uri parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       self.dataArray = [CommonUtil feedEntityListFromHtmlString:responseObject];
        [self.mainTableView reloadData];
        
        [self.mainTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void)loadNewData
{
    [self loadHtmlData];
}
@end
