//
//  OrderListReqModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 23/11/21.
//

import Foundation

class OrderListReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var type : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "delivery_id"
        case type = "type"
    }
}

class OrderDetailReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var orderId : String?
    var type : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "delivery_id"
        case orderId = "order_id"
        case type = "type"
    }
}
