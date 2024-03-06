#import <React/RCTLog.h>
#import "TurboSensors.h"

@implementation TurboSensors
RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents {
  return @[@"accelerometerEvent"];
}

- (void)sendEvent:(NSString *)eventName body:(id)body {
  [self sendEventWithName:eventName body:body];
}

RCT_EXPORT_METHOD(multiply:(double)a
                  b:(double)b
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    NSNumber *result = @(a * b);
    RCTLogInfo(@"log %@ * %@", a, b);
    resolve(result);
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
