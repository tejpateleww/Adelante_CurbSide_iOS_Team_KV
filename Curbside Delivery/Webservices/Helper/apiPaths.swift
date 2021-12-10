//
//  apiPaths.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation
import Alamofire

typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())

enum APIEnvironment : String {
    
    case Development = "http://18.215.15.214/api/Delivery/"
    case ProfileBasrURL = "http://18.215.15.214/"
    case Live = "not provided"
    
    static var baseURL: String{
        return APIEnvironment.environment.rawValue
    }
    
    static var environment: APIEnvironment{
        return .Development
    }
    
    static var headers : [String:String]{
        if userDefaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {
            
            if userDefaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {
                
                if userDefaults.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                    do {
                        if UserDefaults.standard.value(forKey: UserDefaultsKey.X_API_KEY.rawValue) != nil, UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as? Bool ?? Bool(){
                            return ["key":"adelante123*#*","x-api-key":SingletonClass.sharedInstance.UserProfilData?.apiKey ?? ""]
                        }else{
                            return ["key":"adelante123*#*"]
                        }
                    }
                }
            }
        }
        return ["key":"adelante123*#*"]
    }
}

enum ApiKey: String {
    case Init                                     = "init/"
    case GoogleMapAPI                             = "https://maps.googleapis.com/maps/api/directions/json?"
    case login                                    = "login"
    case forgotPassword                           = "forgot_password"
    case orderList                                = "order_list"
    case qrCodeDetails                            = "qr_code_details"
    case orderDetails                             = "order_details"
    case notification                             = "notification"
    case profileEdit                              = "profile_edit"
    case orderDelivered                           = "order_delivered"
    case removeNotifiaction                       = "remove_notifiaction/"
    case editProfile                              = "profile/"
    
}


