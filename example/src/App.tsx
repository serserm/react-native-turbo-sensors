import React, { useEffect } from 'react';
import { Button, StyleSheet, Text, View } from 'react-native';

import { SensorName, useSensor } from '@serserm/react-native-turbo-sensors';

export default function App() {
  const sensor = useSensor({
    sensor: SensorName.accelerometer,
    onChange: (event: object) => {
      console.log('list', event);
    },
  });

  useEffect(() => {
    sensor.isAvailable().then(res => {
      console.log('isAvailable', res);
    });
  }, []);

  function onPress() {
    console.log(sensor.value);
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
