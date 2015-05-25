#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CCSwipe.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define SCREEN ([UIScreen mainScreen].bounds)


%hook SBUIController
- (void)_showControlCenterGestureBeganWithLocation:(struct CGPoint)arg1 {

	NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.sinisterindustries.ccswipe"];
	BOOL ccswipeEnabled = [prefs boolForKey:@"ccswipeEnabled"];
	BOOL reverseEnabled = [prefs boolForKey:@"reverseEnabled"];
	BOOL lockHomescreenEnabled = [prefs boolForKey:@"lockHomescreenEnabled"];
	int leftTarget = [prefs integerForKey:@"leftBound"];
	int rightTarget = [prefs integerForKey:@"rightBound"];
	
    //scales numbers for landscape orientation
    if (ccswipeEnabled && UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        rightTarget = (rightTarget * SCREEN.size.height) / SCREEN.size.width;
        leftTarget = (leftTarget * SCREEN.size.height) / SCREEN.size.width;
    }

    if (ccswipeEnabled) {
        // left
        if (arg1.x < leftTarget) {
            if (reverseEnabled) {
                // go home / lock
                UIApplication *frontApp = ((SpringBoard *)[UIApplication sharedApplication])._accessibilityFrontMostApplication;
                if (lockHomescreenEnabled && frontApp == nil) {
                    // lock
                    [[%c(SBUserAgent) sharedUserAgent] lockAndDimDevice];
                }
                else {
                    // go home
                    [self clickedMenuButton];
                }
            }
            else {
                // open switcher
                [self _toggleSwitcher];
            }
            return;
        }
        // middle
        else if (arg1.x > leftTarget && arg1.x < rightTarget) {
            // activate cc normally
            %orig;
        }
        // right
        else if (arg1.x > rightTarget) {
            if (reverseEnabled) {
                // open switcher
                [self _toggleSwitcher];
            }
            else {
                // go home / lock
                UIApplication *frontApp = ((SpringBoard *)[UIApplication sharedApplication])._accessibilityFrontMostApplication;
                if (lockHomescreenEnabled && frontApp == nil) {
                    // lock
                    [[%c(SBUserAgent) sharedUserAgent] lockAndDimDevice];
                }
                else {
                    // go home
                    [self clickedMenuButton];
                }
            }
            return;
        }
    }
	else
		%orig;
}
%end