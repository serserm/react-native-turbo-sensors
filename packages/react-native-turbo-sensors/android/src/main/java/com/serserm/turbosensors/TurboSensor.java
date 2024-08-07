package com.serserm.turbosensors;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.SystemClock;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

public class TurboSensor implements SensorEventListener {
  private ReactApplicationContext reactContext;

  private final String sensorName;
  private final Sensor sensor;
  private final int sensorType;
  private final SensorManager sensorManager;
  private int interval = 200000;
  private boolean isListenerRegistered = false;

  TurboSensor(ReactApplicationContext context, String sensorName) {
    this.reactContext = context;
    this.sensorName = sensorName;
    this.sensorType = getType(sensorName);
    this.sensorManager = (SensorManager) context.getSystemService(reactContext.SENSOR_SERVICE);
    this.sensor = sensorManager.getDefaultSensor(sensorType);
  }

  @Override
  public void onSensorChanged(SensorEvent sensorEvent) {
    sendEvent(getParams(sensorEvent));
  }

  @Override
  public void onAccuracyChanged(Sensor sensor, int accuracy) {
  }

  private void sendEvent(@Nullable WritableMap params) {
    reactContext
        .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
        .emit("sensorsEvent", params);
  }

  private int getType(String sensorName) {
    switch (sensorName) {
      // Motion sensors
      case "accelerometer":
        return Sensor.TYPE_ACCELEROMETER;
      case "gyroscope":
        return Sensor.TYPE_GYROSCOPE;
      case "magnetometer":
        return Sensor.TYPE_MAGNETIC_FIELD;
      case "gravity":
        return Sensor.TYPE_GRAVITY;
      case "rotation":
        return Sensor.TYPE_ROTATION_VECTOR;
      case "acceleration":
        return Sensor.TYPE_LINEAR_ACCELERATION;
      // Position sensors
      case "proximity":
        return Sensor.TYPE_PROXIMITY;
      // Environment sensors
      case "barometer":
        return Sensor.TYPE_PRESSURE;
      case "light":
        return Sensor.TYPE_LIGHT;
      case "temperature":
        return Sensor.TYPE_AMBIENT_TEMPERATURE;
      case "humidity":
        return Sensor.TYPE_RELATIVE_HUMIDITY;
      default:
        return Sensor.TYPE_ALL;
    }
  }

  private double sensorTimestampToEpochMilliseconds(long elapsedTime) {
    // elapsedTime = The time in nanoseconds at which the event happened.
    return System.currentTimeMillis() + ((elapsedTime - SystemClock.elapsedRealtimeNanos()) / 1000000L);
  }

  private WritableMap getParams(SensorEvent sensorEvent) {
    int currentType = sensorEvent.sensor.getType();
    double tempMs = (double) System.currentTimeMillis();
    WritableMap params = Arguments.createMap();
    WritableMap data = Arguments.createMap();

    switch (currentType) {
      case Sensor.TYPE_ROTATION_VECTOR:
        float[] rotation = new float[9];
        float[] orientation = new float[3];
        float[] quaternion = new float[4];
        SensorManager.getQuaternionFromVector(quaternion, sensorEvent.values);
        SensorManager.getRotationMatrixFromVector(rotation, sensorEvent.values);
        SensorManager.getOrientation(rotation, orientation);

        data.putDouble("qw", quaternion[0]);
        data.putDouble("qx", quaternion[1]);
        data.putDouble("qy", quaternion[2]);
        data.putDouble("qz", quaternion[3]);

        data.putDouble("yaw", orientation[0]);
        data.putDouble("pitch", orientation[1]);
        data.putDouble("roll", orientation[2]);

        params.putMap("data", data);
        break;
      case Sensor.TYPE_ACCELEROMETER:
      case Sensor.TYPE_GRAVITY:
      case Sensor.TYPE_GYROSCOPE:
      case Sensor.TYPE_MAGNETIC_FIELD:
      case Sensor.TYPE_LINEAR_ACCELERATION:
        data.putDouble("x", sensorEvent.values[0]);
        data.putDouble("y", sensorEvent.values[1]);
        data.putDouble("z", sensorEvent.values[2]);

        params.putMap("data", data);
        break;
      default:
        params.putDouble("data", sensorEvent.values[0]);
        break;
    }

    params.putDouble("timestamp", sensorTimestampToEpochMilliseconds(sensorEvent.timestamp));
    params.putString("name", sensorName);
    params.putString("type", "onChanged");

    return params;
  }

  public boolean isAvailable() {
    return sensor != null;
  }

  public void startListening() {
    if (!isAvailable()) {
      WritableMap params = Arguments.createMap();
      params.putInt("errorCode", 1);
      params.putString("errorMessage", "Not available");
      params.putString("name", sensorName);
      params.putString("type", "onError");
      sendEvent(params);
      return;
    }
    if (!isListenerRegistered && sensorManager != null) {
      sensorManager.registerListener(this, sensor, interval);
      isListenerRegistered = true;
    }
  }

  public void stopListening() {
    if (!isAvailable()) {
      return;
    }
    if (isListenerRegistered && sensorManager != null) {
      sensorManager.unregisterListener(this);
      isListenerRegistered = false;
    }
  }

  public void setInterval(int newInterval) {
    if (!isAvailable()) {
      WritableMap params = Arguments.createMap();
      params.putInt("errorCode", 1);
      params.putString("errorMessage", "Not available");
      params.putString("name", sensorName);
      params.putString("type", "onError");
      sendEvent(params);
      return;
    }
    if (newInterval >= 0) {
      // Milliseconds to Microseconds conversion
      interval = newInterval * 1000;
    }
  }
}
