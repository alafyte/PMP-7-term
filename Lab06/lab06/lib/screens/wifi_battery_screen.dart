import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class BatteryInfo {
  static const MethodChannel _batteryChannel =
      MethodChannel('com.example.lab06');

  static Future<int> getBatteryLevel() async {
    final int batteryLevel =
        await _batteryChannel.invokeMethod('getBatteryLevel');
    return batteryLevel;
  }
}

class WifiBatteryInfoScreen extends StatefulWidget {
  const WifiBatteryInfoScreen({super.key});

  @override
  WifiBatteryInfoScreenState createState() => WifiBatteryInfoScreenState();
}

class WifiBatteryInfoScreenState extends State<WifiBatteryInfoScreen> {
  static const platform = MethodChannel('com.example.lab06');
  String _wifiName = 'Unknown';
  int _batteryLevel = 0;

  Future<void> _getWifiName() async {
    if (await Permission.location.request().isGranted) {
      String wifiName;
      try {
        wifiName = await platform.invokeMethod('getWifiName');
      } on PlatformException catch (e) {
        wifiName = 'Failed to get Wi-Fi Name: ${e.message}';
      }

      setState(() {
        _wifiName = wifiName;
      });
    } else {
      setState(() {
        _wifiName = 'Permission denied';
      });
    }
  }

  Future<void> _getBatteryLevel() async {
    final int batteryLevel = await BatteryInfo.getBatteryLevel();
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    super.initState();
    _getWifiName();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-Fi Info'),
      ),
      body: Center(
        child: Text(
            'Connected Wi-Fi: $_wifiName, \nBattery level: $_batteryLevel%'),
      ),
    );
  }
}
