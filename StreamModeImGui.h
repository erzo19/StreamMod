#pragma once
#include "imgui/imgui.h"

// Stream Mode ImGui Integration
class StreamModeImGui {
public:
    // Stream mode state
    static bool streamModeEnabled;
    static bool hideTopLabel;
    
    // Render stream mode controls in ImGui
    static void RenderStreamModeControls();
    
    // Apply stream mode settings
    static void ApplyStreamModeSettings();
    
    // Check if stream mode is active
    static bool IsStreamModeActive();
};

// Global variables for ImGui integration
extern bool g_StreamModeEnabled;
extern bool g_HideTopLabel;