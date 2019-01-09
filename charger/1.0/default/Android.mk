LOCAL_PATH := $(call my-dir)


###############################################################################
### libhealthd_charger ###
###############################################################################
include $(CLEAR_VARS)
LOCAL_CFLAGS := -Werror
ifeq ($(strip $(BOARD_CHARGER_DISABLE_INIT_BLANK)),true)
LOCAL_CFLAGS += -DCHARGER_DISABLE_INIT_BLANK
endif
ifeq ($(strip $(BOARD_CHARGER_ENABLE_SUSPEND)),true)
LOCAL_CFLAGS += -DCHARGER_ENABLE_SUSPEND
endif
LOCAL_SRC_FILES := \
    healthd_mode_charger.cpp \
    AnimationParser.cpp
LOCAL_MODULE := libhealthd_charger
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_EXPORT_C_INCLUDE_DIRS := \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/include
LOCAL_STATIC_LIBRARIES := \
    android.hardware.health@2.0 \
    android.hardware.health@2.0-impl \
    android.hardware.health@1.0 \
    android.hardware.health@1.0-convert \
    libhealthstoragedefault \
    libminui \
    libpng \
    libz \
    libutils \
    libbase \
    libcutils \
    libhealthd_draw \
    liblog \
    libm \
    libc \
ifeq ($(strip $(BOARD_CHARGER_ENABLE_SUSPEND)),true)
LOCAL_STATIC_LIBRARIES += libsuspend
endif
include $(BUILD_STATIC_LIBRARY)


###############################################################################
### charger ###
###############################################################################
include $(CLEAR_VARS)
ifeq ($(strip $(BOARD_CHARGER_NO_UI)),true)
LOCAL_CHARGER_NO_UI := true
endif
LOCAL_SRC_FILES := \
    charger.cpp \
LOCAL_MODULE := charger
LOCAL_MODULE_TAGS := optional
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT_SBIN)
LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_SBIN_UNSTRIPPED)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_CFLAGS := -Werror
ifeq ($(strip $(LOCAL_CHARGER_NO_UI)),true)
LOCAL_CFLAGS += -DCHARGER_NO_UI
endif
CHARGER_STATIC_LIBRARIES := \
    android.hardware.health@2.0-impl \
    android.hardware.health@2.0 \
    android.hardware.health@1.0 \
    android.hardware.health@1.0-convert \
    libbinderthreadstate \
    libhidltransport \
    libhidlbase \
    libhwbinder_noltopgo \
    libhealthstoragedefault \
    libvndksupport \
    libhealthd_charger \
    libhealthd_draw \
    libbatterymonitor \
    libbase \
    libutils \
    libcutils \
    liblog \
    libm \
    libc \
LOCAL_STATIC_LIBRARIES := $(CHARGER_STATIC_LIBRARIES)
ifneq ($(strip $(LOCAL_CHARGER_NO_UI)),true)
LOCAL_STATIC_LIBRARIES += \
    libminui \
    libpng \
    libz \
endif
ifeq ($(strip $(BOARD_CHARGER_ENABLE_SUSPEND)),true)
LOCAL_STATIC_LIBRARIES += libsuspend
endif
# This resolves to libhealthd.default, or, if given,
# libhealthd.$board
# We're not gonna use it here
#LOCAL_HAL_STATIC_LIBRARIES := libhealthd
# Symlink /charger to /sbin/charger
# FIXME: NONONONONONOONOOOOO
# Make this a proper HAL
# And leave the symlink trickery to others
#LOCAL_POST_INSTALL_CMD := $(hide) mkdir -p $(TARGET_ROOT_OUT) \
    && ln -sf /sbin/charger $(TARGET_ROOT_OUT)/charger
include $(BUILD_EXECUTABLE)