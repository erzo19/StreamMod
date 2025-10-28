# StreamMod - iOS Game Mod Stream Protection

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![iOS](https://img.shields.io/badge/iOS-12.0+-blue.svg)](https://developer.apple.com/ios/)
[![Language](https://img.shields.io/badge/Language-Objective--C%2B%2B-orange.svg)](https://developer.apple.com/documentation/objectivec)

A lightweight, easy-to-integrate stream mode library for iOS game modification projects. Helps content creators and streamers hide sensitive information during broadcasts while maintaining full functionality.

**Developer:** erzo19  
**Telegram:** [@erzohack](https://t.me/erzohack)  
**Updates:** [@erzohackff](https://t.me/erzohackff)

## ✨ Features

- 🎥 **Stream Mode Toggle**: Instantly hide sensitive UI elements
- 🔒 **Secure Text Fields**: Auto-obscure text inputs when streaming
- 👁️ **Menu Visibility Control**: Show/hide menu titles and labels
- 🎮 **ImGui Integration**: Ready-to-use settings tab
- 📱 **iOS Optimized**: Works with Metal rendering and modern iOS
- 🔧 **Easy Integration**: Drop-in solution with minimal setup
- 🎯 **Lightweight**: Minimal performance impact

## 📋 Requirements

- iOS 12.0 or later
- Theos development environment
- ImGui framework (for UI integration)
- Metal rendering support

## 🚀 Quick Start

### Method 1: Direct Integration

1. **Download StreamMod**
   ```bash
   git clone https://github.com/erzo19/StreamMod.git
   cd StreamMod
   ```

2. **Copy to Your Project**
   ```bash
   cp -r StreamMod/* /path/to/your/project/
   ```

3. **Update Your Makefile**
   ```makefile
   # Add to your existing Makefile
   STREAMMOD_SRC = $(wildcard StreamMod/*.m) $(wildcard StreamMod/*.mm) $(wildcard StreamMod/*.cpp)
   
   $(TWEAK_NAME)_FILES += $(STREAMMOD_SRC)
   $(TWEAK_NAME)_FRAMEWORKS += UIKit Foundation
   ```

### Method 2: Submodule (Recommended)

1. **Add as Submodule**
   ```bash
   git submodule add https://github.com/erzo19/StreamMod.git StreamMod
   git submodule update --init --recursive
   ```

2. **Include in Your Project**
   ```makefile
   include StreamMod/StreamMod.mk
   ```

## 📖 Integration Tutorial

### Step 1: Basic Setup

In your main view controller header file:

```objc
#import "StreamMod/StreamMode.h"
#import "StreamMod/StreamModeImGui.h"

@interface YourViewController : UIViewController
@property (nonatomic, strong) UILabel *menuTitle;
@property (nonatomic, strong) UITextField *secureField;
@end
```

### Step 2: Initialize StreamMod

In your `viewDidLoad` or initialization method:

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create your UI elements
    [self setupUI];
    
    // Initialize StreamMod
    StreamMode *streamMode = [StreamMode sharedInstance];
    [streamMode registerSecureTextField:self.secureField];
    [streamMode registerMenuTitleLabel:self.menuTitle];
}
```

### Step 3: Add ImGui Controls

In your ImGui render loop:

```cpp
// In your settings tab or wherever you want the controls
if (ImGui::BeginTabItem("Stream Settings")) {
    StreamModeImGui::RenderStreamModeControls();
    ImGui::EndTabItem();
}

// Update stream mode after rendering (call this once per frame)
UpdateStreamModeFromImGui();
```

### Step 4: Advanced Usage

Check stream mode state in your code:

```objc
- (void)sensitiveFunction {
    if ([StreamMode sharedInstance].isStreamModeEnabled) {
        // Hide sensitive information
        self.playerDataLabel.text = @"[HIDDEN]";
    } else {
        // Show normal information
        self.playerDataLabel.text = actualPlayerData;
    }
}
```

## 🎯 Complete Integration Example

Here's a complete example of integrating StreamMod into an existing mod menu:

```objc
#import "StreamMod/StreamMode.h"
#import "StreamMod/StreamModeImGui.h"

@implementation YourModMenu

- (void)initializeMenu {
    // Your existing menu setup...
    
    // StreamMod setup
    StreamMode *streamMode = [StreamMode sharedInstance];
    [streamMode registerSecureTextField:self.hideRecordTextField];
    [streamMode registerMenuTitleLabel:self.menuTitleLabel];
}

- (void)renderImGuiMenu {
    ImGui::Begin("Your Mod Menu", &menuOpen);
    
    if (ImGui::BeginTabBar("MenuTabs")) {
        // Your existing tabs...
        
        // Add StreamMod tab
        if (ImGui::BeginTabItem("Stream")) {
            StreamModeImGui::RenderStreamModeControls();
            ImGui::EndTabItem();
        }
        
        ImGui::EndTabBar();
    }
    
    ImGui::End();
    
    // Update StreamMod (important!)
    UpdateStreamModeFromImGui();
}

@end
```

## 🔧 Customization

### Custom UI Elements

Register any UI element with StreamMod:

```objc
// Register multiple elements
StreamMode *streamMode = [StreamMode sharedInstance];
[streamMode registerSecureTextField:textField1];
[streamMode registerSecureTextField:textField2];
[streamMode registerMenuTitleLabel:titleLabel];
[streamMode registerMenuTitleLabel:subtitleLabel];
```

### Custom Stream Mode Logic

Extend StreamMod for your specific needs:

```objc
// Create a category or subclass
@interface StreamMode (YourExtension)
- (void)hidePlayerList:(BOOL)hide;
- (void)obscureCoordinates:(BOOL)obscure;
@end

@implementation StreamMode (YourExtension)
- (void)hidePlayerList:(BOOL)hide {
    // Your custom logic here
    if (self.isStreamModeEnabled && hide) {
        // Hide player list
    }
}
@end
```

## 📱 Platform Support

- ✅ iPhone (iOS 12.0+)
- ✅ iPad (iOS 12.0+)
- ✅ Jailbroken devices
- ✅ Rootless jailbreaks
- ✅ Theos projects
- ✅ Metal rendering
- ✅ ImGui integration

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

- **Developer:** erzo19
- **Telegram:** [@erzohack](https://t.me/erzohack)
- **Updates Channel:** [@erzohackff](https://t.me/erzohackff)
- **Chat Group:** [@erzochat](https://t.me/erzochat)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Show Your Support

If this project helped you, please consider giving it a star! It helps others discover the project.

---

**Made with ❤️ by erzo19 for the iOS modding community**