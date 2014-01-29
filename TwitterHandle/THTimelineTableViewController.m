//
//  THTimelineTableViewController.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/28/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THTimelineTableViewController.h"
#import "THUserTableViewController.h"
#import "THStatusTableViewController.h"

@interface THTimelineTableViewController ()
@property (nonatomic, strong) UIAlertView *loginAlertView;
@end

@implementation THTimelineTableViewController

NSString * const kConsumerKey = @"6JYUzex0It4PQfWTiS4wCg";
NSString * const kConsumerSecret = @"sj4COCp51j0SZAWRE4MVlgtqwbS29P2S7SDLmGfN58U";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTwitterAPI];
}

- (void)setupTwitterAPI {
    self.twitterAPI = [STTwitterAPI twitterAPIOSWithFirstAccount];
    
    __weak THTimelineTableViewController *weakSelf = self;
    [self.twitterAPI verifyCredentialsWithSuccessBlock:^(NSString *username) {
        // Get messages
        [weakSelf.twitterAPI getHomeTimelineSinceID:nil count:100 successBlock:^(NSArray *statuses) {
            for (NSDictionary *jsonDictionary in statuses) {
                THStatus *status = [[THStatus alloc] initWithJSON:jsonDictionary];
                [weakSelf.statusArray addObject:status];
            }

            [weakSelf reloadTableViewData];
        } errorBlock:^(NSError *error) {
            
        }];
    } errorBlock:^(NSError *error) {
        
    }];
}

- (IBAction)meButtonPressed:(id)sender {
    self.selectedUserName = self.twitterAPI.userName;
    [self performSegueWithIdentifier:@"UserSegue" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UserSegue"]) {
        THUserTableViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.twitterAPI = self.twitterAPI;
        destinationViewController.userName = self.selectedUserName;
    } else if ([segue.identifier isEqualToString:@"StatusSegue"]) {
        THStatusTableViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.twitterAPI = self.twitterAPI;
        destinationViewController.status = self.selectedStatus;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedStatus = self.statusArray[indexPath.row];
    [self performSegueWithIdentifier:@"StatusSegue" sender:self];
}

@end
