//
//  MainViewController.m
//  v2ex
//
//  Created by MAC on 16/6/29.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

#import "FeedEntity.h"
#import "MainTableViewCell.h"
#import "CZFPSLabel.h"
#import "MJRefresh.h"

#import <UITableView+FDTemplateLayoutCell.h>

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (copy, nonatomic) NSArray * dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSArray array];
    
//    [self loadHotData];
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
    
    UIPanGestureRecognizer * moveGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMove:)];
    [self.view addGestureRecognizer:moveGesture];
    
}

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


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DetailViewController * detailController = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    
    NSDictionary * detailDic = self.dataArray[indexPath.row];
    FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:detailDic];
    detailController.htmlString = detail.content_rendered;
    detailController.identifier = detail.identifier;
//    detailController.detail = detail;
    detailController.detailDic = detailDic;
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 110;
    return [tableView fd_heightForCellWithIdentifier:@"Main" cacheByIndexPath:indexPath configuration:^(id cell) {
        
        NSDictionary * detailDic = self.dataArray[indexPath.row];
        FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:detailDic];
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
    NSDictionary * detailDic = self.dataArray[indexPath.row];
    FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:detailDic];
    [cell setFeedEntity:detail];
    
    return cell;
}

- (void)loadHotData
{
    
    NSString * uri = @"https://www.v2ex.com/api/topics/hot.json";
//    NSString * uri = @"http://www.v2ex.com/api/topics/show.json?id=289663";
    NSDictionary *param = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:uri parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = responseObject;
        
        [self.mainTableView reloadData];
        [self.mainTableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
    
}

/**
 *  获取html源码
 */
- (void)loadHtmlData
{
    NSString * uri = @"https://www.v2ex.com/?tab=play";
    
    //获取html源码方法1 但是会占据主线程
    //    NSString *dataString = [NSString stringWithContentsOfURL:[NSURL URLWithString:uri] encoding:NSUTF8StringEncoding error:nil];  //htmlString是html网页的地址
    
    NSDictionary *param = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/png",nil];
    
    //设置返回格式 改成二进制格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:uri parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"data:%@",dataString);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void)loadNewData
{
    [self loadHotData];
}
@end
