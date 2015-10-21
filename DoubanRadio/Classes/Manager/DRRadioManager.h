//
//  DRRadioManager.h
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-22.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(id obj);

@interface DRRadioManager : NSObject

+(DRRadioManager *)shareRadioManager;

-(void)channelListWithCallBack:(CallBack)callback;

-(void)musicsInChannel:(NSInteger)channelId callback:(CallBack)callback;

@end
