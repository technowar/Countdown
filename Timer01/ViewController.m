//
//  ViewController.m
//  Timer01
//
//  Created by OSX on 3/1/13.
//  Copyright (c) 2013 OSX. All rights reserved.
//

#import "ViewController.h"

#import "JDFlipNumberView.h"
#import "JDDateCountdownFlipView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self showDateCountdown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDateCountdown;
{
    // setup flipview
    JDDateCountdownFlipView *flipView = [[JDDateCountdownFlipView alloc] initWithDayDigitCount:3];
    flipView.tag = 99;
    [self.view addSubview: flipView];
    
    // countdown to silvester
    NSDateComponents *currentComps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"dd.MM.yy HH:mm"];
    flipView.targetDate = [dateFormatter dateFromString:[NSString stringWithFormat: @"01.01.%d 00:00", currentComps.year+1]];
    
    // add info labels
    NSInteger posx = 20;
    for (NSInteger i=0; i<4; i++) {
        CGRect frame = CGRectMake(posx, 20, 200, 200);
        UILabel *label = [[UILabel alloc] initWithFrame: frame];
        label.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:12];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor darkGrayColor];
        label.text = (i==0) ? @"days" : (i==1) ? @"hours" : (i==2) ? @"minutes" : @"seconds";
        [label sizeToFit];
        label.frame = CGRectInset(label.frame, -4, -4);
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview: label];
        
        posx += label.frame.size.width + 10;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    JDFlipNumberView *flipView = (JDFlipNumberView*)[self.view viewWithTag: 99];
    if (!flipView) {
        return;
    }
    
    flipView.frame = CGRectInset(self.view.bounds, 20, 20);
    flipView.center = CGPointMake(floor(self.view.frame.size.width/2),
                                  floor((self.view.frame.size.height/2)*0.9));
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortrait;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutSubviews];
}


@end
