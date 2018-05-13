//
//  Card.swift
//  Concentration
//
//  Created by inan on 27.04.2018.
//  Copyright © 2018 inan. All rights reserved.
//

import Foundation

struct Card : Hashable{
  var isFaceUp = false
  var isMatched = false
  var identifier: Int
  
  var hashValue: Int {
    return identifier
  }
  static func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.identifier == rhs.identifier
  }
  
  private static var identifierFactory = 0
  
  static func getUniqueIdentifier() -> Int {
    identifierFactory += 1
    return identifierFactory
  }
  
  init() {
    self.identifier = Card.getUniqueIdentifier()
  }
}
