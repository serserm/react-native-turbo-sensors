import type { SensorName } from './SensorName';

export interface UseSensorType {
  isAvailable: (name: SensorName) => Promise<boolean>;
  setInterval: (name: SensorName, interval: number) => void;
  startSensor: (name: SensorName) => void;
  stopSensor: (name: SensorName) => void;
}
