import { type EmitterSubscription, NativeEventEmitter } from 'react-native';

import { TurboSensors } from './TurboSensors';
import type { ListenerType, SensorName } from './types';

export class Sensor {
  readonly #name: SensorName;
  readonly #isAvailable: null | boolean;
  #subscription?: EmitterSubscription;

  constructor(name: SensorName) {
    this.#name = name;
    this.#isAvailable = null;
  }

  isAvailable = (): Promise<boolean> => {
    return this.#isAvailable !== null
      ? new Promise(resolve => {
          resolve(this.#isAvailable!);
        })
      : TurboSensors.isAvailable(this.#name);
  };

  startListening = (listener: ListenerType) => {
    const eventEmitter = new NativeEventEmitter(TurboSensors);
    this.#subscription = eventEmitter.addListener(`sensorsEvent`, params => {
      if (this.#name === params.name) {
        listener(params);
      }
    });
    TurboSensors.startListening(this.#name);
  };

  stopListening = (): void => {
    TurboSensors.stopListening(this.#name);
    this.#subscription?.remove();
  };
}
