# StreamMod Quick Integration Guide

**Developer:** erzo19 | **Telegram:** [@erzohack](https://t.me/erzohack)

## 🚀 5-Minute Integration

### Step 1: Add to Your Project (Choose One)

**Option A: Direct Download**
```bash
git clone https://github.com/erzo19/StreamMod.git
cp -r StreamMod /path/to/your/project/
```

**Option B: Git Submodule**
```bash
git submodule add https://github.com/erzo19/StreamMod.git StreamMod
```

### Step 2: Update Makefile

Add this single line to your Makefile:
```makefile
include StreamMod/StreamMod.mk
```

### Step 3: Import Headers

Add to your main view controller:
```objc
#import "StreamMod/StreamMode.h"
#import "StreamMod/StreamModeImGui.h"

extern "C" void UpdateStreamModeFromImGui();
```

### Step 4: Initialize (2 lines of code)

In your `viewDidLoad`:
```objc
StreamMode *streamMode = [StreamMode sharedInstance];
[streamMode registerSecureTextField:yourTextField];
[streamMode registerMenuTitleLabel:yourMenuLabel];
```

### Step 5: Add ImGui Tab

In your ImGui render function:
```cpp
if (ImGui::BeginTabItem("Stream")) {
    StreamModeImGui::RenderStreamModeControls();
    ImGui::EndTabItem();
}

// IMPORTANT: Add this after ImGui rendering
UpdateStreamModeFromImGui();
```

### Step 6: Use Stream Protection

Check stream mode anywhere in your code:
```objc
if ([StreamMode sharedInstance].isStreamModeEnabled) {
    // Hide sensitive info
    label.text = @"[HIDDEN]";
} else {
    // Show normal info
    label.text = actualData;
}
```

## ✅ That's It!

Your mod now has professional stream protection. Users can toggle stream mode to hide sensitive information during broadcasts.

## 📞 Need Help?

- **Telegram:** [@erzohack](https://t.me/erzohack)
- **Updates:** [@erzohackff](https://t.me/erzohackff)
- **Full Tutorial:** See `TUTORIAL.md`

---
*StreamMod by erzo19 - Making iOS modding stream-friendly* 🎮