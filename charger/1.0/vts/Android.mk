
###############################################################################
### charger_test ###
###############################################################################

include $(CLEAR_VARS)
LOCAL_MODULE := charger_test
LOCAL_MODULE_TAGS := optional
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_CFLAGS := -Wall -Werror -DCHARGER_TEST -DCHARGER_NO_UI
LOCAL_STATIC_LIBRARIES := $(CHARGER_STATIC_LIBRARIES)
LOCAL_SRC_FILES := \
    charger.cpp \
    charger_test.cpp \

include $(BUILD_EXECUTABLE)

