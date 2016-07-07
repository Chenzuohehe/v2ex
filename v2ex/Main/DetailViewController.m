//
//  DetailViewController.m
//  v2ex
//
//  Created by MAC on 16/7/7.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "DetailViewController.h"
#import "Consts.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.mainWebView.scrollView.bounces = NO;
    self.mainWebView.scrollView.showsVerticalScrollIndicator = FALSE;
    self.mainWebView.scrollView.showsHorizontalScrollIndicator = FALSE;
    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ceshi" ofType:@"html"];
//    self.htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    NSString * string = self.htmlString;
//    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    self.htmlString = [self.htmlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    self.htmlString = [self.htmlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    self.htmlString = [self.htmlString stringByRemovingPercentEncoding];
    NSLog(@"%@",self.htmlString);
    [self.mainWebView loadHTMLString:self.htmlString baseURL:nil];
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

@end
