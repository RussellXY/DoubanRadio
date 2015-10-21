//
//  DRChannel.h
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-22.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRChannel : NSObject

@property (nonatomic,copy) NSString *name_en;
@property (nonatomic,copy) NSString *seq_id;
@property (nonatomic,copy) NSString *abbr_en;
@property (nonatomic,copy) NSString *name_ch;
@property (nonatomic) NSInteger channel_id;

@end
