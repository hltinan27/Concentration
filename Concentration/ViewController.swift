//
//  ViewController.swift
//  Concentration
//
//  Created by inan on 27.04.2018.
//  Copyright © 2018 inan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
  

  
  @IBOutlet weak var flipCountLabel: UILabel!{
    didSet{
      updateFlipCountLabel()
    }
  }
  
  @IBOutlet var cardButtons: [UIButton]!
  
  
  
  private(set) var flipCount = 0 {
    didSet{
      updateFlipCountLabel()
    }
  }
  
  // MARK: NSAttributedStringKey
  func updateFlipCountLabel(){
    let attributes: [NSAttributedStringKey:Any] = [
      .strokeWidth : 5.0,
      .strokeColor : UIColor.green
    ]
    let attributedText = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
    flipCountLabel.attributedText = attributedText
  }
  
  
  @IBAction func touchCard(_ sender: UIButton) {
    flipCount += 1
    if let cardNumber = cardButtons.index(of: sender){
      game.chooseCard(at: cardNumber)
      updateFromModel()
      //print(cardNumber)
    }
  }
  
  func updateFromModel(){
    for index in cardButtons.indices {
      let button = cardButtons[index]
      let card = game.cards[index]
      if card.isFaceUp{
        button.setTitle(emoji(for: card), for: UIControlState.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      }else{
        button.setTitle("", for: UIControlState.normal)
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)    }
    }
  }

  var emojiChoices = "🎃👻🦊🐸🦖🐺🦉🕷🐟"
  var emoji = [Card:String]()
  
  func emoji(for card: Card) -> String{
    if emoji[card] == nil, emojiChoices.count > 0 {
      let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
      emoji[card] = String(emojiChoices.remove(at: randomIndex))
      
    }
    
    return emoji[card] ?? "?"
  }
}

extension Int {
  var arc4random: Int {
    if self > 0 {
      return Int(arc4random_uniform(UInt32(self)))
    }else if self < 0 {
      return -Int(arc4random_uniform(UInt32(abs(self))))
    }else{
      return 0
    }
  }
}


