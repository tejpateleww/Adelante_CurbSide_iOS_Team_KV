//
//  AppDelegate.swift
//  Curbside Delivery
//
//  Created by Tej P on 01/11/21.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import Firebase
import FirebaseMessaging
import FirebaseCore
import FirebaseCrashlytics
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {
    
    //MARK: - Properties
    static var current: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    var window:UIWindow?
    var offlineStatue : Bool = false
    var locationService = LocationService()
    weak var customTabBarController: CustomTabBarVC?
    static var pushNotificationObj : NotificationObjectModel?
    static var pushNotificationType : String?
    
    var visibleViewController: UIViewController? {
        guard let rootViewController = window?.rootViewController else {
            return nil
        }
        return UIApplication.getVisibleViewController(rootViewController)
    }
    
    //MARK: - Life cycle methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.checkConnction()
        self.setupKeyboardManager()
        FirebaseApp.configure()
        self.registerForPushNotifications()
        return true
    }
    
    //MARK: - Custom methods
    private func setupKeyboardManager(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .default
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
    }
    
    func navigateToLogin() {
        let controller = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: LoginViewController.storyboardID) as? LoginViewController
        let nav = UINavigationController(rootViewController: controller!)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = nav
    }
    
    func navigateToHome() {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CustomTabBarVC.storyboardID) as! CustomTabBarVC
        let nav = UINavigationController(rootViewController: controller)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = nav
    }
    
    func clearData(){
        // Reset UserDefaults
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        userDefault.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        SingletonClass.sharedInstance.clearSingletonClass()
        AppDelegate.current.navigateToLogin()
    }
    
    //MARK: - Network methods
    func checkConnction() {
        let manager = Alamofire.NetworkReachabilityManager()
        manager?.startListening { status in
            switch status {
            case .notReachable :
                print("not reachable")
                self.offlineStatue = true
                AppDelegate.current.showOfflineVC()
            case .reachable(.cellular) :
                print("cellular")
                if(self.offlineStatue){
                    self.offlineStatue = false
                    AppDelegate.current.hideOfflineVC()
                }
            case .reachable(.ethernetOrWiFi) :
                print("ethernetOrWiFi")
                if(self.offlineStatue){
                    self.offlineStatue = false
                    AppDelegate.current.hideOfflineVC()
                }
            default :
                print("unknown")
            }
        }
    }
    
    func showOfflineVC(){
        let topVC = UIApplication.appTopViewController()
        if (topVC?.isKind(of: OfflineVC.self) ?? false){
            return
        }else{
            let OfflineVC = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: OfflineVC.storyboardID) as! OfflineVC
            OfflineVC.modalPresentationStyle = .fullScreen
            topVC?.present(OfflineVC, animated: true, completion: nil)
        }
        
        
    }
    
    func hideOfflineVC(){
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: {
            let topVC = UIApplication.appTopViewController()
            if (topVC?.isKind(of: SplashVC.self) ?? false){
                NotificationCenter.default.post(name: .callInit, object: nil)
            }
        })
    }
    
}

extension UIApplication {
    class func appTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return appTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return appTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return appTopViewController(controller: presented)
        }
        return controller
    }
    
    class func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {

        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }

        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }

        if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.selectedViewController
        }

        return rootViewController
    }
}
