//
//  IQTextView+Extension.swift
//  Populaw
//
//  Created by Gaurang on 30/09/21.
//

import IQKeyboardManagerSwift

extension IQTextView {

    func setThemeStyle(placeholder: String) {
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.themePrimary.withAlphaComponent(0.3).cgColor
        self.layer.cornerRadius = 10
        self.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        //self.font = FontBook.extraLight.font(ofSize: 15)
       // let placeholder = NSAttributedString(string: placeholder, attributes: [.font: FontBook.extraLight.font(ofSize: 15),
       //                                                                           .foregroundColor: UIColor.themeGrayLabel])
       // self.attributedPlaceholder = placeholder
    }

}
