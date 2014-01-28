//
//  THUser.h
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/27/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THUser : NSObject
@property (nonatomic, copy, readonly) NSString *description;
@property (nonatomic, strong, readonly) NSNumber *favoritesCount;
@property (nonatomic, strong, readonly) NSNumber *followersCount;
@property (nonatomic, strong, readonly) NSNumber *following;
@property (nonatomic, strong, readonly) NSNumber *friendsCount;
@property (nonatomic, copy, readonly) NSString *location;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSURL *profileBannerImageURL;
@property (nonatomic, strong, readonly) NSURL *profileImageURL;
@property (nonatomic, copy, readonly) NSString *screenName;

- (id)initWithJSON:(NSDictionary *)jsonDictionary;

@end
