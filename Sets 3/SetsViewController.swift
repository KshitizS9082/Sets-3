
import UIKit

class SetsViewController: UIViewController {
    
    var game = sets2()
    let westw = 2
    lazy var screenSize = UIScreen.main.bounds
    //    let width = screenSize.width
    lazy var boardView = Board(frame: CGRect(x: screenSize.width*5/100 , y: screenSize.height*5/100, width: screenSize.width*90/100, height: screenSize.height*75/100))
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        print("asdf")
        reInitialiseBoard()
        //        print("qwerty")
        self.view.addSubview(boardView)
        //        print("zxcvb")
    }
    
    @objc func newGame2(_ sender: UIButton) {
        scoreLabel.isHidden = true
        boardView.isHidden = false
        game = sets2()
        let originEarlier = self.boardView.frame.origin
        UIView.transition(
            with: boardView,
            duration: 0.4,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: {
                
                self.boardView.frame.origin = CGPoint(x: self.screenSize.width*1.25, y: self.boardView.frame.origin.y)
//                self.boardView.clearAllSubviews()
//                self.reInitialiseBoard()
//                self.boardView.frame.origin = originEarlier
            },
            completion: { finished in
                UIView.transition(
                    with: self.boardView,
                    duration: 0.4,
                    options: UIView.AnimationOptions.curveEaseOut,
                    animations: {
                        self.boardView.clearAllSubviews()
                        self.reInitialiseBoard()
                        self.boardView.frame.origin = originEarlier
                    }
                )
            }
        )
//        boardView.clearAllSubviews()
//        reInitialiseBoard()
    }
    lazy var height = screenSize.height
    lazy var width = screenSize.width
    lazy var origin = screenSize.origin
    lazy var newGame = UIButton(frame: CGRect(x: origin.x + width*10/100, y: screenSize.maxY-height*10/100, width: width*30/100, height: height*7/100))
    lazy var add = UIButton(frame: CGRect(x: origin.x + width*60/100, y: screenSize.maxY-height*10/100, width: width*30/100, height: height*7/100))
    var tapRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var scoreLabel: UILabel!{
        didSet{
            scoreLabel.isHidden = true
            boardView.isHidden = false
            game = sets2()
            let originEarlier = self.boardView.frame.origin
            UIView.transition(
                with: boardView,
                duration: 0,
                options: UIView.AnimationOptions.curveEaseOut,
                animations: {
                    
                    self.boardView.frame.origin = CGPoint(x: self.screenSize.width*1.25, y: self.boardView.frame.origin.y)
            },
                completion: { finished in
                    UIView.transition(
                        with: self.boardView,
                        duration: 0.65,
                        options: UIView.AnimationOptions.curveEaseOut,
                        animations: {
                            self.boardView.clearAllSubviews()
                            self.reInitialiseBoard()
                            self.boardView.frame.origin = originEarlier
                    }
                    )
            }
            )
            
            
            UIView.transition(
                with: boardView,
                duration: 0.65,
                options: UIView.AnimationOptions.curveEaseOut,
                animations: {
                    self.boardView.clearAllSubviews()
                    self.reInitialiseBoard()
                    self.boardView.frame.origin = originEarlier
                }
        )
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnImage))
        boardView.addGestureRecognizer(tapRecognizer)
        newGame.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9450980392, blue: 0.9176470588, alpha: 1)
        add.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9450980392, blue: 0.9176470588, alpha: 1)
        newGame.setTitle("New Game", for: UIControl.State.normal)
        newGame.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1), for: UIControl.State.normal)
        newGame.addTarget(self, action: #selector(newGame2(_:)), for: UIControl.Event.touchUpInside)
        newGame.layer.cornerRadius = cornerRadius
        add.layer.cornerRadius = cornerRadius
        add.setTitle("Add Cards", for: UIControl.State.normal)
        add.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1), for: UIControl.State.normal)
        add.addTarget(self, action: #selector(AddCards2(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(newGame)
        self.view.addSubview(add)
    }
    @objc func tapOnImage(){
        let location = tapRecognizer.location(in: boardView)
        var range: Int{
            if boardView.cardsOnBoard.count < boardView.grid.cellFrames.count{
                return boardView.cardsOnBoard.count
            }else{
                return boardView.grid.cellFrames.count
            }
        }
        for index in 0..<range{
            //            print("\(index) entered")
            if boardView.grid.cellFrames[index].contains(location){
                //                print(index)
                selectCard(at: index)
                break
            }
            //            print("\(index) escaped")
        }
        
    }
    func selectCard(at Index: Int) {
        game.chooseCard(at: Index)
//        if game.cardsOnBoard.count < boardView.cardsOnBoard.count{
//            boardView.addCards(boardView, newGame: game)
//        }
        boardView.clearAllSubviews()
        reInitialiseBoard()
        //If Game Finished
        if game.game_finished{
            boardView.clearAllSubviews()
            boardView.isHidden=true
            scoreLabel.text =
            """
            Game Complete!
            
            Score: \(game.score)
            """
            scoreLabel.bounds.origin =  CGPoint(x: screenSize.width*10/100 , y: screenSize.height*10/100)
            scoreLabel.layer.cornerRadius = cornerRadius
            scoreLabel.layer.backgroundColor = #colorLiteral(red: 0.1490006149, green: 0.1490328908, blue: 0.148996383, alpha: 1)
            scoreLabel.font.withSize(screenSize.width/10)
            scoreLabel.isHidden  = false
            scoreLabel.numberOfLines = 0
        }
    }
    @objc func AddCards2(_ sender: UIButton) {
        game.addCard()
        boardView.addCards(boardView, newGame: game)
//        boardView.clearAllSubviews()
//        reInitialiseBoard()
//        //        game.game_finished=true
//        let oldBoardView = boardView
//        boardView.addCards(oldBoardView, newGame: game)
    }
    func reInitialiseBoard(){
        boardView.deck = game.deck
        boardView.cardsCount = game.cardsOnBoard.count
        boardView.cardsOnBoard = game.cardsOnBoard
        
    }
}

extension SetsViewController{
    var cornerRadius: CGFloat {
        return UIScreen.main.bounds.height * 0.02
    }
}
