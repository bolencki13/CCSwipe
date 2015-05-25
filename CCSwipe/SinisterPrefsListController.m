//
//  SinisterPrefsListController.m
//  SinisterPrefs
//
//  Created by Orangebananaspy on 21.05.2015.
//  Copyright (c) 2015 Orangebananaspy. All rights reserved.
//

#import "SinisterPrefsListController.h"

#define TweakName "CCSwipe"

#define BundlePath "/Library/PreferenceBundles/CCSwipe.bundle/"

@implementation SinisterPrefsListController

- (UIColor *)defaultOrange {
	return [UIColor colorWithRed:1 green:0.565 blue:0.098 alpha:1];/*#ff9019*/
}

- (UIColor *)defaultLightGray {
	return [UIColor colorWithRed:0.357 green:0.388 blue:0.408 alpha:1];/*#5b6368*/
}

- (UIColor *)defaultDarkGray {
	return [UIColor colorWithRed:0.271 green:0.294 blue:0.306 alpha:1];/*#454b4e*/
}

//Runs when the view is about to disappear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //Removing the tint so it doesn't tint the entire Settings application
	[UIApplication sharedApplication].keyWindow.tintColor = nil;
}

//Runs whenever view subviews needs to update
- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	//Adding tint to the current window so any buttons, slider will be this color
	[UIApplication sharedApplication].keyWindow.tintColor = [self defaultOrange];
	
	//Changing UISwitch tint color
	[UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [self defaultOrange];
	
	//Changing the boring grey text
	[UILabel appearanceWhenContainedIn:self.class, nil].textColor = [self defaultOrange];
	
	headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    gradientLayer.frame = headerView.bounds;
	headerLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
}

- (void)loadView {
    [super loadView];
	
	headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
	[self->_table addSubview:headerView];
	
	/**
	//uncomment if you want to use gradient...
	gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = headerView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[self defaultLightGray]CGColor], (id)[[self defaultDarkGray]CGColor], nil];
	[headerView.layer insertSublayer:gradientLayer atIndex:0];
	**/
	
	headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
	[headerLabel setFont:[UIFont systemFontOfSize:24]];
	[headerLabel setText:@TweakName];
	[headerLabel setBackgroundColor:[UIColor clearColor]];
	[headerLabel setTextColor:[self defaultOrange]];
	[headerLabel setTextAlignment:NSTextAlignmentCenter];
	[headerView addSubview:headerLabel];
}

//"Views settings and layouts" from the plist, only runs once at start
- (id)specifiers {
	if(_specifiers == nil)
	{
		_specifiers = [self loadSpecifiersFromPlistName:@"CCSwipePrefs" target:self];
		
		//Setting navigation title
		UIImage *navIconImage = [[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/navicon.png", @BundlePath]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		UIImageView *navIconImageView = [[UIImageView alloc] initWithImage:navIconImage];
		navIconImageView.frame = CGRectMake(0, 0, 30, 30);
		navIconImageView.tintColor = [self defaultOrange];
		navIconImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.navigationItem setTitleView:navIconImageView];
		
		//Setting heart image
		UIImage *heartImage = [[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/heart.png", @BundlePath]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		UIButton *heartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		heartButton.frame = CGRectMake(0, 0, 20, 20);
		[heartButton setBackgroundImage:heartImage forState:UIControlStateNormal];
		heartButton.tintColor = [self defaultOrange];
		[heartButton addTarget:self action:@selector(heartBeat) forControlEvents:UIControlEventTouchUpInside];
		[heartButton setShowsTouchWhenHighlighted:YES];
	
		UIBarButtonItem *heartBarButton = [[UIBarButtonItem alloc] initWithCustomView:heartButton];
		UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		negativeSpacer.width = 0;
		[self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, heartBarButton, nil] animated:NO];		
	}
    
	return _specifiers;
}

- (void)heartBeat {
    SLComposeViewController *twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    if (twitter != nil)
    {
        [twitter setInitialText:[NSString stringWithFormat:@"I love #%@ by @SinisterDevTeam!", @TweakName]];
        [[self navigationController] presentViewController:twitter animated:YES completion:nil];
        
    }
}

@end

@implementation SinisterPrefsSubController

- (UIColor *)defaultOrange {
	return [UIColor colorWithRed:1 green:0.565 blue:0.098 alpha:1];/*#ff9019*/
}

//Runs whenever view subviews needs to update
- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	//Adding tint to the current window so any buttons, slider will be this color
	[UIApplication sharedApplication].keyWindow.tintColor = [self defaultOrange];
	
	//Changing UISwitch tint color
	[UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [self defaultOrange];
	
	//Changing the boring grey text
	[UILabel appearanceWhenContainedIn:self.class, nil].textColor = [self defaultOrange];
}

//"Views settings and layouts" from the plist, only runs once at start
- (id)specifiers {
	if(_specifiers == nil)
	{
		_specifiers = [self loadSpecifiersFromPlistName:@"SinisterSubPrefs" target:self];
		
		//Setting navigation title
		UIImage *navIconImage = [[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/navicon.png", @BundlePath]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		UIImageView *navIconImageView = [[UIImageView alloc] initWithImage:navIconImage];
		navIconImageView.frame = CGRectMake(0, 0, 30, 30);
		navIconImageView.tintColor = [self defaultOrange];
		navIconImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.navigationItem setTitleView:navIconImageView];
	}
    
	return _specifiers;
}

- (void)loadView {
    [super loadView];
    [self setUpAndGetSaved];
    [self setupHeader];
}
- (void)setupHeader {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN.size.width,100)];
    [self.table setTableHeaderView:headerView];
    
    rangeSlider = [[NMRangeSlider alloc] initWithFrame:CGRectMake(15, 60, SCREEN.size.width-30, 34)];
    rangeSlider.minimumValue = 0;
    rangeSlider.maximumValue = SCREEN.size.width;
    rangeSlider.minimumRange = 50;
    rangeSlider.lowerValue = SCREEN.size.width/3;
    rangeSlider.upperValue = (SCREEN.size.width/3)*2;
    [rangeSlider addTarget:self action:@selector(updateSliderLabels) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:rangeSlider];
    
    if (IS_OS_8_OR_LATER == YES) {
        rangeSlider.frame = CGRectOffset(rangeSlider.frame,0,60);
    }
    
    [rangeSlider setLowerValue:leftValue upperValue:rightValue animated:YES];
    
    lblmax = [[UILabel alloc] initWithFrame:CGRectMake(0,0,25,25)];
    [self.view addSubview:lblmax];
    lblmin = [[UILabel alloc] initWithFrame:CGRectMake(0,0,25,25)];
    [self.view addSubview:lblmin];
    
    rightValue = (int)rangeSlider.upperValue;
    leftValue = (int)rangeSlider.lowerValue;
    
    CGPoint lowerCenter;
    lowerCenter.x = (rangeSlider.lowerCenter.x + rangeSlider.frame.origin.x);
    lowerCenter.y = (rangeSlider.center.y - 30.0f);
    lblmin.center = lowerCenter;
    lblmin.text = [NSString stringWithFormat:@"%d", leftValue];
    [lblmin sizeToFit];
    
    CGPoint upperCenter;
    upperCenter.x = (rangeSlider.upperCenter.x + rangeSlider.frame.origin.x);
    upperCenter.y = (rangeSlider.center.y - 30.0f);
    lblmax.center = upperCenter;
    lblmax.text = [NSString stringWithFormat:@"%d", rightValue];
    [lblmax sizeToFit];
}

#pragma mark - Custom Slider
- (void)updateSliderLabels {
    rightValue = (int)rangeSlider.upperValue;
    leftValue = (int)rangeSlider.lowerValue;
    
    CGPoint lowerCenter;
    lowerCenter.x = (rangeSlider.lowerCenter.x + rangeSlider.frame.origin.x);
    lowerCenter.y = (rangeSlider.center.y - 30.0f);
    lblmin.center = lowerCenter;
    lblmin.text = [NSString stringWithFormat:@"%d", leftValue];
    [lblmin sizeToFit];
    
    CGPoint upperCenter;
    upperCenter.x = (rangeSlider.upperCenter.x + rangeSlider.frame.origin.x);
    upperCenter.y = (rangeSlider.center.y - 30.0f);
    lblmax.center = upperCenter;
    lblmax.text = [NSString stringWithFormat:@"%d", rightValue];
    [lblmax sizeToFit];
    
    [self saveValues];
}

#pragma mark - NSUserDefaults
- (void)setUpAndGetSaved {
    prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.sinisterindustries.ccswipe"];
    [prefs registerDefaults:@{
                              @"rightBound" : [NSNumber numberWithInt:(int)((SCREEN.size.width/3)*2)],
                              @"leftBound" : [NSNumber numberWithInt:(int)(SCREEN.size.width/3)],
                              @"reverseEnabled" : @NO,
                              @"lockHomescreenEnabled" : @NO,
                              }];
    
    
    rightValue = [prefs  integerForKey:@"rightBound"];
    leftValue = [prefs integerForKey:@"leftBound"];
    isReversed = [prefs boolForKey:@"reverseEnabled"];
    isLS = [prefs boolForKey:@"lockHomescreenEnabled"];
}
- (void)saveValues {
    [prefs setInteger:(int)rangeSlider.upperValue forKey:@"rightBound"];
    [prefs setInteger:(int)rangeSlider.lowerValue forKey:@"leftBound"];
    [prefs setBool:isReversed forKey:@"reverseEnabled"];
    [prefs setBool:isLS forKey:@"lockHomescreenEnabled"];
    [prefs synchronize];
}
@end

@implementation SIDevCell

- (instancetype)initWithStyle:(int)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier
{
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self)
	{
		twitterName = [specifier.properties[@"twitterName"] copy];
		name = [specifier.properties[@"name"] copy];
		jobTitle = [specifier.properties[@"jobTitle"] copy];
        
		_devNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, -6, [[UIScreen mainScreen] bounds].size.width-95, 20)];
		_devNameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[_devNameLabel setText:[NSString stringWithFormat:@"%@", name]];
		[_devNameLabel setBackgroundColor:[UIColor clearColor]];
		[_devNameLabel setTextColor:[UIColor blackColor]];
		[_devNameLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:18]];
		[self.contentView addSubview:_devNameLabel];

		_twitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 15, [[UIScreen mainScreen] bounds].size.width-95, 20)];
		_twitterLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[_twitterLabel setText:[NSString stringWithFormat:@"@%@", twitterName]];
		[_twitterLabel setBackgroundColor:[UIColor clearColor]];
		[_twitterLabel setTextColor:[UIColor darkGrayColor]];
		[_twitterLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:13]];
		[self.contentView addSubview:_twitterLabel];

		_jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 33, [[UIScreen mainScreen] bounds].size.width-(_jobLabel.frame.origin.x), 20)];
		_jobLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[_jobLabel setText:jobTitle];
		[_jobLabel setTextColor:[UIColor grayColor]];
		[_jobLabel setBackgroundColor:[UIColor clearColor]];
		[_jobLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:13]];
		[self.contentView addSubview:_jobLabel];

		imageStorage = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 70, 70)];
		imageStorage.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		imageStorage.center = CGPointMake(imageStorage.center.x, self.contentView.frame.size.height / 2);
		imageStorage.userInteractionEnabled = NO;
		imageStorage.clipsToBounds = YES;
		imageStorage.layer.cornerRadius = 70/2;
		[self.contentView addSubview:imageStorage];

		_devImageView = [[UIImageView alloc] initWithFrame:imageStorage.bounds];
		_devImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", @BundlePath, [specifier.properties[@"devImage"] copy]]];
		_devImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_devImageView.userInteractionEnabled = NO;
		[imageStorage addSubview:_devImageView];
	}

	return self;
}

- (void)follow:(NSString *)user
{
	if(user)
	{
		NSURL *twitterLink = nil;

		if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]])
		{
			twitterLink = [NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:user]];
		} 
		else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific://"]]) 
		{
			twitterLink = [NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:user]];
		}  
		else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) 
		{
			twitterLink = [NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:user]];
		} 
		else 
		{
			twitterLink = [NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:user]];
		}

		[[UIApplication sharedApplication] openURL:twitterLink];
	}
}

- (void)setSelected:(BOOL)pressed animated:(BOOL)anim
{
	if(!pressed)
	{
		[super setSelected:pressed animated:anim];
		return;
	}
	
	[self follow:twitterName];
}
@end

@implementation SinisterDevelopers

- (UIColor *)defaultOrange
{
	return [UIColor colorWithRed:1 green:0.565 blue:0.098 alpha:1];/*#ff9019*/
}

//Runs whenever view subviews needs to update
- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	//Adding tint to the current window so any buttons, slider will be this color
	[UIApplication sharedApplication].keyWindow.tintColor = [self defaultOrange];
	
	//Changing UISwitch tint color
	[UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = [self defaultOrange];
	
	//Changing the boring grey text
	[UILabel appearanceWhenContainedIn:self.class, nil].textColor = [self defaultOrange];
}

//"Views settings and layouts" from the plist, only runs once at start
- (id)specifiers
{
	if(_specifiers == nil)
	{
		_specifiers = [self loadSpecifiersFromPlistName:@"SinisterDevs" target:self];
		
		//Setting navigation title
		UIImage *navIconImage = [[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/navicon.png", @BundlePath]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		UIImageView *navIconImageView = [[UIImageView alloc] initWithImage:navIconImage];
		navIconImageView.frame = CGRectMake(0, 0, 30, 30);
		navIconImageView.tintColor = [self defaultOrange];
		navIconImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.navigationItem setTitleView:navIconImageView];
	}
    
	return _specifiers;
}

@end