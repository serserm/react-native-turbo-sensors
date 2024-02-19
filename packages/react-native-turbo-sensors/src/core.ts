import { TurboSensors } from './TurboSensors';

export function multiply(a: number, b: number): Promise<number> {
  return TurboSensors.multiply(a, b);
}
