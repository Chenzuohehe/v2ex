//
//  UserInfo.m
//  v2ex
//
//  Created by ChenZuo on 16/8/9.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "UserInfo.h"
#import "CommonUtil.h"

@implementation UserInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    /**
     
     @property (copy , nonatomic) NSString * avatarLarge;
     @property (copy , nonatomic) NSString * github;
     @property (copy , nonatomic) NSString * identify;
     @property (copy , nonatomic) NSString * url;
     @property (copy , nonatomic) NSString * username;
     */
    if (self = [super init]) {
        //_content          = [CommonUtil isEmpty:dictionary[@"content"]]?@"":dictionary[@"content"];
        _avatarLarge = [CommonUtil isEmpty:dictionary[@"avatar_large"]]?@"":dictionary[@"avatar_large"];
        _github = [CommonUtil isEmpty:dictionary[@"github"]]?@"":dictionary[@"github"];
        _username = [CommonUtil isEmpty:dictionary[@"username"]]?@"":dictionary[@"username"];
        _url = [CommonUtil isEmpty:dictionary[@"url"]]?@"":dictionary[@"url"];
        _identify = [NSString stringWithFormat:@"%lld",[dictionary[@"id"] longLongValue]];
    }
    
    return self;
}

@end
