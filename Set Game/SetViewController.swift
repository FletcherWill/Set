//
//  ViewController.swift
//  Set Game
//
//  Created by Will Fletcher on 6/25/19.
//  Copyright © 2019 Will Fletcher. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

   
    @IBOutlet weak var scoreLabel: UILabel?
    
    var game = Set_Game()
    
  
    
    @IBOutlet var setCards: [PlayingCardView]! {
        didSet {
            for card in setCards {
                let tap = UITapGestureRecognizer(target: self, action: #selector(selectCard(tap:)))
                card.addGestureRecognizer(tap)
            }
        }
    }
    
    
    @objc func selectCard(tap: UITapGestureRecognizer) {
        let touchPoint = tap.location(in: view)
        guard let label = setCards.first(where: { $0.frame.contains(touchPoint) }) else { return }
        let index = setCards.firstIndex(of: label)!
        game.selectCard(at: index)
        updateViewFromModel()
    }
    
    @IBOutlet weak var dealCardsButton: UIButton! {
        didSet {
            updateViewFromModel()
        }
    }
    
    
    @IBAction func getHint(_ sender: UIButton) {
        game.getHint()
        updateViewFromModel()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Set_Game()
        updateViewFromModel()
    }
    
    
    @IBAction func touchDealButton(_ sender: UIButton) {
        game.dealMoreCards()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in 0..<setCards.count {
            let view = setCards[index]
            if game.cards.count <= index || game.cards[index].isMatched || !game.cards[index].isDealt {
                view.isShown = false
            } else {
                let card = game.cards[index]
                view.isShown = true
                view.shape = card.shape.rawValue
                view.fill = card.shading.rawValue
                view.number = card.numShapes.rawValue
                view.drawColor = card.color.rawValue
                
                if game.cards[index].isSelected {
                    view.backColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                } else if game.cards[index].isHint{
                    view.backColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                } else {
                    view.backColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            }
        }
        
        
        if !game.canDeal {
            dealCardsButton.setTitle("Max Cards Dealt", for: UIControl.State.normal)
            if game.getMatch() == nil {
                for index in game.faceUpCards {
                    setCards[index].backColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
                    dealCardsButton.setTitle("Game Finished", for: UIControl.State.normal)
                }
            }
        } else {
            dealCardsButton.setTitle("Deal More Cards", for: UIControl.State.normal)
        }
        if let label = scoreLabel {
            label.text = "Score: \(game.score)"
        }
    }
    
}
