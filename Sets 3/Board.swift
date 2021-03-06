//
//  Board.swift
//  Sets 2
//
//  Created by Apple on 13/01/19.
//  Copyright © 2019 Ztack. All rights reserved.
//

import UIKit

class Board: UIView {
    var deck = cardDeck(){
        didSet{
        }
    }
    var cardsOnBoard: [Card] = []{
        didSet{
        }
    }
    var completeResetView = true
    var cardViews = [cardView]()
    var cardsCount: Int = 0{
        didSet{
            if completeResetView{
                setRowCol()
                grid = Grid(layout: Grid.Layout.dimensions(rowCount: row, columnCount: col), frame: bounds)
                setNeedsLayout()
                setNeedsDisplay()
            }
        }
    }
    func clearAllSubviews(){
        for view in self.subviews{
            view.removeFromSuperview()
        }
        cardViews.removeAll()
    }
    func addCards(_ oldBoard: Board, newGame: sets2 ){
        completeResetView = false
        self.deck = newGame.deck
        self.cardsOnBoard = newGame.cardsOnBoard
        self.cardsCount =  newGame.cardsOnBoard.count
        setRowCol()
        grid = Grid(layout: Grid.Layout.dimensions(rowCount: row, columnCount: col), frame: bounds)
        setNeedsLayout()
        print("escaped setneedslayout")
    }
    lazy var row = 9
    lazy var col = 9
    func setRowCol(){
        if cardsCount < 10{
            row = 3
            col = 3
        }else if cardsCount < 17{
            row = 4
            col = 4
        }else if cardsCount < 26{
            row = 5
            col = 5
        }else if cardsCount < 37{
            row = 6
            col = 6
        }else if cardsCount < 50{
            row = 7
            col = 7
        }else if cardsCount < 65{
            row = 8
            col = 8
        }else if cardsCount < 82{
            row = 9
            col = 9
        }else {
            print("Error: cardsCount in Board.sift out of range")
        }
    }
    lazy var grid = Grid(layout: Grid.Layout.dimensions(rowCount: row, columnCount: col), frame: bounds)
    
    override func draw(_ rect: CGRect) {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if completeResetView{
            print("completeres \(completeResetView)")
            cardViews.removeAll()
            for index in 0..<cardsCount{
                let frame_i = grid.cellFrames[index]
                let frame = CGRect(x: frame_i.origin.x + frame_i.width/10, y: frame_i.origin.y + frame_i.height/10, width: frame_i.width * 0.8, height: frame_i.height*0.8)
                let tempCard = cardView(frame: frame)
                tempCard.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                tempCard.card = cardsOnBoard[index]
                cardViews.append(tempCard)
            }
            for view in cardViews{
                self.addSubview(view)
            }
        }else{
            var newCardViews = [cardView]()
            for index in 0..<cardsCount{
                let frame_i = grid.cellFrames[index]
                let frame = CGRect(x: frame_i.origin.x + frame_i.width/10, y: frame_i.origin.y + frame_i.height/10, width: frame_i.width * 0.8, height: frame_i.height*0.8)
                let tempCard = cardView(frame: frame)
                tempCard.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                tempCard.card = cardsOnBoard[index]
                newCardViews.append(tempCard)
                print("newCardViews[\(index)].origin = \(newCardViews[index].frame.origin)")
            }
            for index in newCardViews.indices{
                if index < cardViews.count {
                    UIView.transition(
                        with: self,
                        duration: 0.3,
                        options: UIView.AnimationOptions.curveEaseOut,
                        animations: {
                            self.subviews[index].frame = newCardViews[index].frame
                        }
                    )
                }else{
                    print("entered case where new cards are to be placed")
                    let requiredOrigin = newCardViews[index].frame.origin
                    newCardViews[index].frame.origin = CGPoint(x: -2*newCardViews[index].frame.width, y: newCardViews[index].frame.origin.y)
                    self.addSubview(newCardViews[index])
                    UIView.transition(
                        with: self,
                        duration: 0.3,
                        options: UIView.AnimationOptions.curveEaseOut,
                        animations: {
                            self.subviews[index].frame.origin = requiredOrigin
                    }
                    )
                }
            }
            print("self.subviews.count = \(self.subviews.count)")
            cardViews = newCardViews
            completeResetView = true
        }
    }
    
}
