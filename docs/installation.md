# Installation

React native app that uses npm, run:

```sh
npm install @serserm/react-native-turbo-sensors
```

React native app that uses yarn, run:

```sh
yarn add @serserm/react-native-turbo-sensors
```

Expo app run:

```sh
npx expo install @serserm/react-native-turbo-sensors
```

## Usage

>**default interval**: 200 ms

| SensorName    | Android | iOS |
|---------------|---------|-----|
| accelerometer | yes     | yes |
| gyroscope     | yes     | yes |
| magnetometer  | yes     | yes |
| gravity       | yes     | yes |
| rotation      | yes     | yes |
| acceleration  | yes     | yes |
| barometer     | yes     | yes |
| proximity     | yes     | no  |
| light         | yes     | no  |
| temperature   | yes     | no  |
| humidity      | yes     | no  |

```javascript
import { SensorName, useSensors } from '@serserm/react-native-turbo-sensors';

function App() {
  const {
    isAvailable,      // (name: SensorName) => Promise<boolean>
    setInterval,      // (name: SensorName, interval: number) => void
    startSensor,      // (name: SensorName) => void;
    stopSensor,       // (name: SensorName) => void;
  } = useSensors({
    onChanged,        // ({ name, data, timestamp }) => void;
    onError,          // ({ name, errorCode, errorMessage }) => void;
  });

  function onChanged({ name, data, timestamp }) {
    if (name === SensorName.accelerometer) {
      // TODO
    }
  }

  function onError({ name, errorCode, errorMessage }) {
    // TODO
  }

  function start() {
    isAvailable(SensorName.accelerometer).then(res => {
      if (res) {
        startSensor(SensorName.accelerometer);
      }
    });
  }

  function stop() {
    stopSensor(SensorName.accelerometer);
  }

  // ............
}
```
