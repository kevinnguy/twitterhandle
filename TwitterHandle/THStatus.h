//
//  THStatus.h
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/27/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THUser.h"
@interface THStatus : NSObject
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong, readonly) NSArray *hashtags;
@property (nonatomic, strong, readonly) NSArray *symbols;
@property (nonatomic, strong, readonly) NSArray *urls;
@property (nonatomic, strong, readonly) NSArray *userMentions;
@property (nonatomic, strong, readonly) NSNumber *favoriteCount;
@property (nonatomic, strong, readonly) NSNumber *favorited;
@property (nonatomic, strong, readonly) NSNumber *retweetCount;
@property (nonatomic, strong, readonly) NSNumber *retweeted;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, strong, readonly) THUser *user;

- (id)initWithJSON:(NSDictionary *)jsonDictionary;
@end
