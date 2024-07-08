#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface MotionSensor : NSObject

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, copy) NSString *sensorName;
@property (nonatomic, assign) BOOL hasListeners;
@property (nonatomic, assign) double intervalInSeconds;

- (instancetype)initWithSensorName:(NSString *)sensorName;

- (BOOL)isAvailable;

- (void)setInterval:(double)newInterval;

- (void)startListening;

- (void)stopListening;

@end
