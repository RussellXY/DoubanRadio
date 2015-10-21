//
//  DRChannelListViewController.h
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-27.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRChannel.h"
#import "DRChannelCell.h"
#import "UITableView+Wave.h"
#import <UIImageView+LBBlurredImage.h>
#import "DRMusic.h"

@interface DRChannelListViewController : UITableViewController

@property (nonatomic,strong) NSArray *channels;
@property (nonatomic,strong) DRMusic *musicPlaying;

@end
