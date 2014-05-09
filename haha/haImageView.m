//
//  haImageView.m
//  haha
//
//  Created by Cox, Chip on 5/9/14.
//  Copyright (c) 2014 merck. All rights reserved.
//

#import "haImageView.h"
@interface haImageView ()
@property (nonatomic,strong) UIView* soldView;
@property (nonatomic,strong) UIImageView* soldImgView;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravity;
@property (nonatomic) CGAffineTransform totalTransform;
@end

@implementation haImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
        [UIView animateWithDuration:1.0 delay:1 options: UIViewAnimationOptionTransitionNone animations:^{
            self.soldView.frame=CGRectMake(0, 0, 100, 100);
        }
                         completion:^(BOOL end) {}];
        
       // NSInteger delay=5;
        for (NSInteger delay=5;delay>0;delay--){
            [UIView animateWithDuration:2 delay:delay options:UIViewAnimationOptionTransitionNone animations:^{
                self.totalTransform=CGAffineTransformMakeRotation(M_PI/4);
                [self.soldView setTransform:self.totalTransform];
            }
            completion:^(BOOL end) {
            [UIView animateWithDuration:2 delay:delay options:UIViewAnimationOptionTransitionNone animations:^{
                self.totalTransform=CGAffineTransformRotate(self.totalTransform, -M_PI/4);
                [self.soldView setTransform:self.totalTransform];
            }
            completion:^(BOOL end) {}];
                             }];
        }
    }
    else{
        [self.soldView removeFromSuperview];
        self.soldView=nil;
    }
}

@end
