//
//  MemberModel.m
//  v2ex
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "MemberModel.h"
#import "CommonUtil.h"

@implementation MemberModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    
    if ([super init]) {
        
        _avatar_large  = [CommonUtil isEmpty:dictionary[@"avatar_large"]]?@"":dictionary[@"avatar_large"];
        _avatar_mini   = [CommonUtil isEmpty:dictionary[@"avatar_mini"]]?@"":dictionary[@"avatar_mini"];
        _avatar_normal = [CommonUtil isEmpty:dictionary[@"avatar_normal"]]?@"":dictionary[@"avatar_normal"];
        _tagline       = [CommonUtil isEmpty:dictionary[@"tagline"]]?@"":dictionary[@"tagline"];
        _username      = [CommonUtil isEmpty:dictionary[@"username"]]?@"":dictionary[@"username"];
        
        _identifier = [NSString stringWithFormat:@"%lld",[dictionary[@"id"]longLongValue]];
    }
    return self;
}

@end
