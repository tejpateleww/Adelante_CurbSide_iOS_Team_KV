//
//  ProfileReqModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 24/11/21.
//

import Foundation

import Foundation

class UpdateProfileReqModel: Encodable{
    var deliveryId : String? = SingletonClass.sharedInstance.UserId
    var phone : String?
    var firstName : String?
    var lastName : String?
    var email : String?
    
    enum CodingKeys: String, CodingKey {
        case deliveryId = "delivery_id"
        case phone = "phone"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
    }
}
