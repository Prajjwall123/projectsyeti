import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeView extends StatefulWidget {
  const GyroscopeView({super.key});

  @override
  State<GyroscopeView> createState() => _GyroscopeViewState();
}

class _GyroscopeViewState extends State<GyroscopeView> {
  GyroscopeEvent? _gyroscopeEvent;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();

    _streamSubscriptions.add(
      gyroscopeEventStream().listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeEvent = event;
          });
        },
        onError: (e) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Sensor Not Found"),
                content: Text(
                    "It seems that your device doesn't support Gyroscope Sensor"),
              );
            },
          );
        },
        cancelOnError: true,
      ),
    );
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
          title: const Text('Gyroscope'),
        ),
        body: Center(
          child: Text(
            'X: ${_gyroscopeEvent?.x.toStringAsFixed(1)} , Y: ${_gyroscopeEvent?.y.toStringAsFixed(1)} , Z: ${_gyroscopeEvent?.z.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 24),
          ),
        ));
  }
}
