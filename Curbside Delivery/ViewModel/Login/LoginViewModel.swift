//
//  LoginViewModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 23/11/21.
//

import Foundation
import UIKit

class LoginUserModel{
    weak var loginVC : LoginViewController? = nil
    
    func webserviceLogin(reqModel: LoginRequestModel){
        Utilities.showHud()
        WebServiceSubClass.LoginApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                
                userDefaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                userDefaults.setValue(response?.data?.apiKey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                
                SingletonClass.sharedInstance.UserProfilData = response?.data
                userDefaults.setUserData()
                
                if let apikey = response?.data?.apiKey{
                    SingletonClass.sharedInstance.Api_Key = apikey
                    //SingletonClass.sharedInstance.UserProfilData?.apiKey = apikey
                    userDefaults.setValue(apikey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                }
                
                if let userID = response?.data?.id{
                    SingletonClass.sharedInstance.UserId = userID
                }
                AppDelegate.current.navigateToHome()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Toast.show(title: StringConsts.Success, message: apiMessage, state: .success)
                }
            }else{
                Toast.show(title: StringConsts.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
