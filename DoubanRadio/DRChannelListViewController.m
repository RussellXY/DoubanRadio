//
//  DRChannelListViewController.m
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-27.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import "DRChannelListViewController.h"

static NSString *ChannelCellIdentifier = @"ChannelCellIdentifier";

@interface DRChannelListViewController ()

@end

@implementation DRChannelListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DRChannelCell" bundle:nil] forCellReuseIdentifier:ChannelCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.channels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DRChannelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ChannelCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row % 2 == 0) {
        
        cell.contentView.backgroundColor = [UIColor colorWithRed:236./255 green:243./255 blue:255./255 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    DRChannel *channel = self.channels[indexPath.row];
    
    cell.channelName.text = channel.name_ch;
    cell.channelCountLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    if (self.musicPlaying.channel_id == channel.channel_id) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.musicPlaying.pic]];
            UIImage *musicImage = [UIImage imageWithData:data];
            
            if (musicImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [cell.musicPlayingImage setImageToBlur:musicImage blurRadius:70 completionBlock:nil];
                });
            }
        });
    }else{
        
        cell.musicPlayingImage.image = nil;
    }
    
    return cell;
}

@end
