//
//  THUserTableViewController.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/28/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THUserTableViewController.h"
#import "THStatusTableViewController.h"

#import "THBannerView.h"

#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>

@interface THUserTableViewController ()

@end

@implementation THUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [@"@" stringByAppendingString:self.userName];
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
        bannerView.descriptionLabel.text = user.description;
        
        [weakSelf.tableView addParallaxWithView:bannerView andHeight:bannerView.frame.size.height];
        [weakSelf reloadTableViewData];
    } errorBlock:^(NSError *error) {
        
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"StatusSegue"]) {
        THStatusTableViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.twitterAPI = self.twitterAPI;
        destinationViewController.status = self.selectedStatus;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedStatus = self.statusArray[indexPath.row];

    THStatusTableViewController *viewController = [[THStatusTableViewController alloc] init];
    
    viewController.twitterAPI = self.twitterAPI;
    viewController.status = self.selectedStatus;
    
    viewController.edgesForExtendedLayout=UIRectEdgeNone;
    viewController.extendedLayoutIncludesOpaqueBars=NO;
    viewController.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
