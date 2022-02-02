
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
    
    case Nexaregular, Nexalight, Nexablack, NexablackItalic, Nexabold, NexaboldItalic, Nexabook, NexabookItalic, Nexalightitalic, Nexathin, NexathinItalic,
         regular, light, black, blackItalic, bold, boldItalic, lightitalic, semiBold , book , bookItalic, thin , thinItalic , semiBoldItalic
    func font(ofSize fontSize: CGFloat) -> UIFont {
        switch self{
        case .regular:
            return UIFont(name: "Nunito-Regular", size: fontSize)!
        case .light:
            return UIFont(name: "Nunito-Light", size: fontSize)!
        case .black:
            return UIFont(name: "Nunito-Black", size: fontSize)!
        case .blackItalic:
            return UIFont(name: "Nunito-BlackItalic", size: fontSize)!
        case .bold:
            return UIFont(name: "Nunito-Bold", size: fontSize)!
        case .boldItalic:
            return UIFont(name: "Nunito-BoldItalic", size: fontSize)!
        case .lightitalic:
            return UIFont(name: "Nunito-LightItalic", size: fontSize)!
        case .semiBold:
            return UIFont(name: "Nunito-SemiBold", size: fontSize)!
        case .semiBoldItalic:
              return UIFont(name: "Nunito-SemiBoldItalic", size: fontSize)!
        case .book:
            return UIFont(name: "Nexa-Book", size: fontSize)! //Not available in Nunito
        case .bookItalic:
            return UIFont(name: "Nexa-BookItalic", size: fontSize)!  //Not available in Nunito
        case .thin:
            return UIFont(name: "Nexa-Thin", size: fontSize)! //Not available in Nunito
        case .thinItalic:
            return UIFont(name: "Nexa-ThinItalic", size: fontSize)! //Not available in Nunito
            
            
            
        case .Nexaregular:
            return UIFont(name: "Nexa-Regular", size: fontSize)!
        case .Nexalight:
            return UIFont(name: "Nexa-Light", size: fontSize)!
        case .Nexablack:
            return UIFont(name: "Nexa-Black", size: fontSize)!
        case .NexablackItalic:
            return UIFont(name: "Nexa-BlackItalic", size: fontSize)!
        case .Nexabold:
            return UIFont(name: "Nexa-Black", size: fontSize)!
        case .NexaboldItalic:
            return UIFont(name: "Nexa-BlackItalic", size: fontSize)!
        case .Nexabook:
            return UIFont(name: "Nexa-Book", size: fontSize)!
        case .NexabookItalic:
            return UIFont(name: "Nexa-BookItalic", size: fontSize)!
        case .Nexalightitalic:
            return UIFont(name: "Nexa-LightItalic", size: fontSize)!
        case .Nexathin:
            return UIFont(name: "Nexa-Thin", size: fontSize)!
        case .NexathinItalic:
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

