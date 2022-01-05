//
//  NavigationItems.swift
//  Adelante
//
//  Created by Shraddha Parmar on 30/09/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import Foundation
import UIKit

enum NavItemsLeft {
    case none, back ,skip
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .back:
            return "back"
        case .skip:
            return "NavigationTitles_NavItemsLeft_skip".Localized()
        }
    }
}


enum NavItemsRight {
    case none, clearAll, saved, notifBell , liked, logout
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .clearAll:
            return "NavigationTitles_NavItemsRight_clearAll".Localized()
        case .saved:
            return "NavigationTitles_NavItemsRight_saved".Localized()
        case .notifBell:
            return "NavigationTitles_NavItemsRight_notifBell".Localized()
        case .liked:
            return "NavigationTitles_NavItemsRight_Liked".Localized()
        case .logout:
            return "Logout"
        }
    }
}

enum NavTitles {
    case none, orders, scanQR, notifications, CompleteOrderDetails, CanceledOrderDetails, OrderDetails, myProfile, editProfile, ForgotPassword
    
    var value:String {
        switch self {
        
        case .none:
            return ""
        case .orders:
            return "Orders"
        case .scanQR:
            return "Scan QR Code"
        case .myProfile:
            return "My Profile"
        case .editProfile:
            return "Edit Profile"
        case .notifications:
            return "Notifications"
        case .CompleteOrderDetails:
            return "Complete Order Details"
        case .CanceledOrderDetails:
            return "Canceled Order Details"
        case .OrderDetails:
            return "Order Details"
        case .ForgotPassword:
            return "Forgot Password"
            

        }
    }
}

enum MenuItems {
    
}
