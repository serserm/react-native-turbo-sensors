import type { ListenerType } from './ListenerType';

export interface SensorParamsType {
  onError?: ListenerType;
  onChanged?: ListenerType;
}
