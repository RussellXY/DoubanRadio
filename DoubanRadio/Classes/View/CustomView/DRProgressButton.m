//
//  DRProgressButton.m
//  DoubanRadio
//
//  Created by Russell.Y on 14-8-24.
//  Copyright (c) 2014年 RussellY. All rights reserved.
//

#import "DRProgressButton.h"
#import <pop/POP.h>

@interface DRProgressButton ()

@property (nonatomic) CAShapeLayer *progressLayer;
@property (nonatomic) CAShapeLayer *thumblayer;
@property (nonatomic) BOOL shouldRestart;

@end

@implementation DRProgressButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.shouldRestart = NO;
        
        self.progressLayer = [CAShapeLayer layer];
        self.progressLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CGRectGetMidX(self.bounds)].CGPath;
        //        self.progressLayer.position = CGPointMake(boundsOfProgress.size.width / 2, boundsOfProgress.size.height / 2);
        self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.progressLayer.fillColor = [UIColor clearColor].CGColor;
        self.progressLayer.lineWidth = 2.3;
        self.progressLayer.cornerRadius = 10;
        self.progressLayer.strokeStart = 0;
        self.progressLayer.strokeEnd = 0;
        self.progressProperty = 0;
        
        [self addObserver:self forKeyPath:@"progressProperty" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        [self.layer addSublayer:self.progressLayer];
        
        self.thumblayer = [CAShapeLayer layer];
        self.thumblayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 3.5, 3.5) cornerRadius:CGRectGetMidX(CGRectMake(0, 0, 3.5, 3.5))].CGPath;
        self.thumblayer.position = CGPointMake(self.bounds.size.width / 2 - 1.5, -0.5);
        self.thumblayer.strokeColor = [[UIColor whiteColor] CGColor];
        self.thumblayer.fillColor = [[UIColor whiteColor] CGColor];
        self.thumblayer.strokeEnd = 1;
        self.thumblayer.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self.layer addSublayer:self.thumblayer];
        
        
        self.layer.shadowColor = [UIColor blueColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(8.0, 8.0);
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.shouldRestart = NO;
        
        self.progressLayer = [CAShapeLayer layer];
        self.progressLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CGRectGetMidX(self.bounds)].CGPath;
//        self.progressLayer.position = CGPointMake(boundsOfProgress.size.width / 2, boundsOfProgress.size.height / 2);
        self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.progressLayer.fillColor = [UIColor clearColor].CGColor;
        self.progressLayer.lineWidth = 2.3;
        self.progressLayer.cornerRadius = 10;
        self.progressLayer.strokeStart = 0;
        self.progressLayer.strokeEnd = 0;
        self.progressProperty = 0;
        
        [self addObserver:self forKeyPath:@"progressProperty" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        [self.layer addSublayer:self.progressLayer];
        
        self.thumblayer = [CAShapeLayer layer];
        self.thumblayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 3.5, 3.5) cornerRadius:CGRectGetMidX(CGRectMake(0, 0, 3.5, 3.5))].CGPath;
        self.thumblayer.position = CGPointMake(self.bounds.size.width / 2 - 1.5, -0.5);
        self.thumblayer.strokeColor = [[UIColor whiteColor] CGColor];
        self.thumblayer.fillColor = [[UIColor whiteColor] CGColor];
        self.thumblayer.strokeEnd = 1;
        self.thumblayer.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self.layer addSublayer:self.thumblayer];
        
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1.5, 1.5);
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowRadius = 2;
    }
    
    return self;
}

-(void)setProgressProperty:(CGFloat)progressProperty{
    
    if (progressProperty > 0) {
        
        if (!self.shouldRestart) {
            
            _progressProperty = progressProperty;
        }
    }
}

-(CGPoint)getPositionOfThumbByStrokend:(CGFloat)strokend{
    
    CGFloat radius = CGRectGetMidY(self.bounds);
    CGFloat xPos,yPos;
    CGFloat angle = self.progressLayer.strokeEnd * 360 * M_PI / 180;
    
    xPos = sin(angle) * radius + radius - 1;
    yPos = radius - cos(angle) * radius - 1;
    
    return CGPointMake(xPos, yPos);
    
}

-(void)restartAnimationWithCompletion:(Completion)block{
    
    self.shouldRestart = YES;
    [self.progressLayer pop_removeAllAnimations];
    [self.thumblayer pop_removeAllAnimations];
    [self pop_removeAllAnimations];
    
//    POPBasicAnimation *restartAnimation = [POPBasicAnimation animation];
//    restartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    restartAnimation.duration = self.progressProperty > 0.4 ? 0.35 : 0.75;
//    
//    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"progressProperty" initializer:^(POPMutableAnimatableProperty *prop) {
//       
//        //read value
//        prop.readBlock = ^(id obj,CGFloat values[]){
//            
//            values[0] = [obj progressProperty];
//        };
//        
//        prop.writeBlock = ^(id obj,const CGFloat values[]){
//            [obj setProgressProperty:values[0]];
//        };
//        
//        prop.threshold = 0.01;
//    }];
//    
//    restartAnimation.property = prop;
//    restartAnimation.fromValue = @(self.progressProperty);
//    restartAnimation.toValue = @(0);
//    [self pop_addAnimation:restartAnimation forKey:@"restartAnimation"];
//    
//    [restartAnimation setCompletionBlock:^(POPAnimation *anim, BOOL flag) {
//            
//        if (flag) {
//            if (block) {
//                self.shouldRestart = NO;
//                self.progressLayer.strokeEnd = 0;
//                self.progressProperty = 0.0000001;//因为下面监听property时使用了old值所以这里设置两次
//                self.progressProperty = 0;
//                self.thumblayer.position = [self getPositionOfThumbByStrokend:0];
//                block();
//                
//            }
//        }
//    }];
    
    NSLog(@"===================");
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(resetProgressProperty:) userInfo:block repeats:YES];
    
    
}

#define THRESHOLD 1
-(void)resetProgressProperty:(NSTimer *)sender{
    
    Completion callBackBlock = sender.userInfo;
    
    if (self.progressProperty - 0.1 <= 0) {
        self.progressProperty = 0;
        self.shouldRestart = NO;
        self.progressLayer.strokeEnd = 0;
        self.thumblayer.position = [self getPositionOfThumbByStrokend:0];
        [sender invalidate];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            callBackBlock();
        });
        return;
    }
    
    _progressProperty -= 1;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"progressProperty"]) {
        
        CGFloat oldvalue = [[change objectForKey:@"old"] floatValue];
        CGFloat newvalue = [[change objectForKey:@"new"] floatValue];
        
//        if (ABS(newvalue - oldvalue) < 0.0) {
//            NSLog(@"--%f--",self.progressProperty);
//            return;
//        }
        
        CGPoint oldProgressPosition = [self getPositionOfThumbByStrokend:oldvalue / 100.];
        CGPoint progressPosition = [self getPositionOfThumbByStrokend:newvalue / 100.];
        
        POPBasicAnimation *thumbAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
        
        thumbAnimation.fromValue = [NSValue valueWithCGPoint:oldProgressPosition];
        thumbAnimation.toValue = [NSValue valueWithCGPoint:progressPosition];
        thumbAnimation.duration = 0.03;
        
        [self.thumblayer pop_addAnimation:thumbAnimation forKey:@"thumbAnimation"];
        
        POPBasicAnimation *strokeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        
        strokeAnimation.fromValue = @(oldvalue / 100.);
        strokeAnimation.toValue = @(newvalue / 100.);
        strokeAnimation.duration = 0.03;
        
        [self.progressLayer pop_addAnimation:strokeAnimation forKey:@"progressAnimation"];
        
        NSLog(@"%f",self.progressProperty);
    }
}

-(void)dealloc{
    
    [self.progressLayer removeObserver:self forKeyPath:@"strokeEnd"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
