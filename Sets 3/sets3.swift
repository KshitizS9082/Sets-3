//
//  sets2.swift
//  Sets 2
//
//  Created by Apple on 13/01/19.
//  Copyright © 2019 Ztack. All rights reserved.
//

import Foundation
import UIKit

struct sets2{
    var deck = cardDeck()
    var cardsOnBoard = [Card]()
    var selected = [Int]()
    var game_finished = false
    var score = 0.0
    var numberOfaddCards = 0
    var numberOfRightMatch = 0
    func scoreForAddCard() -> Double {
        if(numberOfaddCards - Int((numberOfRightMatch/3)))<=1{
            return 4
        }else {
            return Double((numberOfaddCards - Int((numberOfRightMatch/3)))*4)
        }
    }
    mutating func addCard(){
        numberOfaddCards+=1
        for _ in 0...2{
            if !deck.cards.isEmpty{
                cardsOnBoard.append(deck.cards.popLast()!)
            }else{
                print("Error: Tried to extract out of empty deck!")
            }
        }
        score+=scoreForAddCard()
    }
    
    func propertyFollowsSet (prprty1: Int,prprty2: Int, prprty3: Int) -> Bool{
        if allMatched(prprty1: prprty1, prprty2: prprty2, prprty3: prprty3) || allDifferent(prprty1: prprty1, prprty2: prprty2, prprty3: prprty3){
            return true
        }
        return false
    }
    func propertyFollowsSet_color (prprty1: UIColor,prprty2: UIColor, prprty3: UIColor) -> Bool{
        if allMatched_color(prprty1: prprty1, prprty2: prprty2, prprty3: prprty3) || allDifferent_color(prprty1: prprty1, prprty2: prprty2, prprty3: prprty3){
            return true
        }
        return false
    }
    func allMatched(prprty1: Int,prprty2: Int, prprty3: Int) -> Bool{
        if prprty1 != prprty2 || prprty2 != prprty3 || prprty3 != prprty1{
            return false
        }
        return true
    }
    func allMatched_color(prprty1: UIColor,prprty2: UIColor, prprty3: UIColor) -> Bool{
        if prprty1 != prprty2 || prprty2 != prprty3 || prprty3 != prprty1{
            return false
        }
        return true
    }
    func allDifferent(prprty1: Int,prprty2: Int, prprty3: Int) -> Bool{
        if prprty1 == prprty2 || prprty2 == prprty3 || prprty3 == prprty1{
            return false
        }
        return true
    }
    func allDifferent_color(prprty1: UIColor,prprty2: UIColor, prprty3: UIColor) -> Bool{
        if prprty1 == prprty2 || prprty2 == prprty3 || prprty3 == prprty1{
            return false
        }
        return true
    }
    func isSet(card1: Card,card2: Card,card3: Card) -> Bool{
        if propertyFollowsSet_color(prprty1: card1.color, prprty2: card2.color, prprty3: card3.color) && propertyFollowsSet(prprty1: card1.number.rawValue, prprty2: card2.number.rawValue, prprty3: card3.number.rawValue) && propertyFollowsSet(prprty1: card1.shape, prprty2: card2.shape, prprty3: card3.shape) && propertyFollowsSet(prprty1: card1.shading, prprty2: card2.shading, prprty3: card3.shading){
            return true
        }
        return false
    }
    mutating func chooseCard(at index: Int){
        if index>=cardsOnBoard.count{
            return
        }
        if (cardsOnBoard.count<=3){
            game_finished = true
            print("game Finished")
            return
        }
        for i in selected{
            if index == i && selected.count<3{
                cardsOnBoard[index].isSelected = false
                //                score = score - 1
                selected.remove(at: selected.index(of: i)!)
                score+=scoreForUnselect
                return
            }
        }
        if selected.count <= 1{
            cardsOnBoard[index].isSelected = true
            selected.append(index)
        }else if selected.count == 2{
            cardsOnBoard[index].isSelected = true
            selected.append(index)
            //if three cards selected and matched
            if isSet(card1: cardsOnBoard[selected[0]], card2: cardsOnBoard[selected[1]], card3: cardsOnBoard[selected[2]]){
                score+=scoreForRightMatch
                numberOfRightMatch+=1
                if(deck.cards.count>=3){
                    cardsOnBoard[selected[0]] = deck.cards.popLast()!
                    cardsOnBoard[selected[1]] = deck.cards.popLast()!
                    cardsOnBoard[selected[2]] = deck.cards.popLast()!
                    selected.removeAll()
                }else{
                    //                    game_finished = true
                    selected.sort()
                    cardsOnBoard.remove(at: selected[0])
                    cardsOnBoard.remove(at: selected[1]-1)
                    cardsOnBoard.remove(at: selected[2]-2)
                    selected.removeAll()
                    return
                }
            }else{//if three selected cards not macthed
                score+=scoreForWrongMatch
                cardsOnBoard[selected[0]].isSelected = false
                cardsOnBoard[selected[1]].isSelected = false
                cardsOnBoard[selected[2]].isSelected = false
                selected.removeAll()
            }
        }
    }
    
    mutating func initialiseCardOnBoard() -> [Card]{
        var cob = [Card]()
        for _ in 0...11{
            cob.append(deck.cards.remove(at: 0))
        }
        return cob
    }
    
    init(){
        cardsOnBoard = initialiseCardOnBoard()
    }
}
extension sets2{
    var scoreForWrongMatch: Double{
        return -3.5
    }
    var scoreForRightMatch: Double{
        return 9
    }
    var scoreForUnselect: Double{
        return -1
    }
}
