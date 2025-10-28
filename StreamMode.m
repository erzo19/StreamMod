#import "StreamMode.h"

@implementation StreamMode

+ (instancetype)sharedInstance {
    static StreamMode *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isStreamModeEnabled = NO;
        _hideTopLabel = NO;
    }
    return self;
}

- (void)enableStreamMode:(BOOL)enabled {
    _isStreamModeEnabled = enabled;
    [self updateUIForStreamMode];
}

- (void)setHideTopLabel:(BOOL)hide {
    _hideTopLabel = hide;
    [self updateUIForStreamMode];
}

- (void)registerSecureTextField:(UITextField *)textField {
    _secureTextField = textField;
    [self updateUIForStreamMode];
}

- (void)registerMenuTitleLabel:(UILabel *)label {
    _menuTitleLabel = label;
    [self updateUIForStreamMode];
}

- (void)updateUIForStreamMode {
    // Update secure text field
    if (_secureTextField) {
        _secureTextField.secureTextEntry = _isStreamModeEnabled;
    }
    
    // Update menu title visibility
    if (_menuTitleLabel) {
        _menuTitleLabel.hidden = _hideTopLabel;
    }
}

@end