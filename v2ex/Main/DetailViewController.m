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
#import "MJRefresh.h"
#import "FeedEntity.h"
#import "Consts.h"
#import <UITableView+FDTemplateLayoutCell.h>
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@property (copy , nonatomic) NSArray * repliesArray;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadRepliesData];
    [self registerCell];
    
    
    
//    self.mainWebView.scrollView.bounces = NO;
//    self.mainWebView.scalesPageToFit = YES;
//    self.mainWebView.scrollView.showsVerticalScrollIndicator = FALSE;
//    self.mainWebView.scrollView.showsHorizontalScrollIndicator = FALSE;
//    
//    NSString * htmlStr = [NSString stringWithFormat:@"<html> \n"
//                          "<head> \n"
//                          "<style type=\"text/css\"> \n"
//                          "body { font-family: \"%@\";}\n"
//                          "</style> \n"
//                          "</head> \n"
//                          "<body>%@</body> \n"
//                          "</html>", @"Lucida Grande", self.htmlString];
//    
//    
//    [self.mainWebView loadHTMLString:htmlStr baseURL:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"var script = document.createElement('script');"
      "script.type = 'text/javascript';"
      "script.text = \"function ResizeImages() { "
      "var myimg,oldwidth;"
      "var maxwidth=%f;" //缩放系数
      "for(i=0;i <document.images.length;i++){"
      "myimg = document.images[i];"
      "if(myimg.width > maxwidth){"
      "oldwidth = myimg.width;"
      "myimg.width = maxwidth;"
      "}"
      "}"
      "}\";"
      "document.getElementsByTagName('head')[0].appendChild(script);", _screenWidth]];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
}

- (void)registerCell
{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"replies"];
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
    return [tableView fd_heightForCellWithIdentifier:@"replies" cacheByIndexPath:indexPath configuration:^(id cell) {
        NSDictionary * detailDic = self.repliesArray[indexPath.row];
        FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:detailDic];
        [cell setFeedEntity:detail];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.repliesArray.count;
//    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"replies"];
    NSDictionary * detailDic = self.repliesArray[indexPath.row];
    FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:detailDic];
    [cell setFeedEntity:detail];
    return cell;
}

- (void)loadRepliesData
{
    
    NSString * uri = [NSString stringWithFormat:@"https://www.v2ex.com/api/replies/show.json?topic_id=%@",self.identifier];
    //    NSString * uri = @"http://www.v2ex.com/api/topics/show.json?id=289663";
    
    NSLog(@"%@",uri);
    
    NSDictionary *param = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:uri parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.repliesArray = responseObject;
        
//        self.dataArray = responseObject;
        
        [self.mainTableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
    
}

@end
