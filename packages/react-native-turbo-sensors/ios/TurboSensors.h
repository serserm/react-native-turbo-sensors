
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNTurboSensorsSpec.h"
#import <React/RCTEventEmitter.h>

@interface TurboSensors : NSObject <NativeTurboSensorsSpec, RCTEventEmitter>
#else
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface TurboSensors : NSObject <RCTBridgeModule, RCTEventEmitter>
#endif

@end
