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

  private final String name;
  private final Sensor sensor;
  private final int sensorType;
  private final SensorManager sensorManager;
  private int interval = SensorManager.SENSOR_DELAY_NORMAL;
  private boolean isListenerRegistered = false;

  TurboSensor(ReactApplicationContext context, String sensorName) {
    this.reactContext = context;
    this.name = sensorName;
    this.sensorType = getType(sensorName);
    this.sensorManager = (SensorManager) context.getSystemService(reactContext.SENSOR_SERVICE);
    this.sensor = sensorManager.getDefaultSensor(sensorType);
  }

  @Override
  public void onSensorChanged(SensorEvent sensorEvent) {
    sendEvent(name + "Event", getParams(sensorEvent));
  }

  @Override
  public void onAccuracyChanged(Sensor sensor, int accuracy) {
  }

  private void sendEvent(String eventName,
                         @Nullable WritableMap params) {
    reactContext
        .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
        .emit(eventName, params);
  }

  private int getType(String sensorName) {
    switch (sensorName) {
      case "accelerometer":
        return Sensor.TYPE_ACCELEROMETER;
      case "gravity":
        return Sensor.TYPE_GRAVITY;
      case "gyroscope":
        return Sensor.TYPE_GYROSCOPE;
      case "magnetometer":
        return Sensor.TYPE_MAGNETIC_FIELD;
      case "barometer":
        return Sensor.TYPE_PRESSURE;
      case "acceleration":
        return Sensor.TYPE_LINEAR_ACCELERATION;
      case "proximity":
        return Sensor.TYPE_PROXIMITY;
      case "light":
        return Sensor.TYPE_LIGHT;
      case "temperature":
        return Sensor.TYPE_AMBIENT_TEMPERATURE;
      case "humidity":
        return Sensor.TYPE_RELATIVE_HUMIDITY;
      default:
        return Sensor.TYPE_ROTATION_VECTOR;
    }
    // TYPE_STEP_DETECTOR
    // TYPE_STEP_COUNTER
    // TYPE_STATIONARY_DETECT
    // TYPE_SIGNIFICANT_MOTION
    // TYPE_MOTION_DETECT
    // TYPE_HINGE_ANGLE
    // TYPE_HEART_RATE
    // TYPE_HEART_BEAT
    // TYPE_HEAD_TRACKER
    // TYPE_HEADING
  }

  private double sensorTimestampToEpochMilliseconds(long elapsedTime) {
    // elapsedTime = The time in nanoseconds at which the event happened.
    return System.currentTimeMillis() + ((elapsedTime - SystemClock.elapsedRealtimeNanos()) / 1000000L);
  }

  private WritableMap getParams(SensorEvent sensorEvent) {
    int currentType = sensorEvent.sensor.getType();
    double tempMs = (double) System.currentTimeMillis();
    WritableMap params = Arguments.createMap();
    WritableMap value = Arguments.createMap();

    switch (currentType) {
      case Sensor.TYPE_ROTATION_VECTOR:
        float[] rotation = new float[9];
        float[] orientation = new float[3];
        float[] quaternion = new float[4];
        SensorManager.getQuaternionFromVector(quaternion, sensorEvent.values);
        SensorManager.getRotationMatrixFromVector(rotation, sensorEvent.values);
        SensorManager.getOrientation(rotation, orientation);

        value.putDouble("qw", quaternion[0]);
        value.putDouble("qx", quaternion[1]);
        value.putDouble("qy", quaternion[2]);
        value.putDouble("qz", quaternion[3]);

        value.putDouble("yaw", orientation[0]);
        value.putDouble("pitch", orientation[1]);
        value.putDouble("roll", orientation[2]);

        params.putMap("value", value);
        break;
      case Sensor.TYPE_ACCELEROMETER:
      case Sensor.TYPE_GRAVITY:
      case Sensor.TYPE_GYROSCOPE:
      case Sensor.TYPE_MAGNETIC_FIELD:
      case Sensor.TYPE_LINEAR_ACCELERATION:
        value.putDouble("x", sensorEvent.values[0]);
        value.putDouble("y", sensorEvent.values[1]);
        value.putDouble("z", sensorEvent.values[2]);

        params.putMap("value", value);
        break;
      default:
        params.putDouble("value", sensorEvent.values[0]);
        break;
    }

    params.putDouble("timestamp", sensorTimestampToEpochMilliseconds(sensorEvent.timestamp));
    params.putString("name", name);

    return params;
  }

  public boolean isAvailable() {
    return sensor != null;
  }

  public void startListening() {
    if (!isListenerRegistered && sensorManager != null && sensor != null) {
      sensorManager.registerListener(this, sensor, interval);
      isListenerRegistered = true;
    }
  }

  public void stopListening() {
    if (isListenerRegistered && sensorManager != null && sensor != null) {
      sensorManager.unregisterListener(this);
      isListenerRegistered = false;
    }
  }

  public void setInterval(int newInterval) {
    if (newInterval >= 0) {
      // Milliseconds to Microseconds conversion
      interval = newInterval * 1000;
    }
  }
}
