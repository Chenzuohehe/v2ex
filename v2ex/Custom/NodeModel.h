//
//  NodeModel.h
//  v2ex
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (copy , nonatomic ) NSString * identifier;
@property (copy , nonatomic ) NSString * name;
@property (copy , nonatomic ) NSString * title;
@property (copy , nonatomic ) NSString * title_alternative;
@property (copy , nonatomic ) NSString * url;
@property (copy , nonatomic ) NSString * topics;
@property (copy , nonatomic ) NSString * avatar_mini;
@property (copy , nonatomic ) NSString * avatar_normal;
@property (copy , nonatomic ) NSString * avatar_large;

@end
