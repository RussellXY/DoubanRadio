//
//  DRViewController.h
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-22.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRProgressButton.h"
#import "ADTickerLabel.h"

@interface DRViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicYearLabel;
@property (strong, nonatomic) ADTickerLabel *firstCurrentTimeLabel;
@property (nonatomic,strong) ADTickerLabel *secondCurrentTimeLabel;
@property (strong, nonatomic) ADTickerLabel *firstLastTimeLabel;
@property (nonatomic,strong) ADTickerLabel *secondLastTimeLabel;
@property (weak, nonatomic) IBOutlet DRProgressButton *pauseBtn;

@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@end
