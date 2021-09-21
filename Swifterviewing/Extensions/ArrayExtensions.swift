//
//  ArrayExtensions.swift
//  Swifterviewing
//
//  Created by Zia Amini2 on 9/20/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

extension Array {
  
  func uniques<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
    return reduce([]) { result, element in
      let alreadyExists = (result.contains(where: { $0[keyPath: keyPath] == element[keyPath: keyPath] }))
      return alreadyExists ? result : result + [element]
    }
  }
  
}
