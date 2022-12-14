//
//  Constants.swift
//  Curbside Delivery
//
//  Created by Tej P on 18/11/21.
//

import Foundation
import Alamofire

let AppName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Curbside Pickup"
let AppURL = "https://apps.apple.com/us/app/virtuwoof/id1488928328"
let kAPPVesion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

var userDefault = UserDefaults.standard
let userDefaults = UserDefaults.standard
let CurrencySymbol = "$"
let DummyDataForShimmer = "Dummy Data.."

let SessionExpiredResponseDic = [StringConsts.ResponseMessage: StringConsts.SessionExpired]
let SomethingWentWrongResponseDic = [StringConsts.ResponseMessage: StringConsts.SomethingWentWrong]
let NoInternetResponseDic = [StringConsts.ResponseMessage: StringConsts.NoInternetConnection]

let NotificationBadges = NSNotification.Name(rawValue: "NotificationBadges")

enum UserDefaultsKey : String {
    case userProfile = "userProfile"
    case isUserLogin = "isUserLogin"
    case X_API_KEY   = "X_API_KEY"
    case DeviceToken = "DeviceToken"
    case selLanguage = "language"
    case PlaceName = "PlaceName"
}

struct ScreenSize {

    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    
    
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_SE         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_7          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_7PLUS      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

let TEXTFIELD_MaximumLimit = 70 //25
let TEXTFIELD_PASSWORD_MaximumLimit = 15 //25
let TEXTFIELD_MinimumLimit = 2
let MAX_PHONE_DIGITS = 10
let MAX_PHONE_DIGITS_PROFILE = 13
let MAX_QUANTITY_DIGITS = 8
