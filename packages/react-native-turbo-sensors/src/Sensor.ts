import { type EmitterSubscription, NativeEventEmitter } from 'react-native';

import { TurboSensors } from './TurboSensors';
import type { SensorListenerType, SensorName } from './types';

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

  startListening = (listener: SensorListenerType) => {
    const eventEmitter = new NativeEventEmitter(TurboSensors);
    this.#subscription = eventEmitter.addListener(
      `${this.#name}Event`,
      listener,
    );
  };

  stopListening = (): void => {
    TurboSensors.stopListening(this.#name);
    this.#subscription?.remove();
  };
}
