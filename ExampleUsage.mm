/*
 * StreamMod Integration Example
 * Developer: erzo19 (@erzohack)
 * 
 * This example shows how to integrate StreamMod into your iOS game mod project.
 * Follow the steps below to add stream protection to your mod menu.
 */

#import <UIKit/UIKit.h>
#import <MetalKit/MetalKit.h>
#import "../StreamMode.h"
#import "../StreamModeImGui.h"

// Include the C bridge functions
extern "C" {
    void UpdateStreamModeFromImGui();
    void RegisterStreamModeUIElements(void* textField, void* label);
}

@interface ExampleModMenu : UIViewController <MTKViewDelegate>

// Your existing UI elements
@property (nonatomic, strong) UILabel *menuTitleLabel;
@property (nonatomic, strong) UILabel *playerInfoLabel;
@property (nonatomic, strong) UITextField *hideRecordTextField;

// Menu state
@property (nonatomic, assign) BOOL menuVisible;

@end

@implementation ExampleModMenu

#pragma mark - Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup your existing UI
    [self setupModMenuUI];
    
    // Initialize StreamMod (IMPORTANT: Do this after UI setup)
    [self initializeStreamMode];
    
    NSLog(@"[StreamMod Example] Mod menu with StreamMod initialized successfully!");
}

- (void)setupModMenuUI {
    // Create menu title
    self.menuTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    self.menuTitleLabel.text = @"erzo19's Mod Menu";
    self.menuTitleLabel.textColor = [UIColor colorWithRed:0.45f green:1.0f blue:0.07f alpha:1.0f]; // Green color
    self.menuTitleLabel.font = [UIFont systemFontOfSize:19.0f weight:UIFontWeightLight];
    self.menuTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.menuTitleLabel sizeToFit];
    
    // Position at top center
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    self.menuTitleLabel.center = CGPointMake(CGRectGetMidX(mainWindow.bounds), 30);
    [mainWindow addSubview:self.menuTitleLabel];
    
    // Create player info label (example of sensitive information)
    self.playerInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 20)];
    self.playerInfoLabel.text = @"Player: John123 | ID: 987654321";
    self.playerInfoLabel.textColor = [UIColor whiteColor];
    self.playerInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    [mainWindow addSubview:self.playerInfoLabel];
    
    // Create secure text field for stream protection
    self.hideRecordTextField = [[UITextField alloc] init];
    self.hideRecordTextField.secureTextEntry = NO; // Will be controlled by StreamMod
    [self.view addSubview:self.hideRecordTextField];
}

- (void)initializeStreamMode {
    // Get StreamMod singleton instance
    StreamMode *streamMode = [StreamMode sharedInstance];
    
    // Register UI elements that should be controlled by stream mode
    [streamMode registerSecureTextField:self.hideRecordTextField];
    [streamMode registerMenuTitleLabel:self.menuTitleLabel];
    
    NSLog(@"[StreamMod Example] StreamMod registered with UI elements");
}

#pragma mark - ImGui Rendering

- (void)renderImGuiMenu {
    // Your mod menu window
    ImGui::Begin("erzo19's Mod Menu", &_menuVisible, ImGuiWindowFlags_AlwaysAutoResize);
    
    if (ImGui::BeginTabBar("ModMenuTabs")) {
        
        // Example: Aimbot tab
        if (ImGui::BeginTabItem("Aimbot")) {
            static bool aimbotEnabled = false;
            static float aimbotFOV = 60.0f;
            
            ImGui::Checkbox("Enable Aimbot", &aimbotEnabled);
            ImGui::SliderFloat("FOV", &aimbotFOV, 10.0f, 180.0f);
            
            ImGui::EndTabItem();
        }
        
        // Example: ESP tab
        if (ImGui::BeginTabItem("ESP")) {
            static bool espEnabled = false;
            static bool espNames = false;
            static bool espBoxes = false;
            
            ImGui::Checkbox("Enable ESP", &espEnabled);
            ImGui::Checkbox("Show Names", &espNames);
            ImGui::Checkbox("Show Boxes", &espBoxes);
            
            // Hide ESP options when in stream mode
            if ([StreamMode sharedInstance].isStreamModeEnabled) {
                ImGui::TextColored(ImVec4(1.0f, 0.5f, 0.0f, 1.0f), "ESP hidden in stream mode");
            }
            
            ImGui::EndTabItem();
        }
        
        // StreamMod tab - ADD THIS TO YOUR MENU
        if (ImGui::BeginTabItem("Stream")) {
            // Render StreamMod controls
            StreamModeImGui::RenderStreamModeControls();
            
            ImGui::Separator();
            
            // Example: Show current stream mode status
            if ([StreamMode sharedInstance].isStreamModeEnabled) {
                ImGui::TextColored(ImVec4(0.0f, 1.0f, 0.0f, 1.0f), "Stream Mode: ACTIVE");
                ImGui::Text("Sensitive information is hidden");
            } else {
                ImGui::TextColored(ImVec4(0.7f, 0.7f, 0.7f, 1.0f), "Stream Mode: INACTIVE");
                ImGui::Text("All information visible");
            }
            
            ImGui::EndTabItem();
        }
        
        // Info tab
        if (ImGui::BeginTabItem("Info")) {
            ImGui::Text("Mod Menu by erzo19");
            ImGui::Text("Telegram: @erzohack");
            ImGui::Text("Updates: @erzohackff");
            ImGui::Separator();
            ImGui::Text("StreamMod Integration Example");
            ImGui::Text("Stream protection: %s", [StreamMode sharedInstance].isStreamModeEnabled ? "ON" : "OFF");
            
            ImGui::EndTabItem();
        }
        
        ImGui::EndTabBar();
    }
    
    ImGui::End();
    
    // CRITICAL: Update StreamMod after rendering ImGui
    // This synchronizes the ImGui controls with the Objective-C StreamMode
    UpdateStreamModeFromImGui();
}

#pragma mark - Game Functions with Stream Protection

- (void)updatePlayerInformation {
    // Example of how to use StreamMod in your game functions
    
    if ([StreamMode sharedInstance].isStreamModeEnabled) {
        // Hide sensitive information when streaming
        self.playerInfoLabel.text = @"Player: [HIDDEN] | ID: [HIDDEN]";
        
        // You can also hide other sensitive data
        // hidePlayerCoordinates();
        // hidePlayerStats();
        
        NSLog(@"[StreamMod Example] Player info hidden for streaming");
    } else {
        // Show normal information
        self.playerInfoLabel.text = @"Player: John123 | ID: 987654321";
        
        NSLog(@"[StreamMod Example] Player info visible (normal mode)");
    }
}

- (void)renderESPWithStreamProtection {
    // Example: Only show ESP when not in stream mode
    
    if ([StreamMode sharedInstance].isStreamModeEnabled) {
        // Don't render ESP or render a minimal version
        NSLog(@"[StreamMod Example] ESP disabled due to stream mode");
        return;
    }
    
    // Normal ESP rendering
    // [self drawPlayerBoxes];
    // [self drawPlayerNames];
    // [self drawPlayerHealth];
    
    NSLog(@"[StreamMod Example] ESP rendered normally");
}

- (void)handleSensitiveGameData:(NSString *)data {
    // Example: Process sensitive data based on stream mode
    
    if ([StreamMode sharedInstance].isStreamModeEnabled) {
        // Process data but don't display it
        NSString *processedData = [self processSensitiveData:data];
        // Don't show to user
        
        NSLog(@"[StreamMod Example] Sensitive data processed but hidden");
    } else {
        // Normal processing and display
        NSString *processedData = [self processSensitiveData:data];
        [self displayDataToUser:processedData];
        
        NSLog(@"[StreamMod Example] Sensitive data processed and displayed");
    }
}

#pragma mark - Helper Methods

- (NSString *)processSensitiveData:(NSString *)data {
    // Your data processing logic
    return [data uppercaseString];
}

- (void)displayDataToUser:(NSString *)data {
    // Display data to user (only called when not in stream mode)
    NSLog(@"Displaying to user: %@", data);
}

#pragma mark - StreamMod Event Handling (Optional)

- (void)streamModeDidChange:(BOOL)enabled {
    // Optional: React to stream mode changes
    
    if (enabled) {
        NSLog(@"[StreamMod Example] Stream mode enabled - hiding sensitive UI");
        [self updatePlayerInformation];
    } else {
        NSLog(@"[StreamMod Example] Stream mode disabled - showing all UI");
        [self updatePlayerInformation];
    }
}

@end

/*
 * INTEGRATION CHECKLIST:
 * 
 * ✅ 1. Include StreamMod headers
 * ✅ 2. Create UI elements (labels, text fields)
 * ✅ 3. Initialize StreamMod and register UI elements
 * ✅ 4. Add StreamMod tab to ImGui menu
 * ✅ 5. Call UpdateStreamModeFromImGui() after rendering
 * ✅ 6. Check stream mode state in your game functions
 * ✅ 7. Hide sensitive information when stream mode is active
 * 
 * TESTING:
 * 
 * 1. Toggle "Stream Mode" in the Stream tab
 * 2. Verify that sensitive information is hidden
 * 3. Toggle "Hide Top Label" and check menu title visibility
 * 4. Test with actual streaming software
 * 
 * SUPPORT:
 * 
 * Developer: erzo19
 * Telegram: @erzohack
 * Updates: @erzohackff
 * Chat: @erzochat
 */