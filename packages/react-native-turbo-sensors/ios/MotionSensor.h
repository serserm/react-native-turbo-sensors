#import <CoreMotion/CoreMotion.h>
#import "TurboSensors.h"

@interface MotionSensors : NSObject {
    CMMotionManager *_motionManager;

    TurboSensors *_module;
    NSString *_module;
    bool hasListeners;
}

//- (instancetype)init:(NSString *)sensorName module:(TurboSensors *)module;

- (void)isAvailable;

- (void)setInterval:(double)newInterval;

- (void)startListening;

- (void)stopListening;

@end
