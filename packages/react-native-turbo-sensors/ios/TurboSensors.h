#import <CoreMotion/CoreMotion.h>
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

- (void)isAvailable:(NSString *)sensor
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject;

- (void)setInterval:(NSString *)sensor
                  newInterval:(double)newInterval;

- (void)startListening:(NSString *)sensor;

- (void)stopListening:(NSString *)sensor;

#endif

@end

//@interface MotionSensors : NSObject {
//  CMMotionManager *_motionManager;
//  TurboSensors *_module;
//  bool hasListeners;
//}
//
//- (instancetype)initWithContext:(NSString *)sensorName module:(TurboSensors *)module;
//
//- (void)isAvailable:(RCTPromiseResolveBlock)resolve
//                  reject:(RCTPromiseRejectBlock)reject;
//
//- (void)setInterval:(double)newInterval;
//
//- (void)startListening;
//
//- (void)stopListening;
//
//@end
