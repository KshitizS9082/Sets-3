
import UIKit

class cardView: UIView {
    
    var card =  Card(){
        didSet{setNeedsDisplay(); setNeedsLayout() }
    }
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        #colorLiteral(red: 0.9411764706, green: 0.9450980392, blue: 0.9176470588, alpha: 1).setFill()
        roundedRect.fill()
        if card.isSelected{
            print("selected Card in cardView")
            #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).setStroke()
            roundedRect.lineWidth = 7.0
            roundedRect.stroke()
        }else{
            #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).setStroke()
            roundedRect.stroke()
        }
        if card.shape == 0{//Oval shape
            switch card.number{
            case .one:
                let path = UIBezierPath(ovalIn: CGRect(x: 15*horizontalScale, y: 40*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                shade(path: path)
            case .two:
                let path_1 = UIBezierPath(ovalIn: CGRect(x: 15*horizontalScale, y: 25*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                let path_2 = UIBezierPath(ovalIn: CGRect(x: 15*horizontalScale, y: 55*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                shade(path: path_1)
                shade(path: path_2)
            case .three:
                let path_1 = UIBezierPath(ovalIn: CGRect(x: 15*horizontalScale, y: 10*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                let path_2 = UIBezierPath(ovalIn: CGRect(x: 15*horizontalScale, y: 40*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                let path_3 = UIBezierPath(ovalIn: CGRect(x: 15*horizontalScale, y: 70*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                shade(path: path_1)
                shade(path: path_2)
                shade(path: path_3)
            }
        }else if card.shape == 1{//rounded rect shap
            switch card.number{
            case .one:
                let path = UIBezierPath(roundedRect: CGRect(x: 15*horizontalScale, y: 40*verticalScale, width: 70*horizontalScale, height: 20*verticalScale), cornerRadius: shapeCornerRadius)
                shade(path: path)
            case .two:
                let path_1 = UIBezierPath(roundedRect: CGRect(x: 15*horizontalScale, y: 25*verticalScale, width: 70*horizontalScale, height: 20*verticalScale), cornerRadius: shapeCornerRadius)
                let path_2 = UIBezierPath(roundedRect: CGRect(x: 15*horizontalScale, y: 55*verticalScale, width: 70*horizontalScale, height: 20*verticalScale), cornerRadius: shapeCornerRadius)
                shade(path: path_1)
                shade(path: path_2)
            case .three:
                let path_1 = UIBezierPath(roundedRect: CGRect(x: 15*horizontalScale, y: 10*verticalScale, width: 70*horizontalScale, height: 20*verticalScale), cornerRadius: shapeCornerRadius)
                let path_2 = UIBezierPath(roundedRect: CGRect(x: 15*horizontalScale, y: 40*verticalScale, width: 70*horizontalScale, height: 20*verticalScale), cornerRadius: shapeCornerRadius)
                let path_3 = UIBezierPath(roundedRect: CGRect(x: 15*horizontalScale, y: 70*verticalScale, width: 70*horizontalScale, height: 20*verticalScale), cornerRadius: shapeCornerRadius)
                shade(path: path_1)
                shade(path: path_2)
                shade(path: path_3)
            }
        }else if card.shape==2{//diamond shape
            switch card.number{
            case .one:
                let path = diamond(rect: CGRect(x: 15*horizontalScale, y: 40*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                shade(path: path)
            case .two:
                let path_1 = diamond(rect: CGRect(x: 15*horizontalScale, y: 25*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                let path_2 = diamond(rect: CGRect(x: 15*horizontalScale, y: 55*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                shade(path: path_1)
                shade(path: path_2)
            case .three:
                let path_1 = diamond(rect: CGRect(x: 15*horizontalScale, y: 10*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                let path_2 = diamond(rect: CGRect(x: 15*horizontalScale, y: 40*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                let path_3 = diamond(rect: CGRect(x: 15*horizontalScale, y: 70*verticalScale, width: 70*horizontalScale, height: 20*verticalScale))
                shade(path: path_1)
                shade(path: path_2)
                shade(path: path_3)
            }
        }
        
    }
    
    var horizontalScale: CGFloat{
        return bounds.width/100
    }
    var verticalScale: CGFloat{
        return bounds.height/100
    }
    func diamond ( rect: CGRect) -> UIBezierPath{
        let path = UIBezierPath()
        //        print(rect.height, rect.width)
        path.move(to: CGPoint(x: rect.origin.x+rect.width/2, y: rect.origin.y+0) )
        path.addLine(to: CGPoint(x: rect.origin.x+rect.width, y: rect.origin.y+rect.height/2))
        path.addLine(to: CGPoint(x: rect.origin.x+rect.width/2, y: rect.origin.y+rect.height))
        path.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y+rect.height/2))
        path.addLine(to: CGPoint(x: rect.origin.x+rect.width/2, y: rect.origin.y))
        return path
    }
    func shade(path: UIBezierPath){
        card.color.setFill()
        card.color.setStroke()
        if(card.shading == 0){
            path.lineWidth = 5.0*horizontalScale
            path.stroke()
        }else if(card.shading == 1){
            path.lineWidth = 5.0*horizontalScale
            path.stroke()
            card.color.withAlphaComponent(0.7).setFill()
            path.fill()
        }else if(card.shading==2){
            path.lineWidth = 5.0*horizontalScale
            path.stroke()
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            path.addClip()
            let stripes = UIBezierPath()
            //            let x = Int(20/verticalScale)
            for i in 1...40{
                stripes.move(to: CGPoint(x: 0, y: 3*CGFloat(i)*verticalScale))
                stripes.addLine(to: CGPoint(x: bounds.width, y: 3*CGFloat(i)*verticalScale) )
                stripes.lineWidth = 2.0*horizontalScale
                stripes.stroke()
            }
            context?.restoreGState()
        }else{
            print("Error in line 131 of cardView.swift")
        }
    }
    
}
extension cardView{
    var cornerRadius: CGFloat {
        return bounds.size.height * 0.06
    }
    var fontSize: CGFloat{
        return bounds.size.height * 0.2
    }
    var shapeCornerRadius: CGFloat{
        return bounds.width/10
    }
}
