//
//  SinisterPrefsListController.h
//  SinisterPrefs
//
//  Created by Orangebananaspy on 21.05.2015.
//  Copyright (c) 2015 Orangebananaspy. All rights reserved.
//

#import "Headers/PSListController.h"
#import "Headers/PSSpecifier.h"
#import "Headers/PSTableCell.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

#import "NMRangeSlider.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define SCREEN ([UIScreen mainScreen].bounds)

@interface SinisterPrefsListController : PSListController
{
	UIView *headerView;
	CAGradientLayer *gradientLayer;
	UILabel *headerLabel;
}
@end

@interface SinisterPrefsSubController : PSListController {
    NMRangeSlider* rangeSlider;
    UILabel *lblmin;
    UILabel *lblmax;
    
    int rightValue;
    int leftValue;
    BOOL isReversed;
    BOOL isLS;
    NSUserDefaults *prefs;

}
@end

@interface SIDevCell : PSTableCell
{
	NSString *name;
	NSString *twitterName;
	NSString *jobTitle;

	UIView *imageStorage;
	UIImageView *_devImageView;
	UILabel *_devNameLabel;
	UILabel *_jobLabel;
	UILabel *_twitterLabel;
}
@end

@interface SinisterDevelopers : PSListController
@end