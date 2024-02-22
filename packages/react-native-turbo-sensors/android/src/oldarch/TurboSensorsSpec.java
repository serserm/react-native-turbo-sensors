package com.serserm.turbosensors;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.Promise;

abstract class TurboSensorsSpec extends ReactContextBaseJavaModule {
  TurboSensorsSpec(ReactApplicationContext context) {
    super(context);
  }

  public abstract void addListener(String eventName);

  public abstract void removeListeners(double count);

  public abstract void send(String sensor);

  public abstract void state(String sensor, Promise promise);
}
