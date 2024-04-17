#import <CoreMotion/CoreMotion.h>

@interface MotionSensors : NSObject {
    CMMotionManager *_motionManager;
    bool hasListeners;
}

//- (instancetype)initWithContext:(NSString *)sensorName module:(TurboSensors *)module;

- (void)isAvailable;

- (void)setInterval:(double)newInterval;

- (void)startListening;

- (void)stopListening;

@end
