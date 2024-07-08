#import "MotionSensor.h"

@implementation MotionSensor

- (instancetype)initWithSensorName:(NSString *)sensorName {
    self = [super init];
    if (self) {
        _motionManager = [[CMMotionManager alloc] init];
        _sensorName = [sensorName copy];
        _hasListeners = NO;
        _intervalInSeconds = 0.1;
    }
    return self;
}

- (BOOL)isAvailable {
    if ([_sensorName isEqualToString:@"accelerometer"]) {
        return _motionManager.accelerometerAvailable;
    } else if ([_sensorName isEqualToString:@"gyroscope"]) {
        return _motionManager.gyroAvailable;
    } else if ([_sensorName isEqualToString:@"magnetometer"]) {
        return _motionManager.magnetometerAvailable;
    } else if ([_sensorName isEqualToString:@"gravity"]) {
        return _motionManager.deviceMotionAvailable;
    }
    return NO;
}

- (void)setInterval:(double)newInterval {
    _intervalInSeconds = newInterval / 1000;
    if ([_sensorName isEqualToString:@"accelerometer"]) {
        _motionManager.accelerometerUpdateInterval = _intervalInSeconds;
    } else if ([_sensorName isEqualToString:@"gyroscope"]) {
        _motionManager.gyroUpdateInterval = _intervalInSeconds;
    } else if ([_sensorName isEqualToString:@"magnetometer"]) {
        _motionManager.magnetometerUpdateInterval = _intervalInSeconds;
    } else if ([_sensorName isEqualToString:@"gravity"]) {
        _motionManager.deviceMotionUpdateInterval = _intervalInSeconds;
    }
}

- (void)startListening {
    if ([_sensorName isEqualToString:@"accelerometer"] && !_motionManager.accelerometerActive) {
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
        {
//             if (error) {
//
//             }
//             double x = accelerometerData.acceleration.x;
//             double y = accelerometerData.acceleration.y;
//             double z = accelerometerData.acceleration.z;
//             double timestamp = [RNSensorsUtils sensorTimestampToEpochMilliseconds:accelerometerData.timestamp];

//             [self sendEvent:@"RNSensorsAccelerometer" body:@{
//                                                               @"x" : [NSNumber numberWithDouble:x],
//                                                               @"y" : [NSNumber numberWithDouble:y],
//                                                               @"z" : [NSNumber numberWithDouble:z],
//                                                               @"timestamp" : [NSNumber numberWithDouble:timestamp]
//                                                           }];
        }];
    } else if ([_sensorName isEqualToString:@"gyroscope"] && !_motionManager.gyroActive) {
        [_motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMGyroData *gyroData, NSError *error)
        {
//             if (error) {
//
//             }
        }];
    } else if ([_sensorName isEqualToString:@"magnetometer"] && !_motionManager.magnetometerActive) {
        [_motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMMagnetometerData *magnetometerData, NSError *error)
        {
//             if (error) {
//
//             }
        }];
    } else if ([_sensorName isEqualToString:@"gravity"] && !_motionManager.deviceMotionActive) {
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMDeviceMotion *deviceMotionData, NSError *error)
        {
//             if (error) {
//
//             }
        }];
    }
}

- (void)stopListening {
    if ([_sensorName isEqualToString:@"accelerometer"] && _motionManager.accelerometerActive) {
        [_motionManager stopAccelerometerUpdates];
    } else if ([_sensorName isEqualToString:@"gyroscope"] && _motionManager.gyroActive) {
        [_motionManager stopGyroUpdates];
    } else if ([_sensorName isEqualToString:@"magnetometer"] && _motionManager.magnetometerActive) {
        [_motionManager stopMagnetometerUpdates];
    } else if ([_sensorName isEqualToString:@"gravity"] && _motionManager.deviceMotionActive) {
        [_motionManager stopDeviceMotionUpdates];
    }
}

@end
