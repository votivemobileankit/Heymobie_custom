import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
      
    //  GMSServices.provideAPIKey("AIzaSyDk8csSnj22B4Wlbawa-bkME-XdM9ggYpo")
     
      GeneratedPluginRegistrant.register(with: self)
     GMSServices.provideAPIKey("AIzaSyBWC0ijkHRvZJLcqEkrJH677ZQ46vFFUTY")
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
}
