//
//  Extension+NSMutableAttributedString.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 01/04/21.
//

import Foundation
import UIKit

//extension NSMutableAttributedString {
// var fontSize:CGFloat { return 18 }
////    var boldFont:UIFont { return UIFont(name: FontBook.semibold.rawValue, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
//    var normalFont:UIFont { return UIFont(name: "ZonaPro-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
//    
//    func bold(_ value:String , fontSize : CGFloat,  fontColor : UIColor = .white) -> NSMutableAttributedString {
//        
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font : FontBook.semibold.font(ofSize: fontSize) ,//boldFont,
//            .foregroundColor : fontColor
//        ]
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//    
//    func normal(_ value:String, fontSize : CGFloat , fontColor : UIColor = .white) -> NSMutableAttributedString {
//        
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font : FontBook.regular.font(ofSize: fontSize),//normalFont,
//            .foregroundColor : fontColor
//        ]
//        
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
//        
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font :  normalFont,
//            .foregroundColor : UIColor.white,
//            .backgroundColor : UIColor.orange
//        ]
//        
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//    
//    func blackHighlight(_ value:String) -> NSMutableAttributedString {
//        
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font :  normalFont,
//            .foregroundColor : UIColor.white,
//            .backgroundColor : UIColor.black
//            
//        ]
//        
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//    
//    func underlined(_ value:String) -> NSMutableAttributedString {
//        
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font :  normalFont,
//            .underlineStyle : NSUnderlineStyle.single.rawValue
//            
//        ]
//        
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//}
