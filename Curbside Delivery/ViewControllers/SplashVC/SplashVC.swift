//
//  SplashVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 01/11/21.
//

import UIKit
import CoreLocation

class SplashVC: BaseViewController {
    
    //MARK: - Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.webserviceInit()
        }
    }
    
    //MARK: - custom methods
    func openForceUpdateAlert(msg: String){
        Utilities.showAlertWithTitleFromWindow(title: AppName, andMessage: msg, buttons: [StringConsts.Ok]) { (ind) in
            if ind == 0{
                if let url = URL(string: AppURL) {
                    UIApplication.shared.open(url)
                }
                self.openForceUpdateAlert(msg: msg)
            }
        }
    }
    
    func setRootViewController() {
        let isLogin = UserDefaults.standard.bool(forKey: UserDefaultsKey.isUserLogin.rawValue)
        if isLogin, let _ = userDefaults.getUserData() {
            AppDelegate.current.navigateToHome()
        }else{
            AppDelegate.current.navigateToLogin()
        }
    }
}

//MARK: - Apis
extension SplashVC{
    func webserviceInit(){
        WebServiceSubClass.InitApi { (status, message, response, error) in
            if let dic = error as? [String: Any], let msg = dic["message"] as? String, msg == StringConsts.NoInternetConnection || msg == StringConsts.SomethingWentWrong || msg == StringConsts.RequestTimeOut{
                Utilities.showAlertWithTitleFromVC(vc: self, title: AppName, message: msg, buttons: [StringConsts.Retry], isOkRed: false) { (ind) in
                    self.webserviceInit()
                }
                return
            }
            
            if status {
                SingletonClass.sharedInstance.AppInitModel = response
                if let responseDic = error as? [String:Any], let _ = responseDic["update"] as? Bool{
                    Utilities.showAlertWithTitleFromWindow(title: AppName, andMessage: message, buttons: [StringConsts.Ok,StringConsts.Cancel]) { (ind) in
                        if ind == 0{
                            if let url = URL(string: AppURL) {
                                UIApplication.shared.open(url)
                            }
                        }else {
                            self.setRootViewController()
                        }
                    }
                }else{
                    self.setRootViewController()
                }
            }else{
                if let responseDic = error as? [String:Any], let _ = responseDic["maintenance"] as? Bool{
                    Utilities.showAlertWithTitleFromWindow(title: AppName, andMessage: message, buttons: []) {_ in}
                }else{
                    if let responseDic = error as? [String:Any], let _ = responseDic["update"] as? Bool{
                        self.openForceUpdateAlert(msg: message)
                    }else{
                        Utilities.showAlertOfAPIResponse(param: error, vc: self)
                    }
                }
            }
            
            //Location Update
            let status = CLLocationManager.authorizationStatus()
            if(status == .authorizedAlways || status == .authorizedWhenInUse){
                AppDelegate.current.locationService.startUpdatingLocation()
            }
        }
    }
}
