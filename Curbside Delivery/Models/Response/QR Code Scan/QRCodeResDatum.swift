//
//  QRCodeResDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 23, 2021

import Foundation

class QRCodeResDatum : Codable {
    
    let address : String?
    let createdAt : String?
    let discount : String?
    let discountAmount : String?
    let isRate : String?
    let item : [QRCodeResItem]?
    let itemQuantity : String?
    let orderId : String?
    let promocode : String?
    let promocodeId : String?
    let promocodeType : String?
    let qrcode : String?
    let restaurantId : String?
    let restaurantName : String?
    let serviceFee : String?
    let shareOrderId : String?
    let street : String?
    let subTotal : String?
    let tax : String?
    let total : String?
    let totalRound : String?
    let trash : String?
    let userId : String?
    let username : String?
    let carnumber : String?
    let parkingno : String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case createdAt = "created_at"
        case discount = "discount"
        case discountAmount = "discount_amount"
        case isRate = "is_rate"
        case item = "item"
        case itemQuantity = "item_quantity"
        case orderId = "order_id"
        case promocode = "promocode"
        case promocodeId = "promocode_id"
        case promocodeType = "promocode_type"
        case qrcode = "qrcode"
        case restaurantId = "restaurant_id"
        case restaurantName = "restaurant_name"
        case serviceFee = "service_fee"
        case shareOrderId = "share_order_id"
        case street = "street"
        case subTotal = "sub_total"
        case tax = "tax"
        case total = "total"
        case totalRound = "total_round"
        case trash = "trash"
        case userId = "user_id"
        case username = "username"
        case carnumber = "car_number"
        case parkingno = "parking_no"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        discountAmount = try values.decodeIfPresent(String.self, forKey: .discountAmount)
        isRate = try values.decodeIfPresent(String.self, forKey: .isRate)
        item = try values.decodeIfPresent([QRCodeResItem].self, forKey: .item)
        itemQuantity = try values.decodeIfPresent(String.self, forKey: .itemQuantity)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        promocode = try values.decodeIfPresent(String.self, forKey: .promocode)
        promocodeId = try values.decodeIfPresent(String.self, forKey: .promocodeId)
        promocodeType = try values.decodeIfPresent(String.self, forKey: .promocodeType)
        qrcode = try values.decodeIfPresent(String.self, forKey: .qrcode)
        restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
        restaurantName = try values.decodeIfPresent(String.self, forKey: .restaurantName)
        serviceFee = try values.decodeIfPresent(String.self, forKey: .serviceFee)
        shareOrderId = try values.decodeIfPresent(String.self, forKey: .shareOrderId)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        totalRound = try values.decodeIfPresent(String.self, forKey: .totalRound)
        trash = try values.decodeIfPresent(String.self, forKey: .trash)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        carnumber = try values.decodeIfPresent(String.self, forKey: .carnumber)
        parkingno = try values.decodeIfPresent(String.self, forKey: .parkingno)
    }
    
}
