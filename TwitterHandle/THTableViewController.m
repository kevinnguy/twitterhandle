//
//  THTableViewController.m
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/28/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "THTableViewController.h"

#import "THTableViewCell.h"

@interface THTableViewController ()<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
@property (nonatomic, strong) NSDate *today;
@end

@implementation THTableViewController

#define INFO 0
#define FAVORITE 1
#define RETWEET 0
#define REPLY 1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusArray = [NSMutableArray new];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"THTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CELL_IDENTIFIER];
    THTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    self.tableView.rowHeight = CGRectGetHeight(cell.frame);
}

- (void)reloadTableViewData {
    self.today = [NSDate date];
    [self.tableView reloadData];
}

- (NSString *)getTimeBetweenFromDate:(NSDate *)date {
    NSString *string;
    NSTimeInterval secondsBetween = [self.today timeIntervalSinceDate:date];
    int minutes = secondsBetween / 60;
    
    if (minutes < 60) {
        if (minutes == 0) {
            minutes = 1;
        }
        
        string = [NSString stringWithFormat:@"%dm", minutes];
    } else {
        int hours = minutes / 60;
        if (hours < 24) {
            string = [NSString stringWithFormat:@"%dh", hours];
        } else {
            int days = hours / 24;
            if (days < 365) {
                string = [NSString stringWithFormat:@"%dd", days];
            } else {
                int years = days / 365;
                string = [NSString stringWithFormat:@"%dy", years];
            }
        }
    }
    
    return string;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
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
    THStatus *status = self.statusArray[indexPath.row];
    [cell.userImageView setImageWithURL:status.user.profileImageURL placeholderImage:[UIImage imageNamed:@"twitter"]];
    
    NSString *statusText = status.text;
    for (NSDictionary *urlDictionary in status.urls) {
        statusText = [statusText stringByReplacingOccurrencesOfString:urlDictionary[@"url"] withString:urlDictionary[@"display_url"]];
    }
    cell.statusLabel.text = statusText;
    
    cell.timeLabel.text = [self getTimeBetweenFromDate:status.createdAt];
    
    return cell;
}

#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    if ([cell isKindOfClass:[THTableViewCell class]]) {
        if (index == INFO) {
            
        } else if (index == FAVORITE) {
            
        }
    }
    
    [cell hideUtilityButtonsAnimated:YES];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    if ([cell isKindOfClass:[THTableViewCell class]]) {
        if (index == RETWEET) {
            
        } else if (index == REPLY) {
            
        }
    }
    
    [cell hideUtilityButtonsAnimated:YES];
}

@end
