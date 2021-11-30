//
//  EditUserResProfile.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 30, 2021

import Foundation

class EditUserResProfile : Codable {
    
    let activationCode : String?
    let activationSelector : String?
    let active : String?
    let carNumber : String?
    let countryId : String?
    let createdOn : String?
    let deletedAt : String?
    let deviceToken : String?
    let deviceType : String?
    let email : String?
    let firstName : String?
    let forgottenPasswordCode : String?
    let forgottenPasswordSelector : String?
    let forgottenPasswordTime : String?
    let fullName : String?
    let id : String?
    let ipAddress : String?
    let lastLogin : String?
    let lastName : String?
    let lat : String?
    let lng : String?
    let otpCode : String?
    let otpTime : String?
    let password : String?
    let phone : String?
    let profilePicture : String?
    let rememberCode : String?
    let rememberSelector : String?
    let rememberToken : String?
    let trash : String?
    let username : String?
    
    enum CodingKeys: String, CodingKey {
        case activationCode = "activation_code"
        case activationSelector = "activation_selector"
        case active = "active"
        case carNumber = "car_number"
        case countryId = "country_id"
        case createdOn = "created_on"
        case deletedAt = "deleted_at"
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case email = "email"
        case firstName = "first_name"
        case forgottenPasswordCode = "forgotten_password_code"
        case forgottenPasswordSelector = "forgotten_password_selector"
        case forgottenPasswordTime = "forgotten_password_time"
        case fullName = "full_name"
        case id = "id"
        case ipAddress = "ip_address"
        case lastLogin = "last_login"
        case lastName = "last_name"
        case lat = "lat"
        case lng = "lng"
        case otpCode = "otp_code"
        case otpTime = "otp_time"
        case password = "password"
        case phone = "phone"
        case profilePicture = "profile_picture"
        case rememberCode = "remember_code"
        case rememberSelector = "remember_selector"
        case rememberToken = "remember_token"
        case trash = "trash"
        case username = "username"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        activationCode = try values.decodeIfPresent(String.self, forKey: .activationCode)
        activationSelector = try values.decodeIfPresent(String.self, forKey: .activationSelector)
        active = try values.decodeIfPresent(String.self, forKey: .active)
        carNumber = try values.decodeIfPresent(String.self, forKey: .carNumber)
        countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
        createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        forgottenPasswordCode = try values.decodeIfPresent(String.self, forKey: .forgottenPasswordCode)
        forgottenPasswordSelector = try values.decodeIfPresent(String.self, forKey: .forgottenPasswordSelector)
        forgottenPasswordTime = try values.decodeIfPresent(String.self, forKey: .forgottenPasswordTime)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        ipAddress = try values.decodeIfPresent(String.self, forKey: .ipAddress)
        lastLogin = try values.decodeIfPresent(String.self, forKey: .lastLogin)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        otpCode = try values.decodeIfPresent(String.self, forKey: .otpCode)
        otpTime = try values.decodeIfPresent(String.self, forKey: .otpTime)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        profilePicture = try values.decodeIfPresent(String.self, forKey: .profilePicture)
        rememberCode = try values.decodeIfPresent(String.self, forKey: .rememberCode)
        rememberSelector = try values.decodeIfPresent(String.self, forKey: .rememberSelector)
        rememberToken = try values.decodeIfPresent(String.self, forKey: .rememberToken)
        trash = try values.decodeIfPresent(String.self, forKey: .trash)
        username = try values.decodeIfPresent(String.self, forKey: .username)
    }
    
}
