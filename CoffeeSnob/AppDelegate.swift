import UIKit
import TomTomSDKMapDisplay

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set your API key here
        MapsDisplayService.apiKey = "pI4kmVlG64hsmsxz9fLKoMtXOmLVgaJW"
        return true
    }
}
