import { NativeModules } from 'react-native';

import { LINKING_ERROR } from './errors';

// @ts-expect-error
const isTurboModuleEnabled = global.__turboModuleProxy != null;

const TurboSensorsModule = isTurboModuleEnabled
  ? require('./NativeTurboSensors').default
  : NativeModules.TurboSensors;

export const TurboSensors = TurboSensorsModule
  ? TurboSensorsModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      },
    );
