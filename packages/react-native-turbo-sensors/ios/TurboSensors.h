#import <React/RCTEventEmitter.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNTurboSensorsSpec.h"

@interface TurboSensors : RCTEventEmitter <NativeTurboSensorsSpec>
#else
#import <React/RCTBridgeModule.h>

@interface TurboSensors : RCTEventEmitter <RCTBridgeModule>
#endif

@property (nonatomic, assign) BOOL hasListeners;
@property (nonatomic, strong) NSMutableDictionary *sensorMap;

- (double)sensorTimestamp:(NSTimeInterval)timestamp;

- (void)sendEvent:(id)body;

@end
