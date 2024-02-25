import type { SensorValueType } from './SensorValueType';

export interface UseSensorType {
  isAvailable: () => Promise<boolean>;
  value: SensorValueType;
}
