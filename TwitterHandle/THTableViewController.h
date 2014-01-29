//
//  THTableViewController.h
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/28/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "THStatus.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface THTableViewController : UITableViewController
@property (nonatomic, strong) STTwitterAPI *twitterAPI;
@property (nonatomic, strong) NSMutableArray *statusArray;
@property (nonatomic, copy) NSString *selectedUserName;
@property (nonatomic, strong) THStatus *selectedStatus;

- (void)reloadTableViewData;
@end
