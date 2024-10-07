import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "com.example.lab06",
                                                    binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler { (call, result) in
            if call.method == "getBatteryLevel" {
                self.getBatteryLevel(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        return true
    }

    private func getBatteryLevel(result: @escaping FlutterResult) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = UIDevice.current.batteryLevel
        result(Int(batteryLevel * 100))
    }
}
