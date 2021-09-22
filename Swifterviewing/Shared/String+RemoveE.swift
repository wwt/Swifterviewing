//
//  String+RemoveE.swift
//  Swifterviewing
//
//  Created by Robert Daly on 9/22/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

extension String {
    func removeE() -> String {
        self.replacingOccurrences(of: "e", with: "", options: .caseInsensitive)
    }
}
