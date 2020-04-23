import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)        
        
        let nc = UINavigationController(rootViewController: UniverseViewController())        
        
        window!.rootViewController = nc
        window!.makeKeyAndVisible()
        return true
    }
}

