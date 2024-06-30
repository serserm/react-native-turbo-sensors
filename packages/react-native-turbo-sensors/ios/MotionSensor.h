#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface MotionSensors : NSObject {
    CMMotionManager * _motionManager;
//    NSOperationQueue * _queue;

    NSString * _sensorName;
    bool _hasListeners;
    double _intervalInSeconds;
}

//- (instancetype)init:(NSString *)sensorName module:(TurboSensors *)module;
- (id)init:(NSString *)sensorName;

- (BOOL)isAvailable;

- (void)setInterval:(double)newInterval;

- (void)startListening;

- (void)stopListening;

@end
