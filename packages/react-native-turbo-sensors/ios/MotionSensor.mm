#import "MotionSensor.h"

@implementation MotionSensor

- (instancetype)init:(NSString *)sensorName delegate:(TurboSensors *)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
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
    } else {
        return _motionManager.deviceMotionAvailable;
    }
}

- (void)setInterval:(double)newInterval {
    _intervalInSeconds = newInterval / 1000;
    if ([_sensorName isEqualToString:@"accelerometer"]) {
        _motionManager.accelerometerUpdateInterval = _intervalInSeconds;
    } else if ([_sensorName isEqualToString:@"gyroscope"]) {
        _motionManager.gyroUpdateInterval = _intervalInSeconds;
    } else if ([_sensorName isEqualToString:@"magnetometer"]) {
        _motionManager.magnetometerUpdateInterval = _intervalInSeconds;
    } else {
        _motionManager.deviceMotionUpdateInterval = _intervalInSeconds;
    }
}

- (void)startListening {
//     NSString *eventName = [_sensorName stringByAppendingString:@"Event"];
    if ([_sensorName isEqualToString:@"accelerometer"] && !_motionManager.accelerometerActive) {
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
        {
            if (!error) {
                double timestamp = [_delegate sensorTimestamp:accelerometerData.timestamp];
                [_delegate sendEvent:@"accelerometerEvent"
                    body:@{
                        @"value" : @{
                            @"x" : [NSNumber numberWithDouble:accelerometerData.acceleration.x],
                            @"y" : [NSNumber numberWithDouble:accelerometerData.acceleration.y],
                            @"z" : [NSNumber numberWithDouble:accelerometerData.acceleration.z]
                        },
                        @"timestamp" : [NSNumber numberWithDouble:timestamp],
                        @"name" : @"accelerometer"
                    }];
            }
        }];
    } else if ([_sensorName isEqualToString:@"gyroscope"] && !_motionManager.gyroActive) {
        [_motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMGyroData *gyroData, NSError *error)
        {
            if (!error) {
                double timestamp = [_delegate sensorTimestamp:gyroData.timestamp];
                [_delegate sendEvent:@"gyroscopeEvent"
                    body:@{
                        @"value" : @{
                            @"x" : [NSNumber numberWithDouble:gyroData.rotationRate.x],
                            @"y" : [NSNumber numberWithDouble:gyroData.rotationRate.y],
                            @"z" : [NSNumber numberWithDouble:gyroData.rotationRate.z]
                        },
                        @"timestamp" : [NSNumber numberWithDouble:timestamp],
                        @"name" : @"gyroscope"
                    }];
            }
        }];
    } else if ([_sensorName isEqualToString:@"magnetometer"] && !_motionManager.magnetometerActive) {
        [_motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMMagnetometerData *magnetometerData, NSError *error)
        {
            if (!error) {
                double timestamp = [_delegate sensorTimestamp:magnetometerData.timestamp];
                [_delegate sendEvent:@"magnetometerEvent"
                    body:@{
                        @"value" : @{
                            @"x" : [NSNumber numberWithDouble:magnetometerData.magneticField.x],
                            @"y" : [NSNumber numberWithDouble:magnetometerData.magneticField.y],
                            @"z" : [NSNumber numberWithDouble:magnetometerData.magneticField.z]
                        },
                        @"timestamp" : [NSNumber numberWithDouble:timestamp],
                        @"name" : @"magnetometer"
                    }];
            }
        }];
    } else if (!_motionManager.deviceMotionActive) {
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMDeviceMotion *deviceMotionData, NSError *error)
        {
            if (!error) {
                double timestamp = [_delegate sensorTimestamp:deviceMotionData.timestamp];
                [_delegate sendEvent:@"gravityEvent"
                    body:@{
                        @"value" : @{
                            @"x" : [NSNumber numberWithDouble:deviceMotionData.gravity.x],
                            @"y" : [NSNumber numberWithDouble:deviceMotionData.gravity.y],
                            @"z" : [NSNumber numberWithDouble:deviceMotionData.gravity.z]
                        },
                        @"timestamp" : [NSNumber numberWithDouble:timestamp],
                        @"name" : @"gravity"
                    }];
                [_delegate sendEvent:@"rotationEvent"
                    body:@{
                        @"value" : @{
                            @"qw" : [NSNumber numberWithDouble:deviceMotionData.attitude.quaternion.w],
                            @"qx" : [NSNumber numberWithDouble:deviceMotionData.attitude.quaternion.x],
                            @"qy" : [NSNumber numberWithDouble:deviceMotionData.attitude.quaternion.y],
                            @"qz" : [NSNumber numberWithDouble:deviceMotionData.attitude.quaternion.z],
                            @"yaw" : [NSNumber numberWithDouble:deviceMotionData.attitude.yaw],
                            @"pitch" : [NSNumber numberWithDouble:deviceMotionData.attitude.pitch],
                            @"roll" : [NSNumber numberWithDouble:deviceMotionData.attitude.roll]
                        },
                        @"timestamp" : [NSNumber numberWithDouble:timestamp],
                        @"name" : @"rotation"
                    }];
                [_delegate sendEvent:@"accelerationEvent"
                    body:@{
                        @"value" : @{
                            @"x" : [NSNumber numberWithDouble:deviceMotionData.userAcceleration.x],
                            @"y" : [NSNumber numberWithDouble:deviceMotionData.userAcceleration.y],
                            @"z" : [NSNumber numberWithDouble:deviceMotionData.userAcceleration.z]
                        },
                        @"timestamp" : [NSNumber numberWithDouble:timestamp],
                        @"name" : @"acceleration"
                    }];
            }
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
    } else if (_motionManager.deviceMotionActive) {
        [_motionManager stopDeviceMotionUpdates];
    }
}

@end
