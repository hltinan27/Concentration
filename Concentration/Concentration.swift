//
//  Concentration.swift
//  Concentration
//
//  Created by inan on 27.04.2018.
//  Copyright © 2018 inan. All rights reserved.
//

import Foundation

class Concentration
{
  var cards = [Card]()
  var shuffleCards = [Card]()
  
  var indexOfOneOnlyFaceUpCard: Int? {
    get{
     return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
//      let face = cards.indices.filter({cards[$0].isFaceUp})
//      return face.count == 1 ? face.first : nil
      
      
//      var foundIndex: Int?
//      for index in cards.indices {
//        if cards[index].isFaceUp {
//          if foundIndex == nil {
//            foundIndex = index
//          }else{
//            return nil
//          }
//        }
//      }
//      return foundIndex
   }
    set{
      for index in cards.indices{
        cards[index].isFaceUp = (index == newValue)
      }
    }
  }
  
  func chooseCard(at index: Int){
    if !cards[index].isMatched {
      if let matchIndex = indexOfOneOnlyFaceUpCard, matchIndex != index {
//        print("Matchindex: \(cards[matchIndex])")
//        print("index: \(cards[index])")
        if cards[matchIndex] == cards[index]{
          cards[matchIndex].isMatched = true
          cards[index].isMatched = true
        }
        cards[index].isFaceUp = true
      }else {
        indexOfOneOnlyFaceUpCard = index
      }
    }
    
  }
  
  init(numberOfPairOfCards: Int) {
    for _ in 1...numberOfPairOfCards{
      let card = Card()
      cards += [card, card]
    }
    for _ in 0..<cards.count{
      let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
      shuffleCards.append(cards[randomIndex])
      cards.remove(at: randomIndex)
    }
    cards = shuffleCards
    
  }
}


extension Collection {
  var oneAndOnly: Element? {
    return count == 1 ? first : nil
  }
}

