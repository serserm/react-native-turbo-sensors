import type { ListenerType } from './ListenerType';
import type { SensorName } from './SensorName';

export interface SensorParamsType {
  sensor: SensorName;
  onChange?: ListenerType;
}
