//
//  DRChannelCell.h
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-22.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRChannelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *musicPlayingImage;
@property (weak, nonatomic) IBOutlet UILabel *channelName;
@property (weak, nonatomic) IBOutlet UILabel *channelCountLabel;

@end
