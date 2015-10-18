//
//  DRMusic.h
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-22.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRMusic : NSObject

@property (nonatomic,copy) NSString *album;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *ssid;
@property (nonatomic,copy) NSString *artist;
@property (nonatomic,copy) NSString *musicURL;
@property (nonatomic,copy) NSString *company;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *publicTime;
@property (nonatomic) NSInteger length;
@property (nonatomic,copy) NSString *subtype;
@property (nonatomic) NSInteger songlists_count;
@property (nonatomic,copy) NSString *albumtitle;
@property (nonatomic) NSInteger channel_id;

@end
