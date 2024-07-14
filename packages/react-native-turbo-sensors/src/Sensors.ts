import { type EmitterSubscription, NativeEventEmitter } from 'react-native';

import { TurboSensors } from './TurboSensors';
import type { ListenerType, SensorName } from './types';

export class Sensors {
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

  isAvailable = (name: SensorName): Promise<boolean> => {
    return TurboSensors.isAvailable(name);
  };

  setInterval = (name: SensorName, interval: number): void => {
    TurboSensors.setInterval(name, interval);
  };

  startSensor = (name: SensorName): void => {
    TurboSensors.startSensor(name);
  };

  stopSensor = (name: SensorName): void => {
    TurboSensors.stopSensor(name);
  };
}
