
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNTurboSensorsSpec.h"

@interface TurboSensors : NSObject <NativeTurboSensorsSpec>
#else
#import <React/RCTBridgeModule.h>

@interface TurboSensors : NSObject <RCTBridgeModule>
#endif

@end
