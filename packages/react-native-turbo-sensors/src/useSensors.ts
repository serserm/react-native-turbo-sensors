import { useEffect } from 'react';
import { NativeEventEmitter } from 'react-native';

import { TurboSensors } from './TurboSensors';
import { SensorTypes } from './types';

export function useSensors(params: {
  sensor: SensorTypes;
  onChange?: (data: any) => void;
}): {
  send: () => void;
  state: () => void;
} {
  const { sensor, onChange } = params || {};

  useEffect(() => {
    const eventEmitter = new NativeEventEmitter(TurboSensors);

    const eventListener =
      sensor &&
      onChange &&
      eventEmitter.addListener(`${sensor}Change`, onChange);

    return () => {
      eventListener?.remove();
    };
  }, []);

  function send() {
    if (sensor) {
      TurboSensors.send(sensor);
    }
  }

  function state() {
    if (sensor) {
      TurboSensors.state(sensor).then((res: object) => {
        console.log('res', res);
      });
    }
  }

  // function start() {
  //   // this.#api?.startUpdates();
  // }
  //
  // function isAvailable() {
  //   // return this.#available;
  // }
  //
  // function stop() {
  //   // this.#api?.stopUpdates();
  // }
  //
  // function setUpdateInterval() {
  //   // this.#api?.setUpdateInterval(updateInterval);
  // }
  //
  // function setLogLevelForType() {
  //   // this.#api?.setLogLevel(level);
  // }

  return {
    send,
    state,
    // start,
    // stop,
    // isAvailable,
    // setUpdateInterval,
    // setLogLevelForType,
  };
}
