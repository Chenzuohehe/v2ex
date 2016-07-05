//
//  MemberModel.h
//  v2ex
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (copy , nonatomic ) NSString * avatar_large;
@property (copy , nonatomic ) NSString * avatar_mini;
@property (copy , nonatomic ) NSString * avatar_normal;
@property (copy , nonatomic ) NSString * identifier;
@property (copy , nonatomic ) NSString * tagline;
@property (copy , nonatomic ) NSString * username;



@end
