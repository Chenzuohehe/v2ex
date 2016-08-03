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
    self.title = @"帖子详情";
    [self loadHtmlData];
    [self loadReplies];
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
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"RepliesTableViewCell" bundle:nil] forCellReuseIdentifier:@"replies"];
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
    
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"content" cacheByIndexPath:indexPath configuration:^(id cell) {
            [cell setDetail:self.detail];
        }];
    }else{
        return [tableView fd_heightForCellWithIdentifier:@"replies" cacheByIndexPath:indexPath configuration:^(id cell) {
            NSDictionary * dic = self.repliesArray[indexPath.row];
            FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:dic];
            [cell setFeedEntity:detail];
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 1) {
        return self.repliesArray.count;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"content"];
        [cell setDetail:self.detail];
        return cell;
    }else{
        RepliesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"replies"];
        NSDictionary * dic = self.repliesArray[indexPath.row];
        FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:dic];
        [cell setFeedEntity:detail];
        return cell;
    }
    
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
        uri = [NSString stringWithFormat:@"https://www.v2ex.com%@",self.identifier];
//        uri = @"https://www.v2ex.com/t/292768#reply74";
//        NSLog(@"%@",uri);
    }
    
    NSDictionary *param = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/png",nil];
    
    //设置返回格式 改成二进制格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:uri parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.detail = [CommonUtil feedEntityDetailFromHtmlString:responseObject];
        [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)loadReplies
{
    NSString * uri =@"https://www.v2ex.com/api/replies/show.json?topic_id=";
    NSString * replyString = self.identifier;
    if ([replyString rangeOfString:@"#"].location != NSNotFound && [replyString rangeOfString:@"/"].location != NSNotFound) {
        NSString * detailId = [[[[replyString componentsSeparatedByString:@"#"]firstObject]componentsSeparatedByString:@"/"]lastObject];
        uri = [NSString stringWithFormat:@"%@%@",uri,detailId];
    }
    NSLog(@"%@",uri);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:uri parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * repliesArray = responseObject;
        self.repliesArray = repliesArray;
        NSLog(@"%ld",self.repliesArray.count);
        [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationRight];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
