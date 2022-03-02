//
//  QRCodeResModel.swift
//  Curbside Delivery
//
//  Created by Tej P on 23/11/21.
//

import Foundation

class QRCodeReqModel: Encodable{
    var qrCode : String?
    var orderId : String?
    
    enum CodingKeys: String, CodingKey {
        case qrCode = "qr_code"
        case orderId = "order_id"
    }
}

class ForgotPassReqModel: Encodable{
    var email : String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}

class OrderDeliveryReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var orderId : String?
    var userId : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "delivery_id"
        case orderId = "order_id"
        case userId = "user_id"
    }
}
