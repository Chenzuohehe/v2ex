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

#import <UITableView+FDTemplateLayoutCell.h>

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (copy, nonatomic) NSArray * dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSArray array];
    
    
    self.title = @"V2EX";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(presentRightMenuViewController:)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.image = [UIImage imageNamed:@"Balloon"];
    [self.view addSubview:imageView];
    
    [self loadHotData];
    [self registerCell];
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
    
    return 110;
//    return [tableView fd_heightForCellWithIdentifier:@"identifer" cacheByIndexPath:indexPath configuration:^(id cell) {
//        // 配置 cell 的数据源，和 "cellForRow" 干的事一致，比如：
////        cell.entity = self.feedEntities[indexPath.row];
//    }];
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
//    static NSString *cellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        cell.backgroundColor = [UIColor clearColor];
//        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
//        cell.textLabel.textColor = [UIColor blackColor];
//        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
//        cell.selectedBackgroundView = [[UIView alloc] init];
//    }
//    
//    NSArray *titles = @[@"信息展示", @"信息展示", @"信息展示", @"信息展示", @"信息展示"];
//    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
//    cell.textLabel.text = titles[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Main"];
    NSDictionary * detailDic = self.dataArray[indexPath.row];
    FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:detailDic];
    [cell setDetail:detail];
    
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
