//
//  InitResponseModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 22, 2021

import Foundation

class InitResponseModel : Codable {
    
    let status : Bool?
    let walletBalance : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case walletBalance = "wallet_balance"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        walletBalance = try values.decodeIfPresent(String.self, forKey: .walletBalance)
    }
    
}
