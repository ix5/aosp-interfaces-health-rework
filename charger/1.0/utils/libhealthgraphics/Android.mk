LOCAL_PATH := $(call my-dir)

###############################################################################
### libbhealthgrapics ###
###############################################################################
include $(CLEAR_VARS)
LOCAL_MODULE := libhealthgraphics
LOCAL_STATIC_LIBRARIES := \
	libminui \
	libbase
LOCAL_SRC_FILES := \
	draw.cpp \
# What does this even do
ifneq ($(TARGET_HEALTHD_DRAW_SPLIT_SCREEN),)
LOCAL_CFLAGS += -DHEALTHD_DRAW_SPLIT_SCREEN=$(TARGET_HEALTHD_DRAW_SPLIT_SCREEN)
else
LOCAL_CFLAGS += -DHEALTHD_DRAW_SPLIT_SCREEN=0
endif
# Same for this
ifneq ($(TARGET_HEALTHD_DRAW_SPLIT_OFFSET),)
LOCAL_CFLAGS += -DHEALTHD_DRAW_SPLIT_OFFSET=$(TARGET_HEALTHD_DRAW_SPLIT_OFFSET)
else
LOCAL_CFLAGS += -DHEALTHD_DRAW_SPLIT_OFFSET=0
endif
# LOCAL_HEADER_LIBRARIES = header_libs in .bp
LOCAL_HEADER_LIBRARIES := libbatteryservice_headers
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
# Only need to export libhealthdraw for charger:mode_charger.cpp
LOCAL_C_INCLUDES =: $(LOCAL_PATH)/include
LOCAL_EXPORT_C_INCLUDE_DIRS =: $(LOCAL_PATH)/include
# same as local_include_dirs and export_include_dirs
include $(BUILD_STATIC_LIBRARY)
