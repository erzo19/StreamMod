# StreamMod Integration Tutorial

**Developer:** erzo19  
**Contact:** [@erzohack](https://t.me/erzohack)

This comprehensive tutorial will guide you through integrating StreamMod into your iOS game modification project.

## 📋 Prerequisites

Before starting, make sure you have:
- Theos development environment set up
- An existing iOS mod project with ImGui
- Basic knowledge of Objective-C and C++
- iOS device running iOS 12.0 or later

## 🎯 Integration Methods

### Method 1: Quick Integration (Recommended for Beginners)

#### Step 1: Download StreamMod
```bash
# Clone the repository
git clone https://github.com/erzo19/StreamMod.git

# Or download as ZIP and extract
```

#### Step 2: Copy Files to Your Project
```bash
# Copy StreamMod folder to your project root
cp -r StreamMod /path/to/your/project/

# Your project structure should look like:
# YourProject/
# ├── StreamMod/
# │   ├── StreamMode.h
# │   ├── StreamMode.m
# │   ├── StreamModeImGui.h
# │   └── ...
# ├── YourTweak.mm
# └── Makefile
```

#### Step 3: Update Your Makefile
Add this line to your existing Makefile:
```makefile
# Include StreamMod
include StreamMod/StreamMod.mk
```

Or manually add the files:
```makefile
# Add StreamMod source files
STREAMMOD_SRC = $(wildcard StreamMod/*.m) $(wildcard StreamMod/*.mm) $(wildcard StreamMod/*.cpp)

$(TWEAK_NAME)_FILES += $(STREAMMOD_SRC)
$(TWEAK_NAME)_FRAMEWORKS += UIKit Foundation
$(TWEAK_NAME)_CFLAGS += -IStreamMod -fobjc-arc
$(TWEAK_NAME)_CCFLAGS += -IStreamMod -std=c++11
```

### Method 2: Git Submodule (Recommended for Advanced Users)

#### Step 1: Add Submodule
```bash
cd /path/to/your/project
git submodule add https://github.com/erzo19/StreamMod.git StreamMod
git submodule update --init --recursive
```

#### Step 2: Include in Makefile
```makefile
include StreamMod/StreamMod.mk
```

#### Step 3: Update Submodule (when needed)
```bash
git submodule update --remote StreamMod
```

## 🔧 Code Integration

### Step 1: Import Headers

In your main view controller or ImGui implementation file:

```objc
#import "StreamMod/StreamMode.h"
#import "StreamMod/StreamModeImGui.h"

// If using the integration bridge
extern "C" {
    void UpdateStreamModeFromImGui();
    void RegisterStreamModeUIElements(void* textField, void* label);
}
```

### Step 2: Register UI Elements

In your view controller's initialization:

```objc
@interface YourViewController : UIViewController
@property (nonatomic, strong) UILabel *menuTitle;
@property (nonatomic, strong) UITextField *hideRecordTextField;
@end

@implementation YourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create your UI elements first
    [self setupMenuUI];
    
    // Register with StreamMod
    [self initializeStreamMod];
}

- (void)setupMenuUI {
    // Create menu title
    self.menuTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    self.menuTitle.text = @"Your Mod Menu";
    self.menuTitle.textColor = [UIColor whiteColor];
    self.menuTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.menuTitle];
    
    // Create secure text field (for stream protection)
    self.hideRecordTextField = [[UITextField alloc] init];
    self.hideRecordTextField.secureTextEntry = NO;
    [self.view addSubview:self.hideRecordTextField];
}

- (void)initializeStreamMod {
    StreamMode *streamMode = [StreamMode sharedInstance];
    
    // Register UI elements that should be controlled by stream mode
    [streamMode registerSecureTextField:self.hideRecordTextField];
    [streamMode registerMenuTitleLabel:self.menuTitle];
    
    NSLog(@"StreamMod initialized successfully!");
}

@end
```

### Step 3: Add ImGui Controls

In your ImGui render function:

```cpp
void RenderYourMenu() {
    ImGui::Begin("Your Mod Menu", &menuOpen);
    
    if (ImGui::BeginTabBar("MainTabs")) {
        
        // Your existing tabs (Aimbot, ESP, etc.)
        if (ImGui::BeginTabItem("Aimbot")) {
            // Your aimbot controls...
            ImGui::EndTabItem();
        }
        
        if (ImGui::BeginTabItem("ESP")) {
            // Your ESP controls...
            ImGui::EndTabItem();
        }
        
        // Add StreamMod tab
        if (ImGui::BeginTabItem("Stream")) {
            StreamModeImGui::RenderStreamModeControls();
            ImGui::EndTabItem();
        }
        
        ImGui::EndTabBar();
    }
    
    ImGui::End();
    
    // IMPORTANT: Update StreamMod after rendering
    UpdateStreamModeFromImGui();
}
```

### Step 4: Use Stream Mode in Your Code

Check stream mode state throughout your application:

```objc
- (void)updatePlayerInfo {
    if ([StreamMode sharedInstance].isStreamModeEnabled) {
        // Hide sensitive information when streaming
        self.playerNameLabel.text = @"[HIDDEN]";
        self.playerIDLabel.text = @"****";
        self.coordinatesLabel.text = @"X: *** Y: *** Z: ***";
    } else {
        // Show normal information
        self.playerNameLabel.text = actualPlayerName;
        self.playerIDLabel.text = actualPlayerID;
        self.coordinatesLabel.text = [NSString stringWithFormat:@"X: %.1f Y: %.1f Z: %.1f", x, y, z];
    }
}

- (void)renderESP {
    // Only show ESP when not in stream mode
    if (![StreamMode sharedInstance].isStreamModeEnabled) {
        // Render ESP normally
        [self drawPlayerBoxes];
        [self drawPlayerNames];
    } else {
        // Hide ESP or show minimal version
        NSLog(@"ESP hidden due to stream mode");
    }
}
```

## 🎨 Advanced Customization

### Custom Stream Mode Behavior

Create a category to extend StreamMod functionality:

```objc
// StreamMode+YourExtensions.h
@interface StreamMode (YourExtensions)
- (void)setCustomStreamBehavior:(BOOL)enabled;
- (void)hideAdvancedFeatures:(BOOL)hide;
@end

// StreamMode+YourExtensions.m
@implementation StreamMode (YourExtensions)

- (void)setCustomStreamBehavior:(BOOL)enabled {
    if (enabled && self.isStreamModeEnabled) {
        // Your custom stream mode logic
        [self hideAdvancedFeatures:YES];
    }
}

- (void)hideAdvancedFeatures:(BOOL)hide {
    // Hide specific features when streaming
    extern bool g_ShowAdvancedESP;
    extern bool g_ShowPlayerIDs;
    
    g_ShowAdvancedESP = !hide;
    g_ShowPlayerIDs = !hide;
}

@end
```

### Custom ImGui Controls

Add your own stream-related controls:

```cpp
void RenderCustomStreamControls() {
    if (ImGui::BeginTabItem("Stream Pro")) {
        
        // Use StreamMod's built-in controls
        StreamModeImGui::RenderStreamModeControls();
        
        ImGui::Separator();
        
        // Add your custom controls
        static bool hideESP = false;
        static bool hidePlayerList = false;
        static bool hideCoordinates = false;
        
        ImGui::Text("Advanced Stream Options:");
        ImGui::Checkbox("Hide ESP", &hideESP);
        ImGui::Checkbox("Hide Player List", &hidePlayerList);
        ImGui::Checkbox("Hide Coordinates", &hideCoordinates);
        
        // Apply custom settings
        if (StreamModeImGui::IsStreamModeActive()) {
            // Apply your custom stream logic here
        }
        
        ImGui::EndTabItem();
    }
}
```

## 🐛 Troubleshooting

### Common Issues and Solutions

#### 1. Compilation Errors
```
Error: 'StreamMode.h' file not found
```
**Solution:** Make sure you've included the StreamMod directory in your compiler flags:
```makefile
$(TWEAK_NAME)_CFLAGS += -IStreamMod
```

#### 2. Linking Errors
```
Undefined symbols for architecture arm64: "_UpdateStreamModeFromImGui"
```
**Solution:** Make sure you've included all StreamMod source files:
```makefile
$(TWEAK_NAME)_FILES += $(wildcard StreamMod/*.m) $(wildcard StreamMod/*.mm) $(wildcard StreamMod/*.cpp)
```

#### 3. Runtime Crashes
```
[StreamMode sharedInstance]: unrecognized selector sent to instance
```
**Solution:** Ensure you're using ARC and have the correct frameworks:
```makefile
$(TWEAK_NAME)_CFLAGS += -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS += UIKit Foundation
```

#### 4. Stream Mode Not Working
**Check these points:**
- Call `UpdateStreamModeFromImGui()` after rendering ImGui
- Register UI elements with `[streamMode registerSecureTextField:]`
- Verify ImGui controls are being rendered

### Debug Mode

Enable debug logging to troubleshoot issues:

```objc
// Add this to your initialization
#ifdef DEBUG
    NSLog(@"StreamMod Debug: Initializing...");
    StreamMode *streamMode = [StreamMode sharedInstance];
    NSLog(@"StreamMod Debug: Stream mode enabled: %@", streamMode.isStreamModeEnabled ? @"YES" : @"NO");
#endif
```

## 📱 Testing Your Integration

### Test Checklist

1. **Basic Functionality**
   - [ ] StreamMod tab appears in ImGui menu
   - [ ] Stream Mode toggle works
   - [ ] Hide Top Label toggle works
   - [ ] No crashes when toggling options

2. **UI Element Control**
   - [ ] Text fields become secure when stream mode is enabled
   - [ ] Menu labels hide when "Hide Top Label" is enabled
   - [ ] UI updates immediately when settings change

3. **Custom Integration**
   - [ ] Your custom stream logic works
   - [ ] Sensitive information is properly hidden
   - [ ] Performance is not significantly impacted

### Test Scenarios

```objc
// Test stream mode programmatically
- (void)testStreamMode {
    StreamMode *streamMode = [StreamMode sharedInstance];
    
    // Test enabling stream mode
    [streamMode enableStreamMode:YES];
    NSAssert(streamMode.isStreamModeEnabled == YES, @"Stream mode should be enabled");
    
    // Test UI updates
    NSAssert(self.hideRecordTextField.secureTextEntry == YES, @"Text field should be secure");
    
    // Test disabling stream mode
    [streamMode enableStreamMode:NO];
    NSAssert(streamMode.isStreamModeEnabled == NO, @"Stream mode should be disabled");
    NSAssert(self.hideRecordTextField.secureTextEntry == NO, @"Text field should not be secure");
    
    NSLog(@"All StreamMod tests passed!");
}
```

## 🚀 Deployment

### Building Your Project

```bash
# Clean build
make clean

# Build with StreamMod
make package

# Install on device
make install
```

### Distribution

When distributing your mod with StreamMod:

1. **Include Attribution**
   ```
   This mod uses StreamMod by erzo (@erzohack)
   StreamMod: https://github.com/erzo/StreamMod
   ```

2. **Update Your README**
   ```markdown
   ## Features
   - Your mod features...
   - Stream Mode (powered by StreamMod by erzo)
   ```

3. **Mention in Release Notes**
   ```
   v1.0.0
   - Added stream mode functionality (thanks to erzo's StreamMod)
   - Your other changes...
   ```

## 💡 Best Practices

1. **Always call `UpdateStreamModeFromImGui()`** after rendering ImGui controls
2. **Register UI elements early** in your view controller's lifecycle
3. **Check stream mode state** before displaying sensitive information
4. **Test thoroughly** on different iOS versions and devices
5. **Keep StreamMod updated** by pulling the latest changes

## 📞 Support

Need help with integration? Contact erzo19:

- **Telegram:** [@erzohack](https://t.me/erzohack)
- **Updates:** [@erzohackff](https://t.me/erzohackff)
- **Chat:** [@erzochat](https://t.me/erzochat)

---

**Happy modding! 🎮**  
*Made with ❤️ by erzo19 for the iOS modding community*