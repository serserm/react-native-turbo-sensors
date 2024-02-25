import { useEffect, useRef } from 'react';

import { Sensor } from './Sensor';
import type { SensorParamsType, SensorValueType, UseSensorType } from './types';

export function useSensor(params: SensorParamsType): UseSensorType {
  const sensor = useRef<Sensor>(new Sensor(params.sensor));
  const value = useRef<SensorValueType>(null);

  useEffect(() => {
    sensor.current.startListening((data: any) => {
      value.current = data?.value;
      params.onChange?.(data);
    });

    return () => {
      sensor.current.stopListening();
    };
  }, []);

  async function isAvailable(): Promise<boolean> {
    return sensor.current.isAvailable();
  }

  return {
    isAvailable,
    value: value.current,
  };
}
