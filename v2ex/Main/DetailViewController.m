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

#import "MJRefresh.h"
#import "FeedEntity.h"
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
    // Do any additional setup after loading the view from its nib.
    [self loadRepliesData];
    [self registerCell];
    [self addHeadView];
    self.mainWebView.delegate = self;
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
    
    NSLog(@"flag123");
    
//    CGFloat documentHeight = [[self.mainWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
//    NSLog(@"%f",documentHeight);
    
        //    self.headView.backgroundColor = [UIColor yellowColor];
//    self.mainTableView.tableHeaderView = self.headView;
    
    
    CGFloat height = [[self.mainWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    self.mainWebView.frame = CGRectMake(self.mainWebView.frame.origin.x,self.mainWebView.frame.origin.y, _screenWidth, height);
    [self.mainTableView reloadData];
    
}

- (void)registerCell
{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"RepliesTableViewCell" bundle:nil] forCellReuseIdentifier:@"replies"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"content"];
}

- (void)addHeadView
{
    self.headView.frame = CGRectMake(0, 70, _screenWidth, 20);

    self.mainWebView.scrollView.bounces = NO;
    self.mainWebView.scalesPageToFit = YES;
    self.mainWebView.scrollView.showsVerticalScrollIndicator = FALSE;
    self.mainWebView.scrollView.showsHorizontalScrollIndicator = FALSE;
//     [self.mainWebView scalesPageToFit];
    
    NSString * htmlStr = [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body { font-family: \"%@\";}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body><div id=\"webview_content_wrapper\">%@</div></body> \n"
                          "</html>", @"Lucida Grande", self.htmlString];
    [self.mainWebView loadHTMLString:htmlStr baseURL:nil];
    
    
    
    
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
//        return 110;
    if (indexPath.section == 0) {
        return self.mainWebView.frame.size.height + 70;
    }
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
    if (sectionIndex == 0) {
        return 1;
    }
    return self.repliesArray.count;
//    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        ContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"content"];
//        cell.mainWebView = self.mainWebView;
        [cell addSubview:self.mainWebView];
        return cell;
    }else{
        RepliesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"replies"];
        NSDictionary * detailDic = self.repliesArray[indexPath.row];
        FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:detailDic];
        [cell setFeedEntity:detail];
        return cell;
    }
//    RepliesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"replies"];
//    NSDictionary * detailDic = self.repliesArray[indexPath.row];
//    FeedEntity * detail = [[FeedEntity alloc]initWithDictionary:detailDic];
//    [cell setFeedEntity:detail];
    
//    return cell;
}

- (void)loadRepliesData
{
    
    NSString * uri = [NSString stringWithFormat:@"https://www.v2ex.com/api/replies/show.json?topic_id=%@",self.identifier];
    //    NSString * uri = @"http://www.v2ex.com/api/topics/show.json?id=289663";
    
    
    
    NSDictionary *param = [NSDictionary dictionary];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:uri parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.repliesArray = responseObject;
        
        [self.mainTableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
    
}



@end
