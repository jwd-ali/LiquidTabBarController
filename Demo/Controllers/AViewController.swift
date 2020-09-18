//
//  AViewController.swift
//  SOTabBar_Example
//
//  Created by Jawad Ali on 04/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    @IBOutlet var shimmerViews: [ShimmerView]!
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)

       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        shimmerViews.forEach { (shimmer) in
               shimmer.layer.cornerRadius = 20
               shimmer.gradientLayer?.cornerRadius =  20
               shimmer.gradientLayer?.masksToBounds = true
               shimmer.layer.shadowOffset = .zero
                                 shimmer.layer.shadowColor = UIColor.black.cgColor
                                 shimmer.layer.shadowOpacity = 0.3
                                 shimmer.layer.shadowRadius = 8
           }
//        shimmerViews.forEach { (shimmer) in
//            //shimmer.backgroundColor = .clear
//            shimmer.layer.masksToBounds = true
//
//        let i = Double.random(in: 0...1)
//            DispatchQueue.main.asyncAfter(deadline: .now() + i) {
//                 shimmer.startAnimating()
//            }
//
//        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
     
    }
}
