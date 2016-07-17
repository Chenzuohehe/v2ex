//
//  DetailViewController.m
//  v2ex
//
//  Created by MAC on 16/7/7.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "DetailViewController.h"
#import "RepliesTableViewCell.h"
#import "MainTableViewCell.h"
#import "ContentTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "DetailModel.h"

#import "MJRefresh.h"
#import "Consts.h"

@interface DetailViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *mainWebView;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UIView *headView;


@property (copy , nonatomic) NSArray * repliesArray;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadHtmlData];
    [self registerCell];
    self.mainTableView.separatorStyle = NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)registerCell
{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"content"];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"content" cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell setDetail:self.detail];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"content"];
    [cell setDetail:self.detail];
    return cell;
}

/**
 *  获取html源码
 */
- (void)loadHtmlData
{
    NSString * uri;
    if ([CommonUtil isEmpty:self.identifier]) {
        
        return;
    }else{
//        uri = [NSString stringWithFormat:@"https://www.v2ex.com%@",self.identifier];
        uri = @"https://www.v2ex.com/t/292768#reply74";
        NSLog(@"%@",uri);
    }
    
    NSDictionary *param = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/png",nil];
    
    //设置返回格式 改成二进制格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:uri parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.detail = [CommonUtil feedEntityDetailFromHtmlString:responseObject];
        [self.mainTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



@end
