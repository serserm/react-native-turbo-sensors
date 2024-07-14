#import "TurboSensors.h"
#import "MotionSensor.h"

@implementation TurboSensors
RCT_EXPORT_MODULE();

- (instancetype)init {
    self = [super init];
    if (self) {
        _hasListeners = NO;
        _sensorMap = [NSMutableDictionary dictionary];
        [_sensorMap setObject:[[MotionSensor alloc] init:@"accelerometer" delegate:self] forKey:@"accelerometer"];
        [_sensorMap setObject:[[MotionSensor alloc] init:@"gyroscope" delegate:self] forKey:@"gyroscope"];
        [_sensorMap setObject:[[MotionSensor alloc] init:@"magnetometer" delegate:self] forKey:@"magnetometer"];
        [_sensorMap setObject:[[MotionSensor alloc] init:@"gravity" delegate:self] forKey:@"gravity"];
        [_sensorMap setObject:[[MotionSensor alloc] init:@"rotation" delegate:self] forKey:@"rotation"];
        [_sensorMap setObject:[[MotionSensor alloc] init:@"acceleration" delegate:self] forKey:@"rotation"];
    }
    return self;
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"sensorsEvent"];
}

- (void)sendEvent:(id)body {
    if (_hasListeners) {
        [self sendEventWithName:@"sensorsEvent" body:body];
    }
}

// Will be called when this module's first listener is added.
- (void)startObserving {
    // Set up any upstream listeners or background tasks as necessary
    _hasListeners = YES;
}

// Will be called when this module's last listener is removed, or on dealloc.
- (void)stopObserving {
    // Remove upstream listeners, stop unnecessary background tasks
    // If we no longer have listeners registered we should also probably also stop the sensor since the sensor events are essentially being dropped.
    for (NSString *key in _sensorMap) {
        MotionSensor *sensor = [_sensorMap objectForKey:key];
        [sensor stopListening];
    }
    _hasListeners = NO;
}

- (double)sensorTimestamp:(NSTimeInterval)timestamp {
    return floor(([[NSDate date] timeIntervalSince1970] + (timestamp - [[NSProcessInfo processInfo] systemUptime])) * 1000);
}

RCT_EXPORT_METHOD(isAvailable:(NSString *)sensor
            resolve:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject) {
    MotionSensor *sensorObject = [_sensorMap objectForKey:sensor];
    if (sensorObject != nil) {
        BOOL available = [sensorObject isAvailable];
        resolve(@(available));
    } else {
        reject(@"sensor_not_found", @"Sensor not found", nil);
    }
}

RCT_EXPORT_METHOD(setInterval:(NSString *)sensor
            newInterval:(double)newInterval) {
    MotionSensor *sensorObject = [_sensorMap objectForKey:sensor];
    if (sensorObject != nil) {
        [sensorObject setInterval:newInterval];
    }
}

RCT_EXPORT_METHOD(startListening:(NSString *)sensor) {
    MotionSensor *sensorObject = [_sensorMap objectForKey:sensor];
    if (sensorObject != nil) {
        [sensorObject startListening];
    }
}

RCT_EXPORT_METHOD(stopListening:(NSString *)sensor) {
    MotionSensor *sensorObject = [_sensorMap objectForKey:sensor];
    if (sensorObject != nil) {
        [sensorObject stopListening];
    }
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
