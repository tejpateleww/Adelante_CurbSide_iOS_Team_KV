//
//  Colors.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import Foundation
import UIKit

enum colors{
    case white, black, red, appOrangeColor, appGreenColor, appRedColor, badgeColor, segmentSelectedColor, segmentDeselectedColor, searchBarBg, submitButtonShadow, textFieldColor, myLocTitleHome, myLocValueHome, selectedFilterBtn, normalFilterBtn, clearCol, forgotpassGreyColor, seperatorColor, darkSeperatorColor,lightOrange
    
    var value:UIColor{
        switch self {
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .red:
            return UIColor.red
        case .appOrangeColor:
            return UIColor(hexString: "#E34A25")
        case .appGreenColor:
            return UIColor(hexString: "#209413")
        case .badgeColor:
            return UIColor(hexString: "#DFB23C")
        case .segmentSelectedColor:
            return UIColor(hexString: "#D3D8DF")
        case .segmentDeselectedColor:
            return UIColor(hexString: "#F3F5F9")
        case .searchBarBg:
            return UIColor(hexString: "#CFD5E5")
        case .submitButtonShadow:
            return UIColor(hexString: "#3E1F43")
        case .textFieldColor:
            return UIColor(hexString: "#9597A8")
        case .myLocTitleHome:
            return UIColor(hexString: "#697782")
        case .myLocValueHome:
            return UIColor(hexString: "#353535")
        case .selectedFilterBtn:
            return UIColor(hexString: "#D3D8DF")
        case .normalFilterBtn:
            return UIColor(hexString: "#F3F5F9")
        case .clearCol:
            return UIColor.clear
        case .forgotpassGreyColor:
            return UIColor(hexString: "#9597A8")
        case .seperatorColor:
            return UIColor(hexString: "#707070").withAlphaComponent(0.08)
        case .appRedColor:
            return UIColor(hexString:"#FF172F")
        case .darkSeperatorColor:
            return colors.black.value
        case .lightOrange:
            return UIColor(hexString: "ffaf7a")
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
           let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
           var int = UInt64()
           Scanner(string: hex).scanHexInt64(&int)
           let a, r, g, b: UInt64
           switch hex.count {
           case 3: // RGB (12-bit)
               (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
           case 6: // RGB (24-bit)
               (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
           case 8: // ARGB (32-bit)
               (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
           default:
               (a, r, g, b) = (255, 0, 0, 0)
           }
           self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
       }
}

enum OrderType : String {
    case upcoming = "upcoming"
    case complete = "complete"
}
