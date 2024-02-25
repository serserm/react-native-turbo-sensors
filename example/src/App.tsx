import React, { useEffect } from 'react';
import { StyleSheet, Text, View } from 'react-native';

import { SensorName, useSensor } from '@serserm/react-native-turbo-sensors';

export default function App() {
  const sensor = useSensor({
    sensor: SensorName.rotation,
    // onChange: (event: object) => {
    //   console.log('list', event);
    // },
  });

  useEffect(() => {
    sensor.isAvailable().then(res => {
      console.log('isAvailable', res);
    });
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
