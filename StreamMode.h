#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StreamMode : NSObject

// Stream mode state
@property (nonatomic, assign) BOOL isStreamModeEnabled;
@property (nonatomic, assign) BOOL hideTopLabel;

// UI Elements that can be controlled
@property (nonatomic, weak) UITextField *secureTextField;
@property (nonatomic, weak) UILabel *menuTitleLabel;

// Singleton instance
+ (instancetype)sharedInstance;

// Control methods
- (void)enableStreamMode:(BOOL)enabled;
- (void)setHideTopLabel:(BOOL)hide;
- (void)registerSecureTextField:(UITextField *)textField;
- (void)registerMenuTitleLabel:(UILabel *)label;

// Update UI based on current stream mode state
- (void)updateUIForStreamMode;

@end

NS_ASSUME_NONNULL_END