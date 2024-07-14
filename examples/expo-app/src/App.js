import React, { Fragment, useEffect, useRef, useState } from 'react';
import {
  ScrollView,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';

import { SensorName, useSensors } from '@serserm/react-native-turbo-sensors';

export default function App() {
  const [isAvailable, setIsAvailable] = useState({});
  const sensorName = useRef('');
  const [sensorData, setSensorData] = useState({});
  const sensors = useSensors({
    onChanged,
  });

  useEffect(() => {
    Promise.all([
      sensors.isAvailable(SensorName.accelerometer),
      sensors.isAvailable(SensorName.gyroscope),
      sensors.isAvailable(SensorName.magnetometer),
      sensors.isAvailable(SensorName.gravity),
      sensors.isAvailable(SensorName.rotation),
      sensors.isAvailable(SensorName.acceleration),
      sensors.isAvailable(SensorName.barometer),
      sensors.isAvailable(SensorName.proximity),
      sensors.isAvailable(SensorName.light),
      sensors.isAvailable(SensorName.temperature),
      sensors.isAvailable(SensorName.humidity),
    ]).then(res => {
      setIsAvailable({
        [SensorName.accelerometer]: res[0],
        [SensorName.gyroscope]: res[1],
        [SensorName.magnetometer]: res[2],
        [SensorName.gravity]: res[3],
        [SensorName.rotation]: res[4],
        [SensorName.acceleration]: res[5],
        [SensorName.barometer]: res[6],
        [SensorName.proximity]: res[7],
        [SensorName.light]: res[8],
        [SensorName.temperature]: res[9],
        [SensorName.humidity]: res[10],
      });
    });
  }, []);

  function onChanged(event) {
    if (event.name === sensorName.current) {
      console.log(event);
      setSensorData(event.data);
    }
  }

  function onPress(name) {
    return () => {
      sensorName.current = name;
      sensors.startSensor(name);
    };
  }

  return (
    <ScrollView contentContainerStyle={styles.scroll}>
      <View style={styles.container}>
        <Text>isAvailable</Text>
        <View style={styles.column}>
          {Object.entries(isAvailable).map(([key, value]) => (
            <Fragment key={key}>
              <View style={styles.row}>
                <View style={styles.item}>
                  <Text>{`${key}`}</Text>
                </View>
                <View style={styles.item}>
                  <Text>{`${value}`}</Text>
                </View>
                <View style={styles.item}>
                  <TouchableOpacity
                    style={[styles.button, !value && styles.disable]}
                    title={'Start'}
                    onPress={onPress(key)}
                    disabled={!value}>
                    <Text>Start</Text>
                  </TouchableOpacity>
                </View>
              </View>
            </Fragment>
          ))}
        </View>
        <Text>Result</Text>
        <View style={styles.row}>
          <Text>{JSON.stringify(sensorData)}</Text>
        </View>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  scroll: {
    flexGrow: 1,
  },
  container: {
    flex: 1,
    paddingVertical: 75,
    alignItems: 'center',
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 5,
  },
  column: {
    alignItems: 'flex-end',
  },
  item: {
    minHeight: 25,
    paddingHorizontal: 5,
  },
  button: {
    minHeight: 25,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 5,
    borderWidth: 1,
    borderRadius: 8,
    borderColor: '#00f',
  },
  disable: {
    backgroundColor: '#c7c7c7',
  },
});
