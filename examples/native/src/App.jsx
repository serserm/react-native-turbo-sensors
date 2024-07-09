import React, { useEffect } from 'react';
import { Button, StyleSheet, Text, View } from 'react-native';

import { SensorNameType, useSensor } from '@serserm/react-native-turbo-sensors';

export default function App() {
  const sensor = useSensor({
    onChanged: event => {
      console.log('list', event);
    },
  });

  useEffect(() => {
    sensor.isAvailable(SensorNameType.accelerometer).then(res => {
      console.log('isAvailable', res);
    });
  }, []);

  function onPress() {
    sensor.startSensor(SensorNameType.accelerometer);
  }

  return (
    <View style={styles.container}>
      <Text>Result</Text>
      <Button title={'Press'} onPress={onPress} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
