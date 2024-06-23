#import <React/RCTEventEmitter.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNTurboSensorsSpec.h"

@interface TurboSensors : RCTEventEmitter <NativeTurboSensorsSpec> {
    bool hasListeners;
    NSMutableDictionary *_sensorMap;
}
#else
#import <React/RCTBridgeModule.h>

@interface TurboSensors : RCTEventEmitter <RCTBridgeModule> {
    bool hasListeners;
    NSMutableDictionary *_sensorMap;
}

#endif

@end
