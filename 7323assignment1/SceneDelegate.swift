import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        
        if let windowScene = (scene as? UIWindowScene) {
                self.window = UIWindow(windowScene: windowScene)
                
                // To load dark mode setting from UserDefaults
                let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
                window?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                
                // To auto load original view controller from Storyboard
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = mainStoryboard.instantiateInitialViewController()
                window?.rootViewController = initialViewController // To set up original view controller to root view controller in Storyboard
                
                // To display window
                window?.makeKeyAndVisible()
            }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Now called as the scene is being released by the system.
        // It occurs shortly after the scene enters the background, or when its session is discarded.
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // It is called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // It is called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // It is called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // It is called as the scene transitions from the foreground to the background.
    }


}

