# StreamMod Makefile Include
# Add this to your project's Makefile to easily integrate StreamMod
# 
# Usage: include StreamMod/StreamMod.mk

STREAMMOD_DIR = StreamMod
STREAMMOD_SRC = $(wildcard $(STREAMMOD_DIR)/*.m) $(wildcard $(STREAMMOD_DIR)/*.mm) $(wildcard $(STREAMMOD_DIR)/*.cpp)

# Add StreamMod source files to your tweak
$(TWEAK_NAME)_FILES += $(STREAMMOD_SRC)

# Add required frameworks
$(TWEAK_NAME)_FRAMEWORKS += UIKit Foundation

# Add compiler flags for StreamMod
$(TWEAK_NAME)_CFLAGS += -I$(STREAMMOD_DIR) -fobjc-arc
$(TWEAK_NAME)_CCFLAGS += -I$(STREAMMOD_DIR) -std=c++11