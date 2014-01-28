//
//  THViewController.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/27/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THViewController.h"
#import "THTableViewCell.h"

#import <STTwitter/STTwitter.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface THViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *timelineMutableArray;
@property (nonatomic, strong) UIAlertView *loginAlertView;
@property (nonatomic, strong) STTwitterAPI *twitterAPI;
@end

NSString * const kConsumerKey = @"6JYUzex0It4PQfWTiS4wCg";
NSString * const kConsumerSecret = @"sj4COCp51j0SZAWRE4MVlgtqwbS29P2S7SDLmGfN58U";
NSString * const kCellIdentifier = @"THTableViewCellIdentifier";

@implementation THViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupTableView];
    [self setupTwitterAPI];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"THTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
    THTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    self.tableView.rowHeight = CGRectGetHeight(cell.frame);
}

- (void)setupTwitterAPI {
    self.twitterAPI = [STTwitterAPI twitterAPIOSWithFirstAccount];
    
    __weak THViewController *weakSelf = self;
    [self.twitterAPI verifyCredentialsWithSuccessBlock:^(NSString *username) {
        // Get messages
        [weakSelf.twitterAPI getHomeTimelineSinceID:nil count:100 successBlock:^(NSArray *statuses) {
            weakSelf.timelineMutableArray = [statuses mutableCopy];
            [weakSelf.tableView reloadData];
        } errorBlock:^(NSError *error) {

        }];
    } errorBlock:^(NSError *error) {

    }];
}

#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timelineMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    NSDictionary *statusDictionary = self.timelineMutableArray[indexPath.row];
    NSDictionary *entitiesDictionary = statusDictionary[@"entities"];
    NSDictionary *urlsArray = entitiesDictionary[@"urls"];
    NSDictionary *userDictionary = statusDictionary[@"user"];
    NSURL *imageURL = [NSURL URLWithString:userDictionary[@"profile_image_url_https"]];
    NSString *status = statusDictionary[@"text"];
    
    for (NSDictionary *urlDictionary in urlsArray) {
        status = [status stringByReplacingOccurrencesOfString:urlDictionary[@"url"] withString:urlDictionary[@"display_url"]];
    }
    
    [cell.userImageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"twitter"]];
    cell.statusLabel.text = status;
    
    return cell;
}



@end
