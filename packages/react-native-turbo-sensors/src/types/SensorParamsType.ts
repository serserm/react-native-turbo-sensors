import type { SensorListenerType } from './SensorListenerType';
import type { SensorName } from './SensorName';

export interface SensorParamsType {
  sensor: SensorName;
  onChange?: SensorListenerType;
}
