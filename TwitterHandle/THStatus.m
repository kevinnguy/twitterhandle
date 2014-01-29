//
//  THStatus.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/27/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THStatus.h"

@implementation THStatus

- (id)initWithJSON:(NSDictionary *)jsonDictionary {
    if (self = [super init]) {
        _statusId = jsonDictionary[@"id_str"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat: @"EEE MMM dd HH:mm:ss Z yyyy"];
        
        _createdAt = [dateFormatter dateFromString:jsonDictionary[@"created_at"]];

        NSDictionary *entities = jsonDictionary[@"entities"];
        _hashtags = entities[@"hashtags"];
        _symbols = entities[@"symbols"];
        _urls = entities[@"urls"];
        _userMentions = entities[@"user_mentions"];
        
        _favoriteCount = jsonDictionary[@"favorite_count"];
        _favorited = jsonDictionary[@"favorited"];
        _retweetCount = jsonDictionary[@"retweet_count"];
        _retweeted = jsonDictionary[@"retweeted"];
        _user = [[THUser alloc] initWithJSON:jsonDictionary[@"user"]];
        
        NSString *statusText = jsonDictionary[@"text"];
        for (NSDictionary *urlDictionary in _urls) {
            statusText = [statusText stringByReplacingOccurrencesOfString:urlDictionary[@"url"] withString:urlDictionary[@"display_url"]];
        }
        _text = statusText;

    }
    
    return self;
}
@end
