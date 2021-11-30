//
//  EditUserResModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 30, 2021

import Foundation

class EditUserResModel : Codable {
    
    let message : String?
    let profile : EditUserResProfile?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case profile = "profile"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        profile = try values.decodeIfPresent(EditUserResProfile.self, forKey: .profile)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
