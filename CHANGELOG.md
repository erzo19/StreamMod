# StreamMod Changelog

All notable changes to StreamMod will be documented in this file.

**Developer:** erzo19 | **Contact:** [@erzohack](https://t.me/erzohack)

## [1.0.0] - 2024-10-28

### 🎉 Initial Release

#### ✨ Features
- **Stream Mode Toggle**: Hide sensitive UI elements during streaming
- **Secure Text Field Control**: Automatically obscure text inputs
- **Menu Title Visibility**: Show/hide menu labels and titles
- **ImGui Integration**: Ready-to-use settings tab with professional UI
- **Easy Integration**: Drop-in solution with minimal setup required
- **iOS Optimized**: Full compatibility with iOS 12.0+ and modern devices
- **Lightweight**: Minimal performance impact on your mod

#### 📁 Core Components
- `StreamMode.h/m` - Objective-C singleton for stream mode management
- `StreamModeImGui.h/cpp` - C++ ImGui integration and controls
- `StreamModeIntegration.mm` - Bridge between Objective-C and C++
- `StreamMod.mk` - Easy Makefile integration
- `Example/ExampleUsage.mm` - Complete integration example

#### 📚 Documentation
- Comprehensive README with features and installation
- Step-by-step integration tutorial
- Quick integration guide (5-minute setup)
- Complete code examples and best practices
- Troubleshooting guide with common issues

#### 🛠️ Developer Tools
- Theos Makefile integration
- Git submodule support
- Debug logging capabilities
- Extensible architecture for custom features

#### 🎯 Target Audience
- iOS game mod developers
- Content creators and streamers
- Jailbreak tweak developers
- ImGui-based UI developers

### 📋 Requirements
- iOS 12.0 or later
- Theos development environment
- ImGui framework
- Metal rendering support

### 🔧 Integration Methods
1. **Direct Integration**: Copy files to project
2. **Git Submodule**: Add as submodule for easy updates
3. **Manual Setup**: Custom integration for advanced users

### 🎮 Supported Platforms
- iPhone (iOS 12.0+)
- iPad (iOS 12.0+)
- Jailbroken devices (rootful and rootless)
- Simulator (for development)

### 📞 Support Channels
- **Developer Contact**: [@erzohack](https://t.me/erzohack)
- **Updates Channel**: [@erzohackff](https://t.me/erzohackff)
- **Community Chat**: [@erzochat](https://t.me/erzochat)

---

## Future Plans

### [1.1.0] - Planned Features
- [ ] Advanced stream mode options
- [ ] Custom UI element registration
- [ ] Stream mode presets
- [ ] Enhanced ImGui themes
- [ ] Performance optimizations

### [1.2.0] - Advanced Features
- [ ] Stream overlay integration
- [ ] Automatic sensitive data detection
- [ ] Multi-language support
- [ ] Plugin system for extensions

---

**Made with ❤️ by erzo19 for the iOS modding community**

*StreamMod - Professional stream protection for iOS game mods*