#import "MotionSensor.h"

@implementation MotionSensors

 - (id)init:(NSString *)sensorName {
     _sensorName = sensorName;
     _motionManager = [[CMMotionManager alloc] init];
//     _queue = [[NSOperationQueue alloc] init];
     _intervalInSeconds = 0.1;
     return self;
 }

- (BOOL)isAvailable {
//    if ([_sensorName isEqualToString:@"accelerometer"]) {
//        return _motionManager.accelerometerAvailable;
//    } else if ([_sensorName isEqualToString:@"gyroscope"]) {
//        return _motionManager.gyroAvailable;
//    } else if ([_sensorName isEqualToString:@"magnetometer"]) {
//        return _motionManager.magnetometerAvailable;
//    } else if ([_sensorName isEqualToString:@"gravity"]) {
//        return _motionManager.deviceMotionAvailable;
//    }
    return NO;
}

- (void)setInterval:(double)newInterval {
//   _intervalInSeconds = newInterval / 1000;

//   [_motionManager setAccelerometerUpdateInterval:intervalInSeconds];
}

- (void)startListening {
//    if (!_hasListeners) {
//        _hasListeners = YES;
//    }
//   [_motionManager startAccelerometerUpdates];
//
//   /* Receive the accelerometer data on this block */
//   [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
//                                            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
//   {
//      double x = accelerometerData.acceleration.x;
//      double y = accelerometerData.acceleration.y;
//      double z = accelerometerData.acceleration.z;
//      double timestamp = [RNSensorsUtils sensorTimestampToEpochMilliseconds:accelerometerData.timestamp];
//
//      [self sendEvent:@"RNSensorsAccelerometer" body:@{
//                                                        @"x" : [NSNumber numberWithDouble:x],
//                                                        @"y" : [NSNumber numberWithDouble:y],
//                                                        @"z" : [NSNumber numberWithDouble:z],
//                                                        @"timestamp" : [NSNumber numberWithDouble:timestamp]
//                                                    }];
//   }];
}

- (void)stopListening {
//    if (_hasListeners && _motionManager) {
//     [_motionManager stopAccelerometerUpdates];
//        _hasListeners = NO;
//    }
}

@end
