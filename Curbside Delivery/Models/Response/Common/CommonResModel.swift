//
//  CommonResModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 25, 2021

import Foundation

class CommonResModel : Codable {
    
    let message : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
