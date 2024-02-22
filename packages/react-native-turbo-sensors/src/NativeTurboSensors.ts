import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  addListener(eventName: string): void;

  removeListeners(count: number): void;

  send(sensor: string): void;

  state(sensor: string): Promise<object>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('TurboSensors');
