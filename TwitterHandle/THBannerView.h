//
//  THBannerView.h
//  TwitterHandle
//
//  Created by Kevin Nguy on 1/28/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THBannerView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;


@end
