import { TurboSensors } from './TurboSensors';

export * from './types';
export { useSensor } from './useSensor';

export function multiply(a: number, b: number): Promise<number> {
  return TurboSensors.multiply(a, b);
}
