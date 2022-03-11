//
//  NotificationResDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 24, 2021

import Foundation

class NotificationResDatum : Codable {
    
    let descriptionField : String?
    let id : String?
    let notificationTitle : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case id = "id"
        case notificationTitle = "notification_title"
        case image = "image"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        notificationTitle = try values.decodeIfPresent(String.self, forKey: .notificationTitle)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
