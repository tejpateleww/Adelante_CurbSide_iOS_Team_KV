
import Foundation
import UIKit

enum FontSize : CGFloat {
    
    case size8 = 8.0
    case size10 = 10.0
    case size12 = 12.0
    case size13 = 13.0
    case size14 = 14.0
    case size15 = 15.0
    case size16 = 16.0
    case size17 = 17.0
    case size18 = 18.0
    case size19 = 19.0
    case size20 = 20.0
    case size22 = 22.0
    case size24 = 24.0
}

enum FontBook {
    
    case regular, light, black, blackItalic, bold, boldItalic, book, bookItalic, lightitalic, thin, thinItalic
    func font(ofSize fontSize: CGFloat) -> UIFont {
        switch self{
        case .regular:
            return UIFont(name: "Nexa-Regular", size: fontSize)!
        case .light:
            return UIFont(name: "Nexa-Light", size: fontSize)!
        case .black:
            return UIFont(name: "Nexa-Black", size: fontSize)!
        case .blackItalic:
            return UIFont(name: "Nexa-BlackItalic", size: fontSize)!
        case .bold:
            return UIFont(name: "Nexa-Black", size: fontSize)!
        case .boldItalic:
            return UIFont(name: "Nexa-BlackItalic", size: fontSize)!
        case .book:
            return UIFont(name: "Nexa-Book", size: fontSize)!
        case .bookItalic:
            return UIFont(name: "Nexa-BookItalic", size: fontSize)!
        case .lightitalic:
            return UIFont(name: "Nexa-LightItalic", size: fontSize)!
        case .thin:
            return UIFont(name: "Nexa-Thin", size: fontSize)!
        case .thinItalic:
            return UIFont(name: "Nexa-ThinItalic", size: fontSize)!
        }
    }
}

extension UIFont {

    static var themeNavigationTitle: UIFont {
        FontBook.bold.font(ofSize: 26)
    }

    static var themeGradientButtonTitle: UIFont {
        FontBook.bold.font(ofSize: 18)
    }

}
enum FontWeight : Int{
    case regular = 0, light, black, blackItalic, bold, boldItalic, book, bookItalic, heavy, heavyItalic, lightitalic, regularItalic, thin, thinItalic, extraBold, extraBoldItalic
}

