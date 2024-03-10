#import "TurboSensors.h"

@implementation TurboSensors
RCT_EXPORT_MODULE()

// - (id)init {
//   self = [super init];
//   if (self) {
//     _sensorMap = [NSMutableDictionary dictionary];
//     [_sensorMap setObject:[[MotionSensors alloc] initWithContext:@"accelerometer"] forKey:@"accelerometer"];
//   }
//   return self;
// }

- (NSArray<NSString *> *)supportedEvents {
  return @[@"accelerometerEvent"];
}

- (void)sendEvent:(NSString *)eventName body:(id)body {
  [self sendEventWithName:eventName body:body];
}

// Will be called when this module's first listener is added.
- (void)startObserving {
  hasListeners = YES;
  // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
- (void)stopObserving {
  // Remove upstream listeners, stop unnecessary background tasks
  hasListeners = NO;
  // If we no longer have listeners registered we should also probably also stop the sensor since the sensor events are essentially being dropped.
}

RCT_EXPORT_METHOD(isAvailable:(NSString *)sensor
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
  NSLog(@"isAvailable");
//   if (_sensorMap objectForKey:sensor] != nil) {
//     [_sensorMap objectForKey:sensor isAvailable ];
//   }
  resolve(@YES);
}

RCT_EXPORT_METHOD(setInterval:(NSString *)sensor
                  newInterval:(double)newInterval) {
//   if (_sensorMap objectForKey:sensor] != nil) {
//     [_sensorMap objectForKey:sensor setInterval:newInterval];
//   }
}

RCT_EXPORT_METHOD(startListening:(NSString *)sensor) {
//   if (_sensorMap objectForKey:sensor] != nil) {
//     [_sensorMap objectForKey:sensor startListening];
//   }
}

RCT_EXPORT_METHOD(stopListening:(NSString *)sensor) {
//   if (_sensorMap objectForKey:sensor] != nil) {
//     [_sensorMap objectForKey:sensor stopListening];
//   }
}

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeTurboSensorsSpecJSI>(params);
}
#endif

@end

// _____ MotionSensors _____

// @implementation MotionSensors
//
// - (id)initWithContext:(NSString *)sensorName
//                   module:(TurboSensors *)module {
//   self = [super init];
//
//   if (self) {
//     NSLog(@"init");
//     _module = module;
//   }
//   return self;
// }
//
// - (void)isAvailable:(RCTPromiseResolveBlock)resolve
//                   reject:(RCTPromiseRejectBlock)reject {
//   NSLog(@"isAvailable");
// //     if([self->_motionManager isAccelerometerAvailable])
// //     {
// //         /* Start the accelerometer if it is not active already */
// //         if([self->_motionManager isAccelerometerActive] == NO)
// //         {
// //             resolve(@YES);
// //         } else {
// //             reject(@"-1", @"Accelerometer is not active", nil);
// //         }
// //     }
// //     else
// //     {
// //         reject(@"-1", @"Accelerometer is not available", nil);
// //     }
// }
//
// - (void)setInterval:(double)newInterval {
//   NSLog(@"setInterval");
// //   double intervalInSeconds = newInterval / 1000;
// //
// //   [self->_motionManager setAccelerometerUpdateInterval:intervalInSeconds];
// }
//
// - (void)startListening {
//   hasListeners = YES;
//   NSLog(@"startListening");
// //   [self->_motionManager startAccelerometerUpdates];
// //
// //   /* Receive the accelerometer data on this block */
// //   [self->_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
// //                                            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
// //   {
// //      double x = accelerometerData.acceleration.x;
// //      double y = accelerometerData.acceleration.y;
// //      double z = accelerometerData.acceleration.z;
// //      double timestamp = [RNSensorsUtils sensorTimestampToEpochMilliseconds:accelerometerData.timestamp];
// //
// //      [self sendEvent:@"RNSensorsAccelerometer" body:@{
// //                                                        @"x" : [NSNumber numberWithDouble:x],
// //                                                        @"y" : [NSNumber numberWithDouble:y],
// //                                                        @"z" : [NSNumber numberWithDouble:z],
// //                                                        @"timestamp" : [NSNumber numberWithDouble:timestamp]
// //                                                    }];
// //   }];
// }
//
// - (void)stopListening {
//   hasListeners = NO;
//   NSLog(@"stopListening");
//   if (self->_motionManager) {
// //     [self stopListening];
// //     [self->_motionManager stopAccelerometerUpdates];
//   }
// }
//
// @end
