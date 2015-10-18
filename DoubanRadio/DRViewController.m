//
//  DRViewController.m
//  DoubanRadio
//
//  Created by (╯‵□′)╯︵┻━┻ on 14-8-22.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import "DRViewController.h"
#import "DRRadioManager.h"
#import "DRChannelCell.h"
#import "DRMusic.h"
#import "DRChannel.h"
#import "UITableView+Wave.h"
#import <UIImageView+LBBlurredImage.h>
#import <pop/POP.h>
#import "AFSoundManager.h"
#import "DRAppDelegate.h"
#import "PaperButton.h"
#import "DRChannelListViewController.h"


#define CHANNELVIEWWIDTH 120
#define CHANNELVIEWHEIGHT 180
#define RIGHTPADDING 25
#define TOPPADDING 5

static NSString *ChannelCellIdentifier = @"ChannelCellIdentifier";
static NSInteger currentMusicIndex;
static BOOL isFirstShow;

@interface DRViewController ()

@property (nonatomic,strong) NSArray *channels;
@property (nonatomic,strong) NSArray *musicsInChannel;
@property (nonatomic,strong) UITableView *channelTableView;
@property (nonatomic,strong) DRMusic *musicPlaying;
@property (nonatomic,strong) UIView *channelView;
@property (nonatomic) BOOL isChannelViewShow;
@property (nonatomic) CGRect frameOfChannel;
@property (nonatomic,strong) PaperButton *showChannelBtn;

@end

@implementation DRViewController

@synthesize channelView,frameOfChannel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)showChannels:(id)sender {
    
//    if (!self.isChannelViewShow) {
//        
//        [self.view addSubview:channelView];
//        
//        POPSpringAnimation *showAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
//        
//        showAnimation.fromValue = [NSValue valueWithCGRect:CGRectZero];
//        showAnimation.toValue = [NSValue valueWithCGRect:frameOfChannel];
//        
//        showAnimation.springBounciness = 14;
//        showAnimation.springSpeed = 10;
//        
//        [showAnimation setCompletionBlock:^(POPAnimation *anim, BOOL flag) {
//           
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [channelView addSubview:self.channelTableView];
//                [self.channelTableView reloadDataAnimateWithWave:1];
//                self.isChannelViewShow = YES;
//            });
//        }];
//        
//        [channelView pop_addAnimation:showAnimation forKey:@"channelViewShow"];
//    }else{
//        
//        
//        POPBasicAnimation *dismissAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
//        
//        dismissAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
//        
//        [dismissAnimation setCompletionBlock:^(POPAnimation *anim, BOOL flag) {
//            
//            [self.channelTableView removeFromSuperview];
//            [channelView removeFromSuperview];
//            self.isChannelViewShow = NO;
//        }];
//        
//        [channelView pop_addAnimation:dismissAnimation forKey:@"channelViewDismiss"];
//    }
    
    DRAppDelegate *delegate = (DRAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!self.isChannelViewShow) {
        
        [delegate.sideViewController showRightViewController:YES];
        self.isChannelViewShow = YES;
        
    }else{
    
        [delegate.sideViewController hideSideViewController:YES];
        self.isChannelViewShow = NO;
    }
    
   
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isFirstShow = NO;
    
    self.artistLabel.alpha = 0;
    self.songLabel.alpha = 0;
    self.publicYearLabel.alpha = 0;
    self.firstCurrentTimeLabel.alpha = 0;
    self.secondCurrentTimeLabel.alpha = 0;
    self.firstLastTimeLabel.alpha = 0;
    self.secondLastTimeLabel.alpha = 0;
    
    self.nextBtn.alpha = 0;
    self.pauseBtn.alpha = 0;
    self.downloadBtn.alpha = 0;
    
    self.downloadBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.downloadBtn.layer.shadowOffset = CGSizeMake(1.5, 1.5);
    self.downloadBtn.layer.shadowOpacity = 0.8;
    self.downloadBtn.layer.shadowRadius = 2;
    
    self.nextBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.nextBtn.layer.shadowOffset = CGSizeMake(1.5, 1.5);
    self.nextBtn.layer.shadowOpacity = 0.8;
    self.nextBtn.layer.shadowRadius = 2;
    
    self.firstCurrentTimeLabel = [[ADTickerLabel alloc] initWithFrame:CGRectMake(86, 336, 26, 21)];
    self.firstCurrentTimeLabel.font = [UIFont systemFontOfSize:12];
    self.firstCurrentTimeLabel.characterWidth = 8;
    self.firstCurrentTimeLabel.changeTextAnimationDuration = 0.5;
    self.firstCurrentTimeLabel.text = @"00";
    self.firstCurrentTimeLabel.shadowColor = [UIColor grayColor];
    self.firstCurrentTimeLabel.shadowOffset = CGSizeMake(1.5, 1.5);
    [self.view addSubview:self.firstCurrentTimeLabel];
    
    UILabel *firstColon = [[UILabel alloc] initWithFrame:CGRectMake(113.5, 333, 3, 21)];
    firstColon.textAlignment = NSTextAlignmentCenter;
    firstColon.font = [UIFont systemFontOfSize:12];
    firstColon.text = @":";
    [self.view addSubview:firstColon];
    
    self.secondCurrentTimeLabel = [[ADTickerLabel alloc] initWithFrame:CGRectMake(107, 336, 26, 21)];
    self.secondCurrentTimeLabel.font = [UIFont systemFontOfSize:12];
    self.secondCurrentTimeLabel.characterWidth = 8;
    self.secondCurrentTimeLabel.changeTextAnimationDuration = 0.5;
    self.secondCurrentTimeLabel.text = @"00";
    self.secondCurrentTimeLabel.shadowColor = [UIColor grayColor];
    self.secondCurrentTimeLabel.shadowOffset = CGSizeMake(1.5, 1.5);
    [self.view addSubview:self.secondCurrentTimeLabel];
    
    self.firstLastTimeLabel = [[ADTickerLabel alloc] initWithFrame:CGRectMake(184, 336, 26, 21)];
    self.firstLastTimeLabel.font = [UIFont systemFontOfSize:12];
    self.firstLastTimeLabel.characterWidth = 8;
    self.firstLastTimeLabel.changeTextAnimationDuration = 0.5;
    self.firstLastTimeLabel.text = @"00";
    self.firstLastTimeLabel.shadowColor = [UIColor grayColor];
    self.firstLastTimeLabel.shadowOffset = CGSizeMake(1.5, 1.5);
    [self.view addSubview:self.firstLastTimeLabel];
    
    UILabel *secondColon = [[UILabel alloc] initWithFrame:CGRectMake(211, 333, 3, 21)];
    secondColon.textAlignment = NSTextAlignmentCenter;
    secondColon.font = [UIFont systemFontOfSize:12];
    secondColon.text = @":";
    [self.view addSubview:secondColon];
    
    self.secondLastTimeLabel = [[ADTickerLabel alloc] initWithFrame:CGRectMake(204, 336, 26, 21)];
    self.secondLastTimeLabel.font = [UIFont systemFontOfSize:12];
    self.secondLastTimeLabel.characterWidth = 8;
    self.secondLastTimeLabel.changeTextAnimationDuration = 0.5;
    self.secondLastTimeLabel.text = @"00";
    self.secondLastTimeLabel.shadowColor = [UIColor grayColor];
    self.secondLastTimeLabel.shadowOffset = CGSizeMake(1.5, 1.5);
    [self.view addSubview:self.secondLastTimeLabel];
    
    [[DRRadioManager shareRadioManager] channelListWithCallBack:^(id obj) {
        
        self.channels = obj;

        DRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        DRChannelListViewController *channelViewController =  (DRChannelListViewController *)delegate.sideViewController.rightViewController;
        channelViewController.channels = obj;
    }];
    
    [[DRRadioManager shareRadioManager] musicsInChannel:0 callback:^(id obj) {
        self.musicsInChannel = obj;
        self.musicPlaying = self.musicsInChannel[0];
        
        [self playMusicAtIndex:0];
    }];
    
    self.showChannelBtn = [PaperButton button];
    [self.showChannelBtn addTarget:self action:@selector(showChannels:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:self.showChannelBtn];
    
    self.navigationItem.rightBarButtonItem = barButton;

    self.isChannelViewShow = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    channelView = [[UIView alloc] init];
    channelView.layer.anchorPoint = CGPointMake(1.0, 0.0);
    channelView.frame = CGRectMake(self.view.bounds.size.width - RIGHTPADDING - CHANNELVIEWWIDTH, self.topLayoutGuide.length + TOPPADDING, CHANNELVIEWWIDTH, CHANNELVIEWHEIGHT);
    
    channelView.backgroundColor = [UIColor whiteColor];
    
    channelView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    channelView.layer.shadowColor = [UIColor blackColor].CGColor;
    channelView.layer.shadowOpacity = 0.15;
    channelView.layer.cornerRadius = 6.0f;
    channelView.layer.masksToBounds = YES;
      
    self.channelTableView = [[UITableView alloc] initWithFrame:channelView.bounds];
    self.channelTableView.showsHorizontalScrollIndicator = NO;
    self.channelTableView.directionalLockEnabled = YES;
    self.channelTableView.bounces = NO;
    self.channelTableView.backgroundColor = [UIColor clearColor];
    self.channelTableView.layer.cornerRadius = 6.0f;
    self.channelTableView.layer.masksToBounds = YES;
    
    [self.channelTableView registerNib:[UINib nibWithNibName:@"DRChannelCell" bundle:nil] forCellReuseIdentifier:ChannelCellIdentifier];
    
    self.channelTableView.delegate = self;
    self.channelTableView.dataSource = self;
    
    frameOfChannel = channelView.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextMusic:(id)sender {
    
    [self.pauseBtn restartAnimationWithCompletion:^{
        
       dispatch_async(dispatch_get_main_queue(), ^{
           
           currentMusicIndex++;
           self.musicPlaying = self.musicsInChannel[currentMusicIndex];
           
           [self playMusicAtIndex:currentMusicIndex];
           
           self.firstCurrentTimeLabel.text = @"00";
           self.secondCurrentTimeLabel.text = @"00";
           self.firstLastTimeLabel.text = @"00";
           self.secondLastTimeLabel.text = @"00";
       });
    }];
    [self artistLabelDismissAnimation];
}

-(void)playMusicAtIndex:(NSInteger)index{
    
    currentMusicIndex = index;
    DRMusic *musicNeedPlay = self.musicsInChannel[currentMusicIndex];
    
    [[AFSoundManager sharedManager] startStreamingRemoteAudioFromURL:musicNeedPlay.musicURL andBlock:^(float percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        
        if (!isFirstShow) {
            [self playerButtonShowAnimation];
            [self artistShowUpWithMusic:musicNeedPlay delay:0];
            isFirstShow = YES;
            [self timeLabelShowAnimation];
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"mm:ss"];
        
        NSDate *eplapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
        NSString *eplapsedTimeDateString = [formatter stringFromDate:eplapsedTimeDate];
        self.firstCurrentTimeLabel.text = [eplapsedTimeDateString componentsSeparatedByString:@":"][0];
        self.secondCurrentTimeLabel.text = [eplapsedTimeDateString componentsSeparatedByString:@":"][1];
        
        NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
        NSString *timeRemainingDateString = [formatter stringFromDate:timeRemainingDate];
        
        if ([timeRemainingDateString isEqualToString:@"22:34"]) {
            timeRemainingDateString = @"00:00";
        }
        
        self.firstLastTimeLabel.text = [timeRemainingDateString componentsSeparatedByString:@":"][0];
        self.secondLastTimeLabel.text = [timeRemainingDateString componentsSeparatedByString:@":"][1];
        
        self.pauseBtn.progressProperty = percentage;
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.channels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DRChannelCell *cell = [self.channelTableView dequeueReusableCellWithIdentifier:ChannelCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row % 2 == 0) {
        
        cell.contentView.backgroundColor = [UIColor colorWithRed:236./255 green:243./255 blue:255./255 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    DRChannel *channel = self.channels[indexPath.row];
    
    cell.channelName.text = channel.name_ch;
    cell.channelCountLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    if (self.musicPlaying.channel_id == channel.channel_id) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.musicPlaying.pic]];
            UIImage *musicImage = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [cell.musicPlayingImage setImageToBlur:musicImage blurRadius:70 completionBlock:nil];
            });
        });
    }else{
        
        cell.musicPlayingImage.image = nil;
    }
    
    return cell;
}

-(void)artistShowUpWithMusic:(DRMusic *)music delay:(NSTimeInterval)delay{
    
    self.artistLabel.text = music.artist;
    self.songLabel.text = music.title;
    self.publicYearLabel.text = music.publicTime;
    [self artistLabelShowAnimationWithDelay:delay];
}

-(void)artistLabelShowAnimationWithDelay:(NSTimeInterval)delay{
    
    [self.artistLabel.layer removeAllAnimations];
    [self.songLabel.layer removeAllAnimations];
    [self.publicYearLabel.layer removeAllAnimations];
    
    POPBasicAnimation *artistLabelMoveAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    POPBasicAnimation *songLabelMoveAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    POPBasicAnimation *publicLabelMoveAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    artistLabelMoveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.artistLabel.center.x, self.artistLabel.center.y - 40)];
    artistLabelMoveAnimation.toValue = [NSValue valueWithCGPoint:self.artistLabel.center];
    artistLabelMoveAnimation.beginTime = CACurrentMediaTime() + delay;
    
    songLabelMoveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.songLabel.center.x - 40, self.songLabel.center.y)];
    songLabelMoveAnimation.toValue = [NSValue valueWithCGPoint:self.songLabel.center];
    songLabelMoveAnimation.beginTime = CACurrentMediaTime() + delay;
    
    publicLabelMoveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.publicYearLabel.center.y - 40, self.publicYearLabel.center.y)];
    publicLabelMoveAnimation.toValue = [NSValue valueWithCGPoint:self.publicYearLabel.center];
    publicLabelMoveAnimation.beginTime = CACurrentMediaTime() + delay;
    
    artistLabelMoveAnimation.duration = 0.2;
    songLabelMoveAnimation.duration = 0.2;
    publicLabelMoveAnimation.duration = 0.2;
    
    POPBasicAnimation *opacity = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    
    opacity.fromValue = @(0);
    opacity.toValue = @(1);
    opacity.beginTime = CACurrentMediaTime() + delay;
    
    opacity.duration = 0.2;
    
    [self.artistLabel.layer pop_addAnimation:artistLabelMoveAnimation forKey:@"artistLabelMoveAnimation"];
    [self.artistLabel pop_addAnimation:opacity forKey:@"artistLabelOpacityAnimation"];
    
    [self.songLabel.layer pop_addAnimation:songLabelMoveAnimation forKey:@"songLabelMoveAnimation"];
    [self.songLabel pop_addAnimation:opacity forKey:@"songLabelOpacityAnimation"];
    
    [self.publicYearLabel.layer pop_addAnimation:publicLabelMoveAnimation forKey:@"publicLabelMoveAnimation"];
    [self.publicYearLabel pop_addAnimation:opacity forKey:@"publicLabelOpacityAnimation"];
    
//    [self.currentTimeLabel pop_addAnimation:opacity forKey:@"currentTimeOpacityAnimation"];
//    [self.lastTimeLabel pop_addAnimation:opacity forKey:@"lastTimeOpacityAnimation"];
}

-(void)playerButtonShowAnimation{
    
    POPSpringAnimation *downloadBtnMoveAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    POPSpringAnimation *pauseBtnMoveAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    POPSpringAnimation *nextBtnMoveAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    
    downloadBtnMoveAnimation.fromValue = @(self.downloadBtn.frame.origin.y + 100);
    downloadBtnMoveAnimation.toValue = @(self.view.center.y);
//    downloadBtnMoveAnimation.duration = 0.4;
    downloadBtnMoveAnimation.velocity = @(20);
    downloadBtnMoveAnimation.springSpeed = 10;
    downloadBtnMoveAnimation.springBounciness = 18;
    
    pauseBtnMoveAnimation.fromValue = @(self.pauseBtn.frame.origin.y + 130);
    pauseBtnMoveAnimation.toValue = @(self.view.center.y);
//    pauseBtnMoveAnimation.duration = 0.4;
    pauseBtnMoveAnimation.velocity = @(40);
    pauseBtnMoveAnimation.springBounciness = 18;
    pauseBtnMoveAnimation.springSpeed = 10;
    
    nextBtnMoveAnimation.fromValue = @(self.nextBtn.frame.origin.y + 100);
    nextBtnMoveAnimation.toValue = @(self.view.center.y);
//    nextBtnMoveAnimation.duration = 0.4;
    nextBtnMoveAnimation.velocity = @(20);
    nextBtnMoveAnimation.springBounciness = 18;
    nextBtnMoveAnimation.springSpeed = 10;
    
    opacityAnimation.fromValue = @(0);
    opacityAnimation.toValue = @(1);
    opacityAnimation.duration = 0.4;
    
    [self.downloadBtn.layer pop_addAnimation:downloadBtnMoveAnimation forKey:@"downBtnMoveAnimation"];
    [self.downloadBtn pop_addAnimation:opacityAnimation forKey:@"downBtnOpacityAnimation"];
    
    [self.pauseBtn.layer pop_addAnimation:pauseBtnMoveAnimation forKey:@"pauseBtnMoveAnimation"];
    [self.pauseBtn pop_addAnimation:opacityAnimation forKey:@"pauseBtnOpacityAnimation"];
    
    [self.nextBtn.layer pop_addAnimation:nextBtnMoveAnimation forKey:@"nextBtnMoveAnimation"];
    [self.nextBtn pop_addAnimation:opacityAnimation forKey:@"nextBtnOpacityAnimation"];
}

-(void)timeLabelShowAnimation{
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        
        self.firstCurrentTimeLabel.alpha = 1;
        self.secondCurrentTimeLabel.alpha = 1;
        
        self.firstLastTimeLabel.alpha = 1;
        self.secondLastTimeLabel.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        self.firstCurrentTimeLabel.alpha = 1;
        self.secondCurrentTimeLabel.alpha = 1;
        
        self.firstLastTimeLabel.alpha = 1;
        self.secondLastTimeLabel.alpha = 1;
    }];
}


-(void)artistLabelDismissAnimation{
    
    CAKeyframeAnimation *artistLabelAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CAKeyframeAnimation *songLabelAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CAKeyframeAnimation *publicLabelAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CABasicAnimation *artistOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    CABasicAnimation *songOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    CABasicAnimation *publicOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    
    artistLabelAnimation.values = @[[NSValue valueWithCGPoint:self.artistLabel.center],[NSValue valueWithCGPoint:CGPointMake(self.artistLabel.center.x + 20, self.artistLabel.center.y)],[NSValue valueWithCGPoint:CGPointMake(0 - self.songLabel.frame.size.width, self.artistLabel.center.y)]];
    artistLabelAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    artistLabelAnimation.duration = 1.2;
    artistLabelAnimation.delegate = self;
    [artistLabelAnimation setValue:@"artistDismiss" forKey:@"tag"];
    artistLabelAnimation.removedOnCompletion = YES;
    
    songLabelAnimation.values = @[[NSValue valueWithCGPoint:self.songLabel.center],[NSValue valueWithCGPoint:CGPointMake(self.songLabel.center.x + 20, self.songLabel.center.y)],[NSValue valueWithCGPoint:CGPointMake(0 - self.songLabel.frame.size.width, self.songLabel.center.y)]];
    songLabelAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    songLabelAnimation.duration = 1.2;
    songLabelAnimation.beginTime = CACurrentMediaTime() + 0.2;
    songLabelAnimation.delegate = self;
    [songLabelAnimation setValue:@"songDismiss" forKey:@"tag"];
    songLabelAnimation.removedOnCompletion = YES;
    
    publicLabelAnimation.values = @[[NSValue valueWithCGPoint:self.publicYearLabel.center],[NSValue valueWithCGPoint:CGPointMake(self.publicYearLabel.center.x + 20, self.publicYearLabel.center.y)],[NSValue valueWithCGPoint:CGPointMake(0 - self.songLabel.frame.size.width, self.publicYearLabel.center.y)]];
    publicLabelAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    publicLabelAnimation.duration = 1.2;
    publicLabelAnimation.beginTime = CACurrentMediaTime() + 0.4;
    publicLabelAnimation.delegate = self;
    [publicLabelAnimation setValue:@"publicDismiss" forKey:@"tag"];
    publicLabelAnimation.removedOnCompletion = YES;
    
    artistOpacityAnimation.fromValue = @(1);
    artistOpacityAnimation.toValue = @(0);
    artistOpacityAnimation.duration = 1;
    artistOpacityAnimation.removedOnCompletion = YES;
    
    songOpacityAnimation.fromValue = @(1);
    songOpacityAnimation.toValue = @(0);
    songOpacityAnimation.duration = 1;
    songOpacityAnimation.beginTime = CACurrentMediaTime() + 0.15;
    songOpacityAnimation.removedOnCompletion = YES;
    
    publicOpacityAnimation.fromValue = @(1);
    publicOpacityAnimation.toValue = @(0);
    publicOpacityAnimation.duration = 1;
    publicOpacityAnimation.removedOnCompletion = YES;
    publicOpacityAnimation.beginTime = CACurrentMediaTime() + 0.35;
    
    
    [self.artistLabel.layer addAnimation:artistLabelAnimation forKey:@"artistLabelDismissAnimation"];
    [self.artistLabel.layer addAnimation:artistOpacityAnimation forKey:@"artistLabelDismissOpacityAnimation"];
    [self.songLabel.layer addAnimation:songLabelAnimation forKey:@"songLabelDismissAnimation"];
    [self.songLabel.layer addAnimation:songOpacityAnimation forKey:@"songLabelDismissOpacityAnimation"];
    [self.publicYearLabel.layer addAnimation:publicLabelAnimation forKey:@"publicLabelDismissAnimation"];
    [self.publicYearLabel.layer addAnimation:publicOpacityAnimation forKey:@"publicLabelDismissOpacityAnimation"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    static NSDictionary *dic;
    
    dic =  @{@"artistDismiss": self.artistLabel,@"songDismiss":self.songLabel,@"publicDismiss":self.publicYearLabel};
    
    NSString *tag = [anim valueForKey:@"tag"];
    
    UILabel *label = dic[tag];
    
    if (label) {
        label.layer.opacity = 0;
    }
    
    if ([tag isEqualToString:@"publicDismiss"]) {
        
        [self artistShowUpWithMusic:self.musicPlaying delay:0];
    }
}

@end
