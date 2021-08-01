//
//  Utilities.swift
//  Swifterviewing
//
//  Created by SOWJI on 01/08/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

extension UIImageView {
    // Image downloading from URL
    func downloadedFrom(_ url: URL, mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        self.image = nil
        self.backgroundColor = .clear
        DataManager.HTTPGetDataRequest(url: url) { (data) in
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

extension String {
    // Replacing character e in string
    mutating func removeCharacter() -> String {
        replacingOccurrences(of: "e", with: "")
    }
}
