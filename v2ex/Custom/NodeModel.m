//
//  NodeModel.m
//  v2ex
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "NodeModel.h"
#import "CommonUtil.h"

@implementation NodeModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    
    if ([super init]) {
        
        _identifier        = [NSString stringWithFormat:@"%lld",[dictionary[@"id"]longLongValue]];
        _name              = [CommonUtil isEmpty:dictionary[@"name"]]?@"":dictionary[@"name"];
        _title             = [CommonUtil isEmpty:dictionary[@"title"]]?@"":dictionary[@"title"];

        _title_alternative = [CommonUtil isEmpty:dictionary[@"title_alternative"]]?@"":dictionary[@"title_alternative"];
        _url               = [CommonUtil isEmpty:dictionary[@"url"]]?@"":dictionary[@"url"];
        _topics            = [NSString stringWithFormat:@"%lld",[dictionary[@"topics"]longLongValue]];


        _avatar_large      = [CommonUtil isEmpty:dictionary[@"avatar_large"]]?@"":dictionary[@"avatar_large"];
        _avatar_mini       = [CommonUtil isEmpty:dictionary[@"avatar_mini"]]?@"":dictionary[@"avatar_mini"];
        _avatar_normal     = [CommonUtil isEmpty:dictionary[@"avatar_normal"]]?@"":dictionary[@"avatar_normal"];
        
        
        
    }
    return self;
}

@end
