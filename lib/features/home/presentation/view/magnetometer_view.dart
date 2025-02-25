import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerView extends StatefulWidget {
  const MagnetometerView({super.key});

  @override
  State<MagnetometerView> createState() => _MagnetometerViewState();
}

class _MagnetometerViewState extends State<MagnetometerView> {
  MagnetometerEvent? _magnetometerEvent;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    _streamSubscriptions.add(
      magnetometerEventStream().listen(
        (MagnetometerEvent event) {
          setState(() {
            _magnetometerEvent = event;
          });
        },
        onError: (e) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Sensor Not Found"),
                content: Text(
                    "It seems that your device doesn't support Magnetometer Sensor"),
              );
            },
          );
        },
        cancelOnError: true,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnetometer'),
      ),
      body: Center(
        child: Text(
            'X: ${_magnetometerEvent?.x.toStringAsFixed(1)} , Y: ${_magnetometerEvent?.y.toStringAsFixed(1)} , Z: ${_magnetometerEvent?.z.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
