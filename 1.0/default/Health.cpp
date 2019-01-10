/*
 * Copyright (C) 2016 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "health-hal"

#include <Health.h>
#include <include/hal_conversion.h>

#include <batterymonitor/BatteryMonitor.h>

namespace android {
namespace hardware {
namespace health {
namespace V1_0 {
namespace implementation {

using ::android::hardware::health::V1_0::hal_conversion::convertToHealthConfig;
using ::android::hardware::health::V1_0::hal_conversion::convertFromHealthConfig;
using ::android::hardware::health::V1_0::hal_conversion::convertToHealthInfo;
using ::android::hardware::health::V1_0::hal_conversion::convertFromHealthInfo;

// Methods from ::android::hardware::health::V1_0::IHealth follow.
Return<void> Health::init(const HealthConfig& config, init_cb _hidl_cb)  {
    struct healthd_config healthd_config = {};
    HealthConfig configOut;

    // To keep working with existing healthd static HALs,
    // convert the new HealthConfig to the old healthd_config
    // and back.

    //convertFromHealthConfig(config, &healthd_config);
    // Get rid of this!
    //healthd_board_init(&healthd_config);
    mGetEnergyCounter = healthd_config.energyCounter;
    //Health::energyCounter(energyCounter_cb _hidl_cb)
    //convertToHealthConfig(&healthd_config, configOut);

    _hidl_cb(configOut);

    return Void();
}

Return<void> Health::update(const HealthInfo& info, update_cb _hidl_cb)  {
    struct android::BatteryProperties p = {};
    //HealthInfo infoOut;

    // To keep working with existing healthd static HALs,
    // convert the new HealthInfo to android::Batteryproperties
    // and back.

    //convertFromHealthInfo(info, &p);
    //int skipLogging = healthd_board_battery_update(&p);
    //convertToHealthInfo(&p, infoOut);

    //_hidl_cb(!!skipLogging, infoOut);
    _hidl_cb(0, info);

    return Void();
}

Return<void> Health::energyCounter(energyCounter_cb _hidl_cb) {
    int64_t energy = 0;
    Result result = Result::NOT_SUPPORTED;

    // Only charger test sets energy counter
    if (mGetEnergyCounter) {
        int status = mGetEnergyCounter(&energy);
        if (status == 0) {
            result = Result::SUCCESS;
        }
    }
   // From 2.0:Health.cpp:
    /* battery_monitor_ = std::make_unique<BatteryMonitor>(); */
    /* getProperty<int64_t>(battery_monitor_, BATTERY_PROP_ENERGY_COUNTER, 0, _hidl_cb); */
    /* _hidl_cb(result, energy); */

   return Void();
}

IHealth* HIDL_FETCH_IHealth(const char* /* name */) {
    return new Health();
}

} // namespace implementation
}  // namespace V1_0
}  // namespace health
}  // namespace hardware
}  // namespace android
