package com.serserm.turbosensors;

import android.hardware.SensorManager;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;

import java.util.Map;
import java.util.HashMap;

public class TurboSensorsModule extends TurboSensorsSpec {
  public static final String NAME = "TurboSensors";

  private ReactApplicationContext reactContext;
  private int listenerCount = 0;
  private Map<String, TurboSensor> sensorMap = new HashMap<>();

  TurboSensorsModule(ReactApplicationContext context) {
    super(context);
    reactContext = context;
    sensorMap.put("orientation", new TurboSensor(context, "orientation"));
    sensorMap.put("rotation", new TurboSensor(context, "rotation"));
    sensorMap.put("accelerometer", new TurboSensor(context, "accelerometer"));
    sensorMap.put("gravity", new TurboSensor(context, "gravity"));
    sensorMap.put("gyroscope", new TurboSensor(context, "gyroscope"));
    sensorMap.put("magnetometer", new TurboSensor(context, "magnetometer"));
    sensorMap.put("barometer", new TurboSensor(context, "barometer"));
    sensorMap.put("acceleration", new TurboSensor(context, "acceleration"));
    sensorMap.put("proximity", new TurboSensor(context, "proximity"));
    sensorMap.put("light", new TurboSensor(context, "light"));
    sensorMap.put("temperature", new TurboSensor(context, "temperature"));
    sensorMap.put("humidity", new TurboSensor(context, "humidity"));
  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }

  @ReactMethod
  public void addListener(String eventName) {
    if (listenerCount == 0) {
      // Set up any upstream listeners or background tasks as necessary
    }
    listenerCount += 1;
  }

  @ReactMethod
  public void removeListeners(double count) {
    listenerCount -= (int) count;
    if (listenerCount <= 0) {
      listenerCount = 0;
      // Remove upstream listeners, stop unnecessary background tasks
      for (Map.Entry<String, TurboSensor> entry : sensorMap.entrySet()) {
        String key = entry.getKey();
        TurboSensor sensor = entry.getValue();
        sensor.stopListening();
      }
    }
  }

  @ReactMethod
  public void isAvailable(String sensor, Promise promise) {
    TurboSensor sensorT = sensorMap.get(sensor);
    if (sensorT != null) {
      promise.resolve(sensorT.isAvailable());
      return;
    }
    // No sensor found, throw error
    promise.reject(new RuntimeException("No " + sensor + " found"));
  }

  @ReactMethod
  public void setInterval(String sensor, double newInterval) {
    TurboSensor sensorT = sensorMap.get(sensor);
    if (sensorT != null) {
      sensorT.setInterval((int) newInterval);
    }
  }

  @ReactMethod
  public void startListening(String sensor) {
    TurboSensor sensorT = sensorMap.get(sensor);
    if (sensorT != null) {
      sensorT.startListening();
    }
  }

  @ReactMethod
  public void stopListening(String sensor) {
    TurboSensor sensorT = sensorMap.get(sensor);
    if (sensorT != null) {
      sensorT.stopListening();
    }
  }
}
