import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let nc = UINavigationController(rootViewController: PlaygroundViewController())
        nc.delegate = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = nc
        window!.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate: UINavigationControllerDelegate {
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return navigationController.topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
    }
}
