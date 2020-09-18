//
//  HomeViewController.swift
//  Demo
//
//  Created by Jawad Ali on 10/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import LiquidTabBarController
class HomeViewController: UIViewController {

    @IBOutlet var shimmerViewes: [ShimmerView]!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
       
        shimmerViewes.forEach { (shimmer) in
            //shimmer.backgroundColor = .white

            shimmer.layer.shadowOffset = .zero
            shimmer.layer.shadowColor = UIColor.black.cgColor
            shimmer.layer.shadowOpacity = 0.3
            shimmer.layer.shadowRadius = 8
            
        let i = Double.random(in: 0...1)
            DispatchQueue.main.asyncAfter(deadline: .now() + i) {
              //   shimmer.startAnimating()
            }
            
        }
    
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shimmerViewes.forEach { (shimmer) in
        
                 shimmer.StopAnimation()
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // jDNavigationController?.jDnavigationBar?.changeColor(#colorLiteral(red: 0.1186391339, green: 0.09400636703, blue: 0.2113042176, alpha: 1))
    }


    @IBAction func setStyle(_ sender: UIButton) {
      //  self.jDTabBarController?.tabBar.shapeType = Shape(rawValue: sender.tag) ?? Shape.upperRound
        
    }
}

