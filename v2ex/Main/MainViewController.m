//
//  MainViewController.m
//  v2ex
//
//  Created by MAC on 16/6/29.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "MainViewController.h"
#import "FeedEntity.h"
#import "MainTableViewCell.h"
#import "CZFPSLabel.h"

#import <UITableView+FDTemplateLayoutCell.h>

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (copy, nonatomic) NSArray * dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSArray array];
    
    [self loadHotData];
    [self registerCell];
    self.mainTableView.separatorStyle = NO;
//    self.mainTableView
    
    self.title = @"V2EX";
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.image = [UIImage imageNamed:@"Balloon"];
    [self.view addSubview:imageView];
    
    NSNumber * testNum = nil;
    
    NSString * testStr = [NSString stringWithFormat:@"%lld",[testNum longLongValue]];
    NSLog(@"123%@",testStr);
}


- (void)registerCell
{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"Main"];
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
    NSDictionary *param = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:uri parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = responseObject;
        [self.mainTableView reloadData];
//        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
    
}
@end
