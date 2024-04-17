#import "MotionSensors.h"

@implementation MotionSensors

//- (id)initWithContext:(NSString *)sensorName
//                  module:(TurboSensors *)module {
//    self = [super init];
//
//    if (self) {
//        _module = module;
//    }
//    return self;
//}

- (void)isAvailable {
//     if([self->_motionManager isAccelerometerAvailable])
//     {
//         /* Start the accelerometer if it is not active already */
//         if([self->_motionManager isAccelerometerActive] == NO)
//         {
//             resolve(@YES);
//         } else {
//             reject(@"-1", @"Accelerometer is not active", nil);
//         }
//     }
//     else
//     {
//         reject(@"-1", @"Accelerometer is not available", nil);
//     }
}

- (void)setInterval:(double)newInterval {
//   double intervalInSeconds = newInterval / 1000;
//
//   [self->_motionManager setAccelerometerUpdateInterval:intervalInSeconds];
}

- (void)startListening {
    hasListeners = YES;
//   [self->_motionManager startAccelerometerUpdates];
//
//   /* Receive the accelerometer data on this block */
//   [self->_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
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
    hasListeners = NO;
    if (self->_motionManager) {
//     [self stopListening];
//     [self->_motionManager stopAccelerometerUpdates];
    }
}

@end
