//
//  RightMenuViewController.m
//  v2ex
//
//  Created by MAC on 16/6/29.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "RightMenuViewController.h"
#import "MainViewController.h"

@interface RightMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.separatorStyle = NO;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * topic;
    topic = @"tab=all";
    switch (indexPath.row) {
        case 0:
            NSLog(@"技术");
            topic = @"tab=tech";
            break;
        case 1:
            NSLog(@"创意");
            topic = @"tab=creative";
            break;
        case 2:
            NSLog(@"好玩");
            topic = @"tab=play";
            break;
        case 3:
            NSLog(@"Apple");
            topic = @"tab=apple";
            break;
        case 4:
            NSLog(@"酷工作");
            topic = @"tab=jobs";
            break;
        case 5:
            NSLog(@"交易");
            topic = @"tab=deals";
            break;
        case 6:
            NSLog(@"城市");
            topic = @"tab=city";
            break;
        case 7:
            NSLog(@"问与答");
            topic = @"tab=qna";
            break;
        case 8:
            NSLog(@"最热");
            topic = @"tab=hot";
            break;
        case 9:
            NSLog(@"全部");
            topic = @"tab=all";
            break;
        case 10:
            NSLog(@"R2");
            topic = @"tab=r2";
            break;
        
        default:
            break;
    }
    
    MainViewController * nextViewController = [[MainViewController alloc] init];
    nextViewController.topic = topic;
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:nextViewController]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];

    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"技术", @"创意",@"好玩",@"Apple",@"酷工作",@"交易",@"城市",@"问与答",@"最热",@"全部",@"R2"];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    return cell;
}


@end
