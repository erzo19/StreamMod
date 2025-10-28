#include "StreamModeImGui.h"

// Global variables
bool g_StreamModeEnabled = false;
bool g_HideTopLabel = false;

// Static member initialization
bool StreamModeImGui::streamModeEnabled = false;
bool StreamModeImGui::hideTopLabel = false;

void StreamModeImGui::RenderStreamModeControls() {
    if (ImGui::BeginTabItem("Stream Settings")) {
        ImGui::Spacing();
        
        // Stream Mode Toggle
        if (ImGui::Checkbox("Stream Mode", &streamModeEnabled)) {
            g_StreamModeEnabled = streamModeEnabled;
            ApplyStreamModeSettings();
        }
        
        ImGui::Spacing();
        
        // Hide Top Label Toggle
        if (ImGui::Checkbox("Hide Top Label", &hideTopLabel)) {
            g_HideTopLabel = hideTopLabel;
            ApplyStreamModeSettings();
        }
        
        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();
        
        // Information text
        ImGui::TextDisabled("Stream Mode helps hide sensitive information");
        ImGui::TextDisabled("when broadcasting or recording gameplay.");
        
        ImGui::Spacing();
        ImGui::EndTabItem();
    }
}

void StreamModeImGui::ApplyStreamModeSettings() {
    // Update global state
    g_StreamModeEnabled = streamModeEnabled;
    g_HideTopLabel = hideTopLabel;
    
    // Here you would typically call platform-specific code
    // to update UI elements based on the stream mode state
}

bool StreamModeImGui::IsStreamModeActive() {
    return streamModeEnabled;
}