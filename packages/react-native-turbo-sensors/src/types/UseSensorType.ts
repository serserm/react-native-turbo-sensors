import type { SensorNameType } from './SensorNameType';

export interface UseSensorType {
  isAvailable: (name: SensorNameType) => Promise<boolean>;
  setInterval: (name: SensorNameType, interval: number) => void;
  startSensor: (name: SensorNameType) => void;
  stopSensor: (name: SensorNameType) => void;
}
