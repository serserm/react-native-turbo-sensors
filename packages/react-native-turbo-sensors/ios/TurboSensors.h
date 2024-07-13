#import <React/RCTEventEmitter.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNTurboSensorsSpec.h"

@interface TurboSensors : RCTEventEmitter <NativeTurboSensorsSpec>

@property (nonatomic, assign) BOOL hasListeners;
@property (nonatomic, strong) NSMutableDictionary *sensorMap;

- (double)sensorTimestamp:(NSTimeInterval)timestamp;

- (void)sendEvent:(id)body;

#else
#import <React/RCTBridgeModule.h>

@interface TurboSensors : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic, assign) BOOL hasListeners;
@property (nonatomic, strong) NSMutableDictionary *sensorMap;

- (double)sensorTimestamp:(NSTimeInterval)timestamp;

- (void)sendEvent:(id)body;

#endif

@end
