#import <UIKit/UIKit.h>
#import "StreamMode.h"
#import "StreamModeImGui.h"

// Bridge between C++ ImGui and Objective-C StreamMode
@interface StreamModeIntegration : NSObject

+ (void)initializeStreamMode;
+ (void)updateStreamModeFromImGui;
+ (void)registerUIElements:(UITextField *)textField menuLabel:(UILabel *)label;

@end

@implementation StreamModeIntegration

+ (void)initializeStreamMode {
    // Initialize the stream mode singleton
    StreamMode *streamMode = [StreamMode sharedInstance];
    
    // Sync initial state with ImGui
    StreamModeImGui::streamModeEnabled = streamMode.isStreamModeEnabled;
    StreamModeImGui::hideTopLabel = streamMode.hideTopLabel;
}

+ (void)updateStreamModeFromImGui {
    StreamMode *streamMode = [StreamMode sharedInstance];
    
    // Update Objective-C state from ImGui globals
    [streamMode enableStreamMode:g_StreamModeEnabled];
    [streamMode setHideTopLabel:g_HideTopLabel];
}

+ (void)registerUIElements:(UITextField *)textField menuLabel:(UILabel *)label {
    StreamMode *streamMode = [StreamMode sharedInstance];
    
    if (textField) {
        [streamMode registerSecureTextField:textField];
    }
    
    if (label) {
        [streamMode registerMenuTitleLabel:label];
    }
}

@end

// C++ functions that can be called from ImGui render loop
extern "C" {
    void UpdateStreamModeFromImGui() {
        [StreamModeIntegration updateStreamModeFromImGui];
    }
    
    void RegisterStreamModeUIElements(void* textField, void* label) {
        UITextField *tf = (__bridge UITextField *)textField;
        UILabel *lbl = (__bridge UILabel *)label;
        [StreamModeIntegration registerUIElements:tf menuLabel:lbl];
    }
}