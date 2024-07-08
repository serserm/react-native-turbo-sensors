#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "TurboSensors.h"

@interface MotionSensor : NSObject

@property (nonatomic, weak) TurboSensors *delegate;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, copy) NSString *sensorName;
@property (nonatomic, assign) BOOL hasListeners;
@property (nonatomic, assign) double intervalInSeconds;

- (instancetype)init:(NSString *)sensorName delegate:(TurboSensors *)delegate;

- (BOOL)isAvailable;

- (void)setInterval:(double)newInterval;

- (void)startListening;

- (void)stopListening;

@end
