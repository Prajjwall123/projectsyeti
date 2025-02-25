import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class ProximityView extends StatefulWidget {
  const ProximityView({super.key});

  @override
  State<ProximityView> createState() => _ProximityViewState();
}

class _ProximityViewState extends State<ProximityView> {
  bool _isNear = false;
  StreamSubscription<int>? _proximitySubscription;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _proximitySubscription = ProximitySensor.events.listen(
      (int event) {
        setState(() {
          _isNear = event == 1;
        });
      },
      onError: (e) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Sensor Not Found"),
              content: Text(
                  "It seems that your device doesn't support the Proximity Sensor."),
            );
          },
        );
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _proximitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proximity Sensor'),
      ),
      body: Center(
        child: Text(
          _isNear ? "Object Detected 🔴" : "No Object Nearby 🟢",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
