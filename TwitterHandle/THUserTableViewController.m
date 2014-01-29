//
//  THUserTableViewController.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/28/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THUserTableViewController.h"

#import "THBannerView.h"

#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>

@interface THUserTableViewController ()

@end

@implementation THUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTwitterAPI];
}

- (void)setupTwitterAPI {
    __weak THUserTableViewController *weakSelf = self;
    [self.twitterAPI getUserTimelineWithScreenName:self.userName count:20 successBlock:^(NSArray *statuses) {
        for (NSDictionary *jsonDictionary in statuses) {
            THStatus *status = [[THStatus alloc] initWithJSON:jsonDictionary];
            [weakSelf.statusArray addObject:status];
        }
        
        // Setup banner view
        THStatus *status = weakSelf.statusArray.firstObject;
        THUser *user = status.user;
        THBannerView *bannerView = [[NSBundle mainBundle] loadNibNamed:@"THBannerView" owner:self options:nil].firstObject;
        
        [bannerView.bannerImageView setImageWithURL:user.profileBannerImageURL placeholderImage:nil];
        [bannerView.profileImageView setImageWithURL:user.profileImageURL placeholderImage:nil];
        bannerView.nameLabel.text = user.name;
        bannerView.screenNameLabel.text = user.screenName;
        bannerView.followersLabel.text = [NSString stringWithFormat:@"%d", [user.followersCount intValue]];
        bannerView.followingLabel.text = [NSString stringWithFormat:@"%d", [user.followersCount intValue]];
        bannerView.tweetsLabel.text = [NSString stringWithFormat:@"%d", [user.followersCount intValue]];
        
        [weakSelf.tableView addParallaxWithView:bannerView andHeight:bannerView.frame.size.height];
        [weakSelf reloadTableViewData];
    } errorBlock:^(NSError *error) {
        
    }];
}
@end
