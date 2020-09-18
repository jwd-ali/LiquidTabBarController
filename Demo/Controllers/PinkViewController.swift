//
//  PinkViewController.swift
//  SOTabBar_Example
//
//  Created by Jawad Ali on 02/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class PinkViewController: UIViewController {

    @IBOutlet weak var shimmerView: ShimmerView!
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        
        self.title = "Reports"
        
        shimmerView.layer.shadowOffset = .zero
                              shimmerView.layer.shadowColor = UIColor.black.cgColor
                              shimmerView.layer.shadowOpacity = 0.3
                              shimmerView.layer.shadowRadius = 8
               
                        shimmerView.startAnimating()
                 
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
     //    shimmerView.startAnimating()
        super.viewDidAppear(animated)
    }


    @IBAction func goTo(_ sender: UIButton) {
        self.jDTabBarController?.selectedIndex = sender.tag
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shimmerView.StopAnimation()
        
    }
    
}

@IBDesignable public class ShadowButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
         commonInit()
    }
    
    private func commonInit() {
        self.addShadow()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
         self.addShadow()
    }
 
}

public extension ShadowButton {
     func addShadow() {
        layer.cornerRadius = bounds.midY
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0,height: 5)
    }
}
