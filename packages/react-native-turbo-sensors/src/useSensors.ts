import { useEffect, useRef } from 'react';

import { Sensors } from './Sensors';
import type { SensorParamsType, UseSensorType } from './types';

export function useSensors(params: SensorParamsType): UseSensorType {
  const sensor = useRef<Sensors>(new Sensors());

  useEffect(() => {
    sensor.current.startListening(
      ({ type, name, errorCode, errorMessage, data, timestamp }) => {
        switch (type) {
          case 'onChanged':
            params.onChanged?.({ name, data, timestamp });
            break;
          case 'onError':
            params.onError?.({ name, errorCode, errorMessage });
            break;
        }
      },
    );

    return () => {
      sensor.current.stopListening();
    };
  }, []);

  return {
    isAvailable: sensor.current.isAvailable,
    setInterval: sensor.current.setInterval,
    startSensor: sensor.current.startSensor,
    stopSensor: sensor.current.stopSensor,
  };
}
