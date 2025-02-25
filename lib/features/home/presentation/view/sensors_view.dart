import 'package:flutter/material.dart';
import 'package:projectsyeti/features/home/presentation/view/accelerometer_view.dart';
import 'package:projectsyeti/features/home/presentation/view/barometer_view.dart';
import 'package:projectsyeti/features/home/presentation/view/gyroscope_view.dart';
import 'package:projectsyeti/features/home/presentation/view/magnetometer_view.dart';
import 'package:projectsyeti/features/home/presentation/view/proximity_view.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class SensorsView extends StatelessWidget {
  const SensorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.amber),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccelerometerView()));
            },
            child: const Text('Accelerometer', style: TextStyle(fontSize: 24)),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.amber),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GyroscopeView()));
            },
            child: const Text('Gyroscope', style: TextStyle(fontSize: 24)),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.amber),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MagnetometerView()));
            },
            child: const Text('Magnetometer', style: TextStyle(fontSize: 24)),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.amber),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BarometerView()));
            },
            child: const Text('Barometer', style: TextStyle(fontSize: 24)),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.amber),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProximityView()));
            },
            child:
                const Text('Proximity Sensor', style: TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );
  }
}
