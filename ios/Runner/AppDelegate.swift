import UIKit
import Flutter
import Firebase
import FirebaseMessaging
import workmanager
import flutter_downloader

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure() // Add this line
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    GeneratedPluginRegistrant.register(with: self)

         WorkmanagerPlugin.setPluginRegistrantCallback { registry in
            GeneratedPluginRegistrant.register(with: registry)
        }
        FlutterDownloaderPlugin.setPluginRegistrantCallback { registry in
    if !registry.hasPlugin("FlutterDownloaderPlugin"),
       let registrar = registry.registrar(forPlugin: "FlutterDownloaderPlugin") {
        FlutterDownloaderPlugin.register(with: registrar)
    }
}
            WorkmanagerPlugin.registerTask(withIdentifier: "com.youscribe.youscribe.app.setupBackgroundActions")
            WorkmanagerPlugin.registerTask(withIdentifier: "com.youscribe.youscribe.app.unzip")
            WorkmanagerPlugin.registerTask(withIdentifier: "com.youscribe.youscribe.app.syncBookLists")
             UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}
    private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}
