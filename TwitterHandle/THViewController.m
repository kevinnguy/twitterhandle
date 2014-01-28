//
//  THViewController.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/27/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THViewController.h"
#import "THTableViewCell.h"

#import "THStatus.h"

#import <STTwitter/STTwitter.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface THViewController () <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
@property (nonatomic, strong) NSMutableArray *timelineMutableArray;
@property (nonatomic, strong) UIAlertView *loginAlertView;
@property (nonatomic, strong) STTwitterAPI *twitterAPI;
@property (nonatomic, strong) NSDate *today;
@end

#define INFO 0
#define FAVORITE 1
#define RETWEET 0
#define REPLY 1

NSString * const kConsumerKey = @"6JYUzex0It4PQfWTiS4wCg";
NSString * const kConsumerSecret = @"sj4COCp51j0SZAWRE4MVlgtqwbS29P2S7SDLmGfN58U";
NSString * const kCellIdentifier = @"THTableViewCellIdentifier";

@implementation THViewController

- (void)viewDidLoad {
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
            [weakSelf reloadTableViewData];
        } errorBlock:^(NSError *error) {

        }];
    } errorBlock:^(NSError *error) {

    }];
}

- (void)reloadTableViewData {
    self.today = [NSDate date];
    [self.tableView reloadData];
}

#pragma mark - Button pressed
- (IBAction)meButtonPressed:(id)sender {
}

- (IBAction)composeButtonPressed:(id)sender {
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}



#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timelineMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // SWTableViewCell setup
    __weak THTableViewCell *weakCell = cell;
    [cell setAppearanceWithBlock:^{
        weakCell.containingTableView = tableView;
        
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [leftUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:230.0f/255.0f green:126.0f/255.0f blue:34.0f/255.0f alpha:1.0]
                                                    icon:[UIImage imageNamed:@"info"]];
        [leftUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:241.0f/255.0f green:196.0f/255.0f blue:15.0f/255.0f alpha:1.0]
                                                    icon:[UIImage imageNamed:@"favorite"]];
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:46.0f/255.0f green:204.0f/255.0f blue:113.0f/255.0f alpha:1.0]
                                                     icon:[UIImage imageNamed:@"retweet"]];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:52.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0]
                                                     icon:[UIImage imageNamed:@"reply"]];
        
        weakCell.leftUtilityButtons = leftUtilityButtons;
        weakCell.rightUtilityButtons = rightUtilityButtons;
        weakCell.delegate = self;
    } force:NO];
    [cell setCellHeight:cell.frame.size.height];
    
    // Setup data
    THStatus *status = [[THStatus alloc] initWithJSON:self.timelineMutableArray[indexPath.row]];
    [cell.userImageView setImageWithURL:status.user.profileImageURL placeholderImage:[UIImage imageNamed:@"twitter"]];
    
    NSString *statusText = status.text;
    for (NSDictionary *urlDictionary in status.urls) {
        statusText = [statusText stringByReplacingOccurrencesOfString:urlDictionary[@"url"] withString:urlDictionary[@"display_url"]];
    }
    cell.statusLabel.text = statusText;

    NSTimeInterval secondsBetween = [self.today timeIntervalSinceDate:status.createdAt];
    int minutes = secondsBetween / 60;
    cell.timeLabel.text = [NSString stringWithFormat:@"%dm", minutes];
    
    return cell;
}

#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    if ([cell isKindOfClass:[THTableViewCell class]]) {
        if (index == INFO) {
            
        } else if (index == FAVORITE) {
            
        }
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    if ([cell isKindOfClass:[THTableViewCell class]]) {
        if (index == RETWEET) {
            
        } else if (index == REPLY) {
            
        }
    }
}



@end
