//
//  LoginReqModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 23/11/21.
//

import Foundation

class LoginRequestModel: Encodable{
    var userName : String?
    var password : String?
    var deviceType : String? = SingletonClass.sharedInstance.DeviceType
    var deviceToken : String? = SingletonClass.sharedInstance.DeviceToken
   
    
#if IOS_SIMULATOR
    var latitude : String? = "23.071775"
    var longitude : String? = "72.517008"
#else
    var latitude : String? = SingletonClass.sharedInstance.locationString().latitude
    var longitude : String? = SingletonClass.sharedInstance.locationString().longitude
#endif
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case password = "password"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case latitude = "lat"
        case longitude = "lng"
    }
}
