
import Foundation
import UIKit
struct Card {
    var isSelected = false
    var color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    var shape = 0
    var shading = 0
    var number = Number.one
    enum Number: Int{
        case one = 1
        case two = 2
        case three = 3
        static var all: [Number]{
            return [Number.one, Number.two, Number.three]
        }
    }
}
