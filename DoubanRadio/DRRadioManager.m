//
//  DRRadioManager.m
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-22.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import "DRRadioManager.h"
#import "DRChannel.h"
#import "DRMusic.h"

static DRRadioManager *radioManager;

@implementation DRRadioManager

+(DRRadioManager *)shareRadioManager{
    
    if (radioManager == nil) {
        
        radioManager = [[DRRadioManager alloc] init];
    }
    
    return radioManager;
}

-(void)channelListWithCallBack:(CallBack)callback{
    
    NSMutableArray *result = [NSMutableArray array];
    
    NSString *path = @"http://www.douban.com/j/app/radio/channels";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        NSError *jsonError = nil;
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError != nil) {
            
            NSLog(@"Error with json data,Error is %@",jsonError);
            return;
        }
        
        NSLog(@"Success to download channel list");
        
        NSArray *channelArray = dataDic[@"channels"];
        
        for (NSDictionary *dic in channelArray) {
            
            DRChannel *channel = [[DRChannel alloc] init];
            
            channel.name_en = dic[@"name_en"];
            channel.seq_id = dic[@"seq_id"];
            channel.abbr_en = dic[@"abbr_en"];
            channel.name_ch = dic[@"name"];
            channel.channel_id = [dic[@"channel_id"] integerValue];
            
            [result addObject:channel];
        }
        
        callback([result copy]);
    }];
    
}

-(void)musicsInChannel:(NSInteger)channelId callback:(CallBack)callback{
    
    NSMutableArray *musicList = [NSMutableArray array];
    
    NSString *path = [NSString stringWithFormat:@"http://www.douban.fm/j/mine/playlist?channel=%ld",(long)channelId];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        NSError *jsonError = nil;
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError != nil) {
            NSLog(@"Error with json object,Error is %@",jsonError);
            return;
        }
        
        if (![dataDic respondsToSelector:@selector(objectForKey:)]) {
            return;
        }
        
        NSArray *musics = dataDic[@"song"];
        
        for (NSDictionary *dic in musics) {
            
            DRMusic *music = [[DRMusic alloc] init];
            
            music.album = dic[@"album"];
            music.pic = dic[@"picture"];
            music.ssid = dic[@"ssid"];
            music.artist = dic[@"artist"];
            music.musicURL = dic[@"url"];
            music.company = dic[@"company"];
            music.publicTime = dic[@"public_time"];
            music.title = dic[@"title"];
            music.length = [dic[@"length"] intValue];
            music.subtype = dic[@"subtype"];
            music.songlists_count = [dic[@"songlists_count"] integerValue];
            music.albumtitle = dic[@"albumtitle"];
            music.channel_id = channelId;
            
            [musicList addObject:music];
        }
        
        callback([musicList copy]);
        
    }];
}


@end
