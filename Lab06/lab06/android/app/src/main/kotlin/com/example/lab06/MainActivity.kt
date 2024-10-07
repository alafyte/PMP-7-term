package com.example.lab06

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.wifi.WifiManager
import android.os.BatteryManager
import android.provider.AlarmClock
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val _channel = "com.example.lab06"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, _channel).setMethodCallHandler { call, result ->
            if (call.method == "getWifiName") {
                val wifiName = getWifiName()
                if (wifiName != null) {
                    result.success(wifiName)
                } else {
                    result.error("UNAVAILABLE", "Wi-Fi Name not available.", null)
                }
            }
            else if (call.method == "launchAlarmApp") {
                val time: String = call.argument<String>(/* key = */ "time").toString();
                launchAlarmApp(time);
                result.success("Alarm app launched")
            }
            else if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getWifiName(): String? {
        val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        val wifiInfo = wifiManager.connectionInfo
        return wifiInfo.ssid
    }

    private fun launchAlarmApp(time: String) {
        try {
            val intent = Intent(AlarmClock.ACTION_SET_ALARM)
            intent.putExtra(AlarmClock.EXTRA_MESSAGE, "Alarm")
            intent.putExtra(
                AlarmClock.EXTRA_HOUR,
                time.split("T".toRegex()).dropLastWhile { it.isEmpty() }
                    .toTypedArray()[1].split(":".toRegex()).dropLastWhile { it.isEmpty() }
                    .toTypedArray()[0].toInt()
            )
            intent.putExtra(
                AlarmClock.EXTRA_MINUTES,
                time.split("T".toRegex()).dropLastWhile { it.isEmpty() }
                    .toTypedArray()[1].split(":".toRegex()).dropLastWhile { it.isEmpty() }
                    .toTypedArray()[1].toInt()
            )
            startActivity(intent)
        } catch (e: Exception) {
            Log.e("MainActivity", "Error launching alarm app: " + e.message)
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryStatus: Intent? = registerReceiver(null,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        )
        val batteryLevel = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val batteryScale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        return (batteryLevel / batteryScale.toFloat() * 100).toInt()
    }
}
