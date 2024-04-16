import React, { useEffect } from 'react';
import { Button, StyleSheet, Text, View } from 'react-native';

import { SensorName, useSensor } from '@serserm/react-native-turbo-sensors';
import { StatusBar } from 'expo-status-bar';

export function App() {
  const sensor = useSensor({
    sensor: SensorName.accelerometer,
    onChange: event => {
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
      <StatusBar style="auto" />
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
