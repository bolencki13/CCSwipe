// ========== CLASSES ==========


@interface SBUserAgent : NSObject
+ (SBUserAgent *)sharedUserAgent;
- (void)lockAndDimDevice;
@end

@interface SpringBoard : UIApplication
- (UIApplication *)_accessibilityFrontMostApplication;
@end

@interface SBUIController
- (void)_toggleSwitcher;
- (_Bool)clickedMenuButton;
@end

@interface SBControlCenterController : UIViewController
+ (id)sharedInstance;
- (void)dismissAnimated:(_Bool)arg1;
@end