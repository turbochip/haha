//
//  haViewController.m
//  haha
//
//  Created by Cox, Chip on 5/9/14.
//  Copyright (c) 2014 merck. All rights reserved.
//

#import "haViewController.h"
#import "haImageView.h"

@interface haViewController ()
@property (nonatomic,strong) haImageView* ctGirl;
@end

@implementation haViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self drawBackground];
}

- (void) drawBackground
{
    UIImage* coppertone=[UIImage imageNamed:@"coppertone"];
    
    UIImageView* ctImage=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x+20, self.view.frame.origin.y+20,self.view.frame.size.width-40, self.view.frame.size.height-60)];
    [ctImage setImage:coppertone];
    
    self.ctGirl=[[haImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x+20, self.view.frame.origin.y+20,self.view.frame.size.width-40, self.view.frame.size.height-60)];
    
    self.ctGirl.userInteractionEnabled=YES;
    self.ctGirl.opaque=NO;
    self.ctGirl.alpha=1;
    [self.view addSubview:ctImage];
    [self.view addSubview:self.ctGirl];
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CoppertoneTap:)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [self.ctGirl addGestureRecognizer:tap];
}

- (IBAction)CoppertoneTap:(id)sender
{
    NSLog(@"got into tap recognizer %@",[sender description] );
    self.ctGirl.sold=!self.ctGirl.sold;
    [self.ctGirl setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
