//
//  OrderListDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 23, 2021

import Foundation

class OrderListDatum : Codable {
    
    let address : String?
    let carNumber : String?
    let createdAt : String?
    let date : String?
    let id : String?
    let image : String?
    let lat : String?
    let lng : String?
    let parkingNo : String?
    let price : String?
    let restaurantId : String?
    let restaurantItemName : String?
    let restaurantName : String?
    let status : String?
    let street : String?
    let total : String?
    let username : String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case carNumber = "car_number"
        case createdAt = "created_at"
        case date = "date"
        case id = "id"
        case image = "image"
        case lat = "lat"
        case lng = "lng"
        case parkingNo = "parking_no"
        case price = "price"
        case restaurantId = "restaurant_id"
        case restaurantItemName = "restaurant_item_name"
        case restaurantName = "restaurant_name"
        case status = "status"
        case street = "street"
        case total = "total"
        case username = "username"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        carNumber = try values.decodeIfPresent(String.self, forKey: .carNumber)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        parkingNo = try values.decodeIfPresent(String.self, forKey: .parkingNo)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
        restaurantItemName = try values.decodeIfPresent(String.self, forKey: .restaurantItemName)
        restaurantName = try values.decodeIfPresent(String.self, forKey: .restaurantName)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        username = try values.decodeIfPresent(String.self, forKey: .username)
    }
    
}
