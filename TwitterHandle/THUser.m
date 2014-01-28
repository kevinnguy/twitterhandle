//
//  THUser.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/27/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THUser.h"

@implementation THUser

- (id)initWithJSON:(NSDictionary *)jsonDictionary {
    if (self = [super init]) {
        _description = jsonDictionary[@"description"];
        _favoritesCount = jsonDictionary[@"favourites_count"];
        _followersCount = jsonDictionary[@"followers_count"];
        _following = jsonDictionary[@"following"];
        _friendsCount = jsonDictionary[@"friends_count"];
        _location = jsonDictionary[@"location"];
        _name = jsonDictionary[@"name"];
        
        NSString *profileBannerImageURLString = jsonDictionary[@"profile_banner_url"];
        profileBannerImageURLString = [profileBannerImageURLString stringByAppendingString:@"/mobile"];
        _profileBannerImageURL = [NSURL URLWithString:profileBannerImageURLString];
        
        _profileImageURL = [NSURL URLWithString:jsonDictionary[@"profile_image_url_https"]];
        _screenName = jsonDictionary[@"screen_name"];
    }
    
    return self;
}
@end
