#import "MotionSensor.h"

@implementation MotionSensor

- (instancetype)init:(NSString *)sensorName delegate:(TurboSensors *)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _motionManager = [[CMMotionManager alloc] init];
        _altimeter = [[CMAltimeter alloc] init];
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
    } else if ([_sensorName isEqualToString:@"barometer"]) {
        return [CMAltimeter isRelativeAltitudeAvailable];
    } else {
        return _motionManager.deviceMotionAvailable;
    }
}

- (void)setInterval:(double)newInterval {
    if (![self isAvailable]) {
        [_delegate sendEvent:@{
                @"errorCode" : @1,
                @"errorMessage" : @"Not available",
                @"name" : _sensorName,
                @"type" : @"onError"
            }];
        return;
    }
    _intervalInSeconds = newInterval / 1000;
    if ([_sensorName isEqualToString:@"accelerometer"]) {
        _motionManager.accelerometerUpdateInterval = _intervalInSeconds;
    } else if ([_sensorName isEqualToString:@"gyroscope"]) {
        _motionManager.gyroUpdateInterval = _intervalInSeconds;
    } else if ([_sensorName isEqualToString:@"magnetometer"]) {
        _motionManager.magnetometerUpdateInterval = _intervalInSeconds;
    } else if ([_sensorName isEqualToString:@"barometer"]) {
        // nil
    } else {
        _motionManager.deviceMotionUpdateInterval = _intervalInSeconds;
    }
}

- (void)startListening {
    if (![self isAvailable]) {
        [_delegate sendEvent:@{
                @"errorCode" : @1,
                @"errorMessage" : @"Not available",
                @"name" : _sensorName,
                @"type" : @"onError"
            }];
        return;
    }
    if ([_sensorName isEqualToString:@"accelerometer"]) {
        if (_motionManager.accelerometerActive) {
            return;
        }
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
        {
            if (error) {
                [_delegate sendEvent:@{
                        @"errorCode" : @2,
                        @"errorMessage" : @"Error",
                        @"name" : _sensorName,
                        @"type" : @"onError"
                    }];
                return;
            }
            double timestamp = [_delegate sensorTimestamp:accelerometerData.timestamp];
            [_delegate sendEvent:@{
                    @"value" : @{
                        @"x" : [NSNumber numberWithDouble:accelerometerData.acceleration.x],
                        @"y" : [NSNumber numberWithDouble:accelerometerData.acceleration.y],
                        @"z" : [NSNumber numberWithDouble:accelerometerData.acceleration.z]
                    },
                    @"timestamp" : [NSNumber numberWithDouble:timestamp],
                    @"name" : _sensorName,
                    @"type" : @"onChanged"
                }];
        }];
    } else if ([_sensorName isEqualToString:@"gyroscope"]) {
        if (_motionManager.gyroActive) {
            return;
        }
        [_motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                withHandler:^(CMGyroData *gyroData, NSError *error)
        {
            if (error) {
                [_delegate sendEvent:@{
                        @"errorCode" : @2,
                        @"errorMessage" : @"Error",
                        @"name" : _sensorName,
                        @"type" : @"onError"
                    }];
                return;
            }
            double timestamp = [_delegate sensorTimestamp:gyroData.timestamp];
            [_delegate sendEvent:@{
                    @"value" : @{
                        @"x" : [NSNumber numberWithDouble:gyroData.rotationRate.x],
                        @"y" : [NSNumber numberWithDouble:gyroData.rotationRate.y],
                        @"z" : [NSNumber numberWithDouble:gyroData.rotationRate.z]
                    },
                    @"timestamp" : [NSNumber numberWithDouble:timestamp],
                    @"name" : _sensorName,
                    @"type" : @"onChanged"
                }];
        }];
    } else if ([_sensorName isEqualToString:@"magnetometer"]) {
        if (_motionManager.magnetometerActive) {
            return;
        }
        [_motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue]
                withHandler:^(CMMagnetometerData *magnetometerData, NSError *error)
        {
            if (error) {
                [_delegate sendEvent:@{
                        @"errorCode" : @2,
                        @"errorMessage" : @"Error",
                        @"name" : _sensorName,
                        @"type" : @"onError"
                    }];
                return;
            }
            double timestamp = [_delegate sensorTimestamp:magnetometerData.timestamp];
            [_delegate sendEvent:@{
                    @"value" : @{
                        @"x" : [NSNumber numberWithDouble:magnetometerData.magneticField.x],
                        @"y" : [NSNumber numberWithDouble:magnetometerData.magneticField.y],
                        @"z" : [NSNumber numberWithDouble:magnetometerData.magneticField.z]
                    },
                    @"timestamp" : [NSNumber numberWithDouble:timestamp],
                    @"name" : _sensorName,
                    @"type" : @"onChanged"
                }];
        }];
    } else if ([_sensorName isEqualToString:@"barometer"]) {
        if (_hasListeners) {
            return;
        }
        [_altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue mainQueue]
                withHandler:^(CMAltitudeData *altitudeData, NSError *error)
        {
            if (error) {
                [_delegate sendEvent:@{
                        @"errorCode" : @2,
                        @"errorMessage" : @"Error",
                        @"name" : _sensorName,
                        @"type" : @"onError"
                    }];
                return;
            }
            [_delegate sendEvent:@{
                    @"value" : altitudeData.pressure,
//                     @"timestamp" : [NSNumber numberWithDouble:timestamp],
                    @"name" : _sensorName,
                    @"type" : @"onChanged"
                }];
        }];
        _hasListeners = YES;
    } else if (!_motionManager.deviceMotionActive) {
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                withHandler:^(CMDeviceMotion *deviceMotionData, NSError *error)
        {
            if (error) {
                [_delegate sendEvent:@{
                        @"errorCode" : @2,
                        @"errorMessage" : @"Error",
                        @"name" : _sensorName,
                        @"type" : @"onError"
                    }];
                return;
            }
            double timestamp = [_delegate sensorTimestamp:deviceMotionData.timestamp];
            [_delegate sendEvent:@{
                    @"value" : @{
                        @"x" : [NSNumber numberWithDouble:deviceMotionData.gravity.x],
                        @"y" : [NSNumber numberWithDouble:deviceMotionData.gravity.y],
                        @"z" : [NSNumber numberWithDouble:deviceMotionData.gravity.z]
                    },
                    @"timestamp" : [NSNumber numberWithDouble:timestamp],
                    @"name" : @"gravity",
                    @"type" : @"onChanged"
                }];
            [_delegate sendEvent:@{
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
                    @"name" : @"rotation",
                    @"type" : @"onChanged"
                }];
            [_delegate sendEvent:@{
                    @"value" : @{
                        @"x" : [NSNumber numberWithDouble:deviceMotionData.userAcceleration.x],
                        @"y" : [NSNumber numberWithDouble:deviceMotionData.userAcceleration.y],
                        @"z" : [NSNumber numberWithDouble:deviceMotionData.userAcceleration.z]
                    },
                    @"timestamp" : [NSNumber numberWithDouble:timestamp],
                    @"name" : @"acceleration",
                    @"type" : @"onChanged"
                }];
        }];
    }
}

- (void)stopListening {
    if (![self isAvailable]) {
        return;
    }
    if ([_sensorName isEqualToString:@"accelerometer"]) {
        if (_motionManager.accelerometerActive) {
            [_motionManager stopAccelerometerUpdates];
        }
    } else if ([_sensorName isEqualToString:@"gyroscope"]) {
        if (_motionManager.gyroActive) {
            [_motionManager stopGyroUpdates];
        }
    } else if ([_sensorName isEqualToString:@"magnetometer"]) {
        if (_motionManager.magnetometerActive) {
            [_motionManager stopMagnetometerUpdates];
        }
    } else if ([_sensorName isEqualToString:@"barometer"]) {
        if (_hasListeners) {
            [_altimeter stopRelativeAltitudeUpdates];
            _hasListeners = NO;
        }
    } else if (_motionManager.deviceMotionActive) {
        [_motionManager stopDeviceMotionUpdates];
    }
}

@end
