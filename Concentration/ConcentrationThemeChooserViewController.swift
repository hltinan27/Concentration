//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by inan on 18.05.2018.
//  Copyright © 2018 inan. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

  let themes = [
    "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸⛳️🏹",
    "Animals": "🐶🐱🐻🦊🐸🦁🐝🦇🦋🕷🐍🐙",
    "Faces": "😇😍😎😡😱😓😴😵🤐😷😝😘",
  ]
  
  
  //MARK: SplitView to see the master screen at startup
  override func awakeFromNib() {
    splitViewController?.delegate = self
  }
  
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    if let cvc = secondaryViewController as? ConcentrationViewController{
      if cvc.theme == nil {
        return true
      }
    }
    return false
  }
  
  
  //MARK: Change theme without segue
  @IBAction func changeTheme(_ sender: Any) {
    if let cvc = splitViewDetailConcentrationViewController{
      if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName] {
        cvc.theme = theme
      }
    }else if let cvc = lastSeguedToConcentrationViewController{
      if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName] {
        cvc.theme = theme
        navigationController?.pushViewController(cvc, animated: true)
      }
    }else{
      performSegue(withIdentifier: "Choose Theme", sender: sender)
    }
    
  }
  
  
  // Last SplitView
  private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
    return splitViewController?.viewControllers.last as? ConcentrationViewController
  }
  
  // Last ConcentrationView
  private var lastSeguedToConcentrationViewController: ConcentrationViewController?
  
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "Choose Theme" {
        if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName] {
          print(themeName)
          if let cvc = segue.destination as? ConcentrationViewController{
            cvc.theme = theme
            lastSeguedToConcentrationViewController = cvc
          }
        }
        
      }
    }
  

}
