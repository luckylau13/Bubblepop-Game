//
//   Bubble.swift
//  bubblepopa2
//
//  Created by Lucky Lau on 10/5/20.
//  Copyright © 2020 Lucky Lau. All rights reserved.
//


import UIKit

class Bubble: UIButton {
    
    var value: Double = 0
    var radius: UInt32{
        return UInt32(UIScreen.main.bounds.width / 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
            //make the button round
        self.layer.cornerRadius = CGFloat(radius)
        
        let possibility = Int(arc4random_uniform(100))
        switch possibility {
        case 0...39:
            self.backgroundColor = #colorLiteral(red: 0.8556245058, green: 0.01188034285, blue: 0.1261294633, alpha: 1)
            self.value = 1
        case 40...69:
            self.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            self.value = 2
        case 70...84:
            self.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            self.value = 5
        case 85...94:
            self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            self.value = 8
        case 95...99:
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.value = 10
        default: print("error")
        }
    }
    
    func animate(){
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
}
