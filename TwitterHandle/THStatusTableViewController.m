//
//  THStatusTableViewController.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/28/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THStatusTableViewController.h"

#import "THStatusView.h"

#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>

@interface THStatusTableViewController ()

@end

@implementation THStatusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupStatusView];
    [self setupTwitterAPI];
}

- (void)setupStatusView {
    THUser *user = self.status.user;
    THStatusView *statusView = [[NSBundle mainBundle] loadNibNamed:@"THStatusView" owner:self options:nil].firstObject;
    [statusView.profileImageView setImageWithURL:user.profileImageURL placeholderImage:nil];
    statusView.nameLabel.text = user.name;
    statusView.userNameLabel.text = user.screenName;
    statusView.statusLabel.text = self.status.text;
    statusView.retweetsCountLabel.text = [NSString stringWithFormat:@"%d", [self.status.retweetCount intValue]];
    statusView.favoritesCountLabel.text = [NSString stringWithFormat:@"%d", [self.status.favoriteCount intValue]];
    
    [self.tableView addParallaxWithView:statusView andHeight:statusView.frame.size.height];
    [self reloadTableViewData];

}

- (void)setupTwitterAPI {
    __weak THStatusTableViewController *weakSelf = self;
    [self.twitterAPI getStatusesRetweetsForID:self.status.statusId count:@"20" trimUser:0 successBlock:^(NSArray *statuses) {
        for (NSDictionary *jsonDictionary in statuses) {
            THStatus *status = [[THStatus alloc] initWithJSON:jsonDictionary];
            [weakSelf.statusArray addObject:status];
        }
        
        [weakSelf reloadTableViewData];
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
