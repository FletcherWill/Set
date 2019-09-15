//
//  Set_Game.swift
//  Set Game
//
//  Created by Will Fletcher on 6/25/19.
//  Copyright © 2019 Will Fletcher. All rights reserved.
//

import Foundation

class Set_Game {
    
    var cards: [Card] = []
    
    var score = 0
    
    var canDeal: Bool {
        var count = 0
        var numMatched = 0
        for card in cards {
            if card.isDealt && !card.isMatched {count += 1}
            if card.isMatched {numMatched += 1}
        }
        if count < 20 && cards.count > count + numMatched {
            return true
        } else {
            return false
        }
        
    }
    
    var indicesOfSelected: [Int] {
        var indicies: [Int] = []
        for index in faceUpCards {
            if cards[index].isSelected {
                indicies += [index]
            }
        }
        return indicies
    }
    
    
    var faceUpCards: [Int] {
        var indicies: [Int] = []
        for index in cards.indices {
            if cards[index].isDealt && !cards[index].isMatched {
                indicies += [index]
            }
        }
        return indicies
    }
    
    init() {
        for i in 0...2 {
            for j in 0...2 {
                for k in 0...2 {
                    for l in 0...2 {
                        let card = Card(shape: Shape(rawValue: i)!, numShapes: NumShapes(rawValue: j)!, shading: Shading(rawValue: k)!, color: Color(rawValue: l)!)
                        cards += [card]
                    }
                }
            }
        }
        // shuffle cards
        for index in cards.indices {
            let insert = Int.random(in: index..<cards.count)
            let temp = cards[index]
            cards[index] = cards[insert]
            cards[insert] = temp
        }
        for index in 0..<12 {
            cards[index].isDealt = true
        }
    }
    
    func dealMoreCards() {
        var cardsToDeal = 3
        for index in cards.indices {
            if cardsToDeal > 0 && canDeal {
                if cards[index].isMatched {
                    let insert = cards.remove(at: cards.count - 1)
                    cards[index] = insert
                    cards[index].isDealt = true
                    cardsToDeal -= 1
                }
                else if !cards[index].isDealt {
                    cards[index].isDealt = true
                    cardsToDeal -= 1
                }
            } else {
                return
            }
        }
    }
    
    func checkForMatch(for indicies: [Int]) -> Bool {
        if indicies.count != 3 {
            // throw exception
        }
        let card1 = cards[indicies[0]]
        let card2 = cards[indicies[1]]
        let card3 = cards[indicies[2]]
        if (card1.color.rawValue + card2.color.rawValue + card3.color.rawValue) % 3 == 0  && (card1.shape.rawValue + card2.shape.rawValue + card3.shape.rawValue) % 3 == 0 && (card1.shading.rawValue + card2.shading.rawValue + card3.shading.rawValue) % 3 == 0 && (card1.numShapes.rawValue + card2.numShapes.rawValue + card3.numShapes.rawValue) % 3 == 0{
            return true
        } else {
            return false
        }
    }
    
    func takeSet() {
        for index in indicesOfSelected.reversed() {
            cards[index].isMatched = true
            let lastFaceUpCard = faceUpCards.last!
            if  lastFaceUpCard <= index {
                cards.remove(at: index)
            }
        }
        score += 3
    }
    
    func returnSet() {
        for index in indicesOfSelected {
            cards[index].isSelected = false
        }
        score -= 1
    }
    
    func getMatch() -> [Int]? {
        let indicies = faceUpCards
        for i in 0..<indicies.count {
            for j in (i+1)..<indicies.count {
                for k in (j+1)..<indicies.count {
                    if checkForMatch(for: [indicies[i],indicies[j],indicies[k]]) {
                        return [indicies[i],indicies[j],indicies[k]]
                    }
                }
            }
        }
        return nil
    }
    
    func getHint() {
        score -= 5
        for index in cards.indices {
            cards[index].isSelected = false
        }
        if let matchIndices = getMatch() {
            for index in matchIndices {
                cards[index].isHint = true
            }
        } else {
            dealMoreCards()
        }
    }
    
    func selectCard(at index: Int) {
        if cards[index].isDealt && !cards[index].isMatched {
            cards[index].isSelected = !cards[index].isSelected
            if indicesOfSelected.count == 3 {
                if checkForMatch(for: indicesOfSelected) {
                    takeSet()
                } else {
                    returnSet()
                }
            }
            for index in cards.indices {
                cards[index].isHint = false
            }
        }
    }
    
    
}
