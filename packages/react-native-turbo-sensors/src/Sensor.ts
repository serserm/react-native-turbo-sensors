import { type EmitterSubscription, NativeEventEmitter } from 'react-native';

import { TurboSensors } from './TurboSensors';
import type { ListenerType, SensorNameType } from './types';

export class Sensor {
  #subscription?: EmitterSubscription;

  startListening = (listener: ListenerType) => {
    const eventEmitter = new NativeEventEmitter(TurboSensors);
    this.#subscription = eventEmitter.addListener(`sensorsEvent`, params => {
      listener(params);
    });
  };

  stopListening = (): void => {
    this.#subscription?.remove();
  };

  isAvailable = (name: SensorNameType): Promise<boolean> => {
    return TurboSensors.isAvailable(name);
  };

  setInterval = (name: SensorNameType, interval: number): void => {
    TurboSensors.setInterval(name, interval);
  };

  startSensor = (name: SensorNameType): void => {
    TurboSensors.startSensor(name);
  };

  stopSensor = (name: SensorNameType): void => {
    TurboSensors.stopSensor(name);
  };
}
