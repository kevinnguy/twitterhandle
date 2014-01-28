//
//  THTableViewCell.h
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/27/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <SWTableViewCell/SWTableViewCell.h>

@interface THTableViewCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
