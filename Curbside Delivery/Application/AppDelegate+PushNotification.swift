
import Foundation
import IQKeyboardManagerSwift
import Firebase
import UserNotifications

extension AppDelegate{
    
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_ , _ in })
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let token = fcmToken ?? "No Token found"
        print("Firebase registration token: \(fcmToken ?? "No Token found")")
        SingletonClass.sharedInstance.DeviceToken = token
        userDefaults.set(fcmToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
        
        let dataDict:[String: String] = ["token": token]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = token {
                print("Remote instance ID token: \(result)")
                UserDefaults.standard.set(SingletonClass.sharedInstance.DeviceToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("fcmToken : \(fcmToken)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(#function, notification)
        let content = notification.request.content
        let userInfo = notification.request.content.userInfo
        
        NotificationCenter.default.post(name: NotificationBadges, object: content)
        completionHandler([.alert, .sound])
        
        if let mainDic = userInfo as? [String: Any]{
            
            let pushObj = NotificationObjectModel()
            if let order_id = mainDic["gcm.notification.order_id"]{
                pushObj.orderId = order_id as? String ?? ""
            }
            if let type = mainDic["gcm.notification.type"]{
                pushObj.type = type as? String ?? ""
            }
            if let title = mainDic["title"]{
                pushObj.title = title as? String ?? ""
            }
            if let text = mainDic["text"]{
                pushObj.text = text as? String ?? ""
            }
            
            AppDelegate.pushNotificationObj = pushObj
            AppDelegate.pushNotificationType = pushObj.type
            
            if pushObj.type == NotificationTypes.notifLoggedOut.rawValue {
                AppDelegate.current.clearData()
                return
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("USER INFo : ",userInfo)

        
        if let mainDic = userInfo as? [String: Any]{
            
            let pushObj = NotificationObjectModel()
            if let order_id = mainDic["gcm.notification.order_id"]{
                pushObj.orderId = order_id as? String ?? ""
            }
            if let type = mainDic["gcm.notification.type"]{
                pushObj.type = type as? String ?? ""
            }
            if let title = mainDic["title"]{
                pushObj.title = title as? String ?? ""
            }
            if let text = mainDic["text"]{
                pushObj.text = text as? String ?? ""
            }
            
            AppDelegate.pushNotificationObj = pushObj
            AppDelegate.pushNotificationType = pushObj.type
            
            if pushObj.type == NotificationTypes.notifLoggedOut.rawValue {
                AppDelegate.current.clearData()
                completionHandler()
                return
            }
            
            if pushObj.type == NotificationTypes.orderPrepare.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let vc = AppDelegate.current.visibleViewController as? CustomTabBarVC
                    if(vc?.selectedIndex ?? 0 == 0){
                        NotificationCenter.default.post(name: .orderPrepare, object: nil)
                    }else{
                        NotificationCenter.default.post(name: .orderPrepare, object: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            vc?.selectedIndex = 0
                        }
                    }
                }
                completionHandler()
                return
            }
        }
    }
}

extension Notification.Name {
    static let sessionExpire = NSNotification.Name("sessionExpire")
    static let callInit = NSNotification.Name("callInit")
    static let orderPrepare = NSNotification.Name("orderPrepare")
    static let ProfileBackAction = NSNotification.Name("ProfileBackAction")
}

enum NotificationTypes : String {
    case notifLoggedOut = "sessionTimeout"
    case orderPrepare = "orderprepare"
}

class NotificationObjectModel: Codable {
    var orderId: String?
    var type: String?
    var title: String?
    var text: String?
}
