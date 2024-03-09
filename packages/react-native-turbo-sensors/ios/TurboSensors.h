#import <React/RCTEventEmitter.h>
#import <CoreMotion/CoreMotion.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNTurboSensorsSpec.h"

@interface TurboSensors : RCTEventEmitter <NativeTurboSensorsSpec> {
  CMMotionManager *_motionManager;
  bool hasListeners;
}
#else
#import <React/RCTBridgeModule.h>

@interface TurboSensors : RCTEventEmitter <RCTBridgeModule> {
  CMMotionManager *_motionManager;
  bool hasListeners;
}

- (void)isAvailable:(NSString *)sensor
            resolve:(RCTPromiseResolveBlock)resolve
             reject:(RCTPromiseRejectBlock)reject;
- (void)setInterval:(NSString *)sensor
        newInterval:(double)newInterval;
- (void)startListening:(NSString *)sensor;
- (void)stopListening:(NSString *)sensor;
#endif

@end
