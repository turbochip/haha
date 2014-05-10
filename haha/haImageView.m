//
//  haImageView.m
//  haha
//
//  Created by Cox, Chip on 5/9/14.
//  Copyright (c) 2014 merck. All rights reserved.
//

#import "haImageView.h"
#import <AVFoundation/AVFoundation.h>

@interface haImageView ()
@property (nonatomic,strong) UIView* soldView;
@property (nonatomic,strong) UIImageView* soldImgView;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravity;
@property (nonatomic) UICollisionBehavior *collision;
@property (nonatomic) CGAffineTransform totalTransform;
@property (nonatomic,strong) AVAudioPlayer *crash;
@end

@implementation haImageView

- (id)initWithFrame:(CGRect)frame
{
    NSBundle *test;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        test=[NSBundle mainBundle];
        NSString *soundPath=[[NSBundle mainBundle] pathForResource:@"Car_Crash" ofType:@"aiff"];
        NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];
        self.crash = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
        BOOL soundStatus=[self.crash prepareToPlay];
        NSLog(@"soundStatus=%d",soundStatus);
    }
    return self;
}

- (BOOL) sold
{
    [self setNeedsDisplay];
    return _sold;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawSold];
}

- (UIView *) soldView
{
    if(!_soldView) _soldView=[[UIImageView alloc] initWithFrame:CGRectMake(700, 700, 700, 700)];
    return _soldView;
}

- (UIImageView *) soldImgView
{
    if(!_soldImgView)
    {
        _soldImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    }
    return _soldImgView;
}

- (UICollisionBehavior *) collision
{
    if(!_collision) {
        _collision=[[UICollisionBehavior alloc] init];
        [self.animator addBehavior:_collision];
    }
    return _collision;
}

- (UIGravityBehavior *) gravity
{
    if(!_gravity) {
        _gravity=[[UIGravityBehavior alloc] init];
        _gravity.magnitude=0.9;
        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

- (UIDynamicAnimator *) animator
{
    if(!_animator)
        _animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.soldView];
    return _animator;
}

- (void) drawSold
{
    UIImage* soldImg=[UIImage imageNamed:@"SoldWithTransparentBackground"];

    self.soldView.opaque=NO;
    if(self.sold)
    {
        self.soldImgView.image=soldImg;
        [self addSubview:self.soldView];
        [self.soldView addSubview:self.soldImgView];
        [UIView animateWithDuration:1.0 delay:0 options: UIViewAnimationOptionTransitionNone animations:^{
            self.soldView.frame=CGRectMake(50, 6, 100, 100);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
                self.totalTransform=CGAffineTransformMakeRotation(M_PI/4);
                [UIView setAnimationRepeatCount:3.5];
                [self.soldView setTransform:self.totalTransform];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    self.totalTransform=CGAffineTransformMakeRotation(M_PI/7);
                    [self.soldView setTransform:self.totalTransform];
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        self.soldView.frame=CGRectMake(50, 245,100, 100);
                        [self.crash play];
                        [self.soldView setTransform:self.totalTransform];
                    } completion:nil];
                }];
            }];
        [self.soldView setTransform:self.totalTransform];
        }];
    }
    else{
        [self.soldView removeFromSuperview];
        self.soldView=nil;
    }
}

@end
