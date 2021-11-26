//
//  Themes.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 15/03/21.

import UIKit

class ThemeLabel: UILabel {

    @IBInspectable public var Font_Size: CGFloat = FontSize.size15.rawValue
    @IBInspectable public var fontColor: UIColor = .white
    @IBInspectable public var lightGrayStyle: Bool = false
    @IBInspectable public var titleBlackStyle: Bool = false
    @IBInspectable public var instructionStyle: Bool = false
    @IBInspectable public var boldMediumStyle: Bool = false
    @IBInspectable public var lightMediumStyle: Bool = false
    @IBInspectable public var lightMediumBlackStyle: Bool = false
    @IBInspectable public var lightPrimaryStyle: Bool = false
    @IBInspectable public var extraSmallBoldStyle: Bool = false
    @IBInspectable public var sixteenBoldStyle: Bool = false
    @IBInspectable public var thirteenBlueStyle: Bool = false
    @IBInspectable public var thirteenGrayStyle: Bool = false
    @IBInspectable public var thirteenDarkGrayStyle: Bool = false

    @IBInspectable public var regular: Bool = false
    @IBInspectable public var extraLight: Bool = false
    @IBInspectable public var semiBold: Bool = false
    @IBInspectable public var bold: Bool = false

    @IBInspectable public var blueColor: Bool = false

    var fonttype : FontWeight = .regular

    @IBInspectable public var FontWeight: Int {
        get {
            return self.fonttype.rawValue
        }
        set(weightIndex) {
            self.fonttype = Curbside_Delivery.FontWeight(rawValue: weightIndex) ?? .regular
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }

    init(fontWeight: FontWeight, fontSize: CGFloat, color: UIColor) {
        self.fonttype = fontWeight
        self.Font_Size = fontSize
        self.fontColor = color
        super.init(frame: .zero)
        setViews()
    }

    func setViews() {
        switch fonttype {
        case .regular:
            self.font = FontBook.regular.font(ofSize: Font_Size)
        case .light:
            self.font = FontBook.light.font(ofSize: Font_Size)
        case .black:
            self.font = FontBook.black.font(ofSize: Font_Size)
        case .blackItalic:
            self.font = FontBook.blackItalic.font(ofSize: Font_Size)
        case .bold:
            self.font = FontBook.bold.font(ofSize: Font_Size)
        case .boldItalic:
            self.font = FontBook.boldItalic.font(ofSize: Font_Size)
        case .book:
            self.font = FontBook.book.font(ofSize: Font_Size)
        case .bookItalic:
            self.font = FontBook.bookItalic.font(ofSize: Font_Size)
        case .heavy:
            self.font = FontBook.bold.font(ofSize: Font_Size)
        case .heavyItalic:
            self.font = FontBook.boldItalic.font(ofSize: Font_Size)
        case .lightitalic:
            self.font = FontBook.lightitalic.font(ofSize: Font_Size)
        case .regularItalic:
            self.font = FontBook.regular.font(ofSize: Font_Size)
        case .thin:
            self.font = FontBook.thin.font(ofSize: Font_Size)
        case .thinItalic:
            self.font = FontBook.thinItalic.font(ofSize: Font_Size)
        case .extraBold:
            self.font = FontBook.bold.font(ofSize: Font_Size)
        case .extraBoldItalic:
            self.font = FontBook.boldItalic.font(ofSize: Font_Size)
        }

        if lightGrayStyle {
            textColor = UIColor.themeGrayLabel
            font = FontBook.light.font(ofSize: 13)
        } else if titleBlackStyle {
            textColor = .black
            font = FontBook.bold.font(ofSize: 26)
        } else if instructionStyle {
            textColor = .themeDarkGrayLabel
            font = FontBook.light.font(ofSize: 19)
        } else if boldMediumStyle {
            textColor = .black
            font = FontBook.bold.font(ofSize: 15)
        } else if lightPrimaryStyle {
            textColor = .themePrimary
            font = FontBook.light.font(ofSize: 15)
        } else if lightMediumStyle {
            textColor = .themeMediumGrayLabel
            font = FontBook.light.font(ofSize: 15)
        } else if lightMediumBlackStyle {
            textColor = .black
            font = FontBook.light.font(ofSize: 15)
        } else if extraSmallBoldStyle {
            textColor = .white
            font = FontBook.bold.font(ofSize: 8)
        } else if sixteenBoldStyle {
            textColor = .black
            font = FontBook.bold.font(ofSize: 16)
        } else if thirteenBlueStyle {
            textColor = .themePrimary
            font = FontBook.light.font(ofSize: 13)
        } else if thirteenGrayStyle {
            textColor = .themeMediumGrayLabel
            font = FontBook.light.font(ofSize: 13)
        } else if thirteenDarkGrayStyle {
            textColor = .themeDarkGrayLabel
            font = FontBook.light.font(ofSize: 13)
        } else {
            self.textColor = fontColor
        }

        if regular {
            font = FontBook.regular.font(ofSize: Font_Size)
        } else if extraLight {
            font = FontBook.light.font(ofSize: Font_Size)
        } else if semiBold {
            font = FontBook.bold.font(ofSize: Font_Size)
        } else if bold {
            font = FontBook.bold.font(ofSize: Font_Size)
        }

        if blueColor {
            self.textColor = UIColor.themePrimary
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
}

class UILabelPadded: UILabel {
    var leftPadding: CGFloat = 0
    override func drawText(in rect: CGRect) {
     let insets = UIEdgeInsets.init(top: 0, left: leftPadding, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
