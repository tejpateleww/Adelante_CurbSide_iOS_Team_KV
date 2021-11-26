//
//  NotificationReqModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 24/11/21.
//

import Foundation

import Foundation

class NotificationReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    
    enum CodingKeys: String, CodingKey {
        case driverId = "delivery_id"
    }
}
