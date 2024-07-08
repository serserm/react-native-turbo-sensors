#import "TurboSensors.h"
#import "MotionSensor.h"

@implementation TurboSensors
RCT_EXPORT_MODULE();

- (instancetype)init {
    self = [super init];
    if (self) {
         _sensorMap = [NSMutableDictionary dictionary];
        [_sensorMap setObject:[[MotionSensor alloc] initWithSensorName:@"accelerometer"] forKey:@"accelerometer"];
        [_sensorMap setObject:[[MotionSensor alloc] initWithSensorName:@"gyroscope"] forKey:@"gyroscope"];
        [_sensorMap setObject:[[MotionSensor alloc] initWithSensorName:@"magnetometer"] forKey:@"magnetometer"];
        [_sensorMap setObject:[[MotionSensor alloc] initWithSensorName:@"gravity"] forKey:@"gravity"];
    }
    return self;
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"accelerometerEvent"];
}

- (void)sendEvent:(NSString *)eventName body:(id)body {
    [self sendEventWithName:eventName body:body];
}

// Will be called when this module's first listener is added.
- (void)startObserving {
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
- (void)stopObserving {
    // Remove upstream listeners, stop unnecessary background tasks
    // If we no longer have listeners registered we should also probably also stop the sensor since the sensor events are essentially being dropped.
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
