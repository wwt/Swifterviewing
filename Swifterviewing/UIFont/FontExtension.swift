//
//  FontExtension.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

//MARK: - FontExtension
extension UIFont {
    static func boldStyle(size: CGFloat) -> UIFont {
        return UIFont(name: String.fontRobotoBold, size: size) ??
            UIFont.boldSystemFont(ofSize: size)
    }
    
    static func regularStyle(size: CGFloat) -> UIFont {
        return UIFont(name: String.fontRobotoRegular, size: size) ??
            UIFont.systemFont(ofSize: size)
    }
    
    static func mediumStyle(size: CGFloat) -> UIFont {
        return UIFont(name: String.fontRobotoMedium, size: size) ??
            UIFont.systemFont(ofSize: size)
    }
}

//MARK: - StringExtension
extension String {
    static let fontRobotoBold = "Roboto-Bold"
    static let fontRobotoRegular = "Roboto-Regular"
    static let fontRobotoMedium = "Roboto-Medium"
}

//MARK: - UILabelExtension
extension UILabel {
    // Applying style
    func applyStyle(font: UIFont, textColor: UIColor) {
        self.font = font
        self.textColor = textColor
    }
}

//MARK: - UIViewExtension
extension UIView
{
    // applying cardview
    func makeCardView()
    {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
    }
}
