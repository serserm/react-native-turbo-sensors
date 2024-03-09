#import <Foundation/Foundation.h>
#import <React/RCTEventEmitter.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNTurboSensorsSpec.h"

@interface TurboSensors : RCTEventEmitter <NativeTurboSensorsSpec> {
  bool hasListeners;
//  NSMutableDictionary *_sensorMap;
}
#else
#import <React/RCTBridgeModule.h>

@interface TurboSensors : RCTEventEmitter <RCTBridgeModule> {
  bool hasListeners;
//  NSMutableDictionary *_sensorMap;
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
