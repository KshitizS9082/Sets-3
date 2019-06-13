//
//  cardDeck.swift
//  Sets 3
//
//  Created by Apple on 26/01/19.
//  Copyright © 2019 Ztack. All rights reserved.
//
import Foundation
import UIKit

struct cardDeck {
    var cards = [Card]()
    
    init(){
        var card = Card()
        let colors = [#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)]
        for color in colors{
            for shape in 0...2{
                for shading in 0...2{
                    for numer in Card.Number.all{
                        card.isSelected = false
                        card.color = color
                        card.shape = shape
                        card.shading = shading
                        card.number = numer
                        cards.append(card)
                    }
                }
            }
        }
        cards.shuffle()
    }
}
