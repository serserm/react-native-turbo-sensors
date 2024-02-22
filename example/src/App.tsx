import React, { useEffect } from 'react';
import { StyleSheet, Text, View } from 'react-native';

import { SensorTypes, useSensors } from '@serserm/react-native-turbo-sensors';

export default function App() {
  const sensor = useSensors({
    sensor: SensorTypes.accelerometer,
    onChange: event => {
      console.log('list', event);
    },
  });

  useEffect(() => {
    sensor.send();
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result</Text>
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
