//
//  THStatusTableViewController.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/28/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THStatusTableViewController.h"
#import "THUserTableViewController.h"

#import "THStatusView.h"

#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>

@interface THStatusTableViewController ()
@end

@implementation THStatusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupStatusView];
    [self setupTwitterAPI];
}

- (void)setupNavigationBar {
    self.navigationItem.title = [@"@" stringByAppendingString:self.status.user.screenName];
    
    UIBarButtonItem *profileButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStyleBordered target:self action:@selector(profileButtonPressed:)];
    self.navigationItem.rightBarButtonItem = profileButton;
}

- (void)setupStatusView {
    THUser *user = self.status.user;
    
    THStatusView *statusView = [[NSBundle mainBundle] loadNibNamed:@"THStatusView" owner:self options:nil].firstObject;
    [statusView.profileImageView setImageWithURL:user.profileImageURL placeholderImage:nil];
    statusView.nameLabel.text = user.name;
    statusView.userNameLabel.text = [@"@" stringByAppendingString:user.screenName];
    statusView.statusLabel.text = self.status.text;
    statusView.retweetsCountLabel.text = [NSString stringWithFormat:@"%d", [self.status.retweetCount intValue]];
    statusView.favoritesCountLabel.text = [NSString stringWithFormat:@"%d", [self.status.favoriteCount intValue]];
    
    // Add gesture to image view and labels
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

#pragma mark - Buttons pressed
- (void)profileButtonPressed:(id)sender {
    self.selectedUserName = self.status.user.screenName;

    THUserTableViewController *viewController = [[THUserTableViewController alloc] init];
    viewController.twitterAPI = self.twitterAPI;
    viewController.userName = self.selectedUserName;
    
    viewController.edgesForExtendedLayout=UIRectEdgeNone;
    viewController.extendedLayoutIncludesOpaqueBars=NO;
    viewController.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UserSegue"]) {
        THUserTableViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.twitterAPI = self.twitterAPI;
        destinationViewController.userName = self.selectedUserName;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Push a status table view controller to the navigation's view controller stack
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
