import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlarmPage extends StatelessWidget {
  static const platform = MethodChannel('com.example.lab06');

  const AlarmPage({super.key});

  Future<void> _launchAlarmApp(String time) async {
    try {
      final String result = await platform.invokeMethod('launchAlarmApp', {'time': time});
      print(result);
    } on PlatformException catch (e) {
      print("Failed to launch alarm app: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Alarm'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            String alarmTime = "2024-10-07T08:15:00";
            _launchAlarmApp(alarmTime);
          },
          child: const Text('Set Alarm'),
        ),
      ),
    );
  }
}
