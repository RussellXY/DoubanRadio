//
//  DRProgressButton.h
//  DoubanRadio
//
//  Created by Russell.Y on 14-8-24.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Completion)(void);

@interface DRProgressButton : UIButton

@property (nonatomic) CGFloat progressProperty;

-(void)restartAnimationWithCompletion:(Completion)block;

@end
