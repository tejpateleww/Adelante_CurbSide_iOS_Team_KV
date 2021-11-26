//
//  QRCodeResItem.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 23, 2021

import Foundation

class QRCodeResItem : Codable {

        let createdAt : String?
        let date : String?
        let id : String?
        let image : String?
        let mainOrderId : String?
        let price : String?
        let quantity : String?
        let restaurantItemName : String?
        let subTotal : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "created_at"
                case date = "date"
                case id = "id"
                case image = "image"
                case mainOrderId = "main_order_id"
                case price = "price"
                case quantity = "quantity"
                case restaurantItemName = "restaurant_item_name"
                case subTotal = "sub_total"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                mainOrderId = try values.decodeIfPresent(String.self, forKey: .mainOrderId)
                price = try values.decodeIfPresent(String.self, forKey: .price)
                quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
                restaurantItemName = try values.decodeIfPresent(String.self, forKey: .restaurantItemName)
                subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
        }

}
