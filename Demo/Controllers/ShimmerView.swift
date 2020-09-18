//
//  ShimmerView.swift
//  ShimmerAnimationComplete
//
//  Created by Jha, Vasudha on 29/11/19.
//  Copyright © 2019 Jha, Vasudha. All rights reserved.
//

import UIKit

class ShimmerView: UIView {

    var gradientColorOne : CGColor =  #colorLiteral(red: 0.2607625723, green: 0.2311978936, blue: 0.3661505282, alpha: 1)// UIColor(white: 0.85, alpha: 1.0).cgColor
    var gradientColorTwo  = #colorLiteral(red: 0.1865324974, green: 0.1558980048, blue: 0.3036286235, alpha: 1).cgColor //UIColor(white: 0.95, alpha: 1.0).cgColor
    var gradientLayer:CAGradientLayer?
    
    
    func addGradientLayer() -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.opacity = 0.4
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)
        
        return gradientLayer
    }
    
    func addAnimation() -> CABasicAnimation {
       
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 3
        return animation
    }
    
    func startAnimating() {
        
        let gradientLayer = addGradientLayer()
        self.gradientLayer = gradientLayer
        let animation = addAnimation()
       
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    func StopAnimation() {
        gradientLayer?.removeAllAnimations()
        gradientLayer?.removeFromSuperlayer()
    }
    

}
