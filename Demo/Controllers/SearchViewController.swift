//
//  SearchViewController.swift
//  Demo
//
//  Created by Jawad Ali on 10/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var shimmerViews: [ShimmerView]!
    override func viewDidLoad() {
        self.title = "Search"
       
        shimmerViews.forEach { (shimmer) in
            //shimmer.backgroundColor = .clear
            shimmer.layer.shadowOffset = .zero
                       shimmer.layer.shadowColor = UIColor.black.cgColor
                       shimmer.layer.shadowOpacity = 0.3
                       shimmer.layer.shadowRadius = 8
        let i = Double.random(in: 0...1)
            DispatchQueue.main.asyncAfter(deadline: .now() + i) {
               //  shimmer.startAnimating()
            }
            
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

          // jDNavigationController?.jDnavigationBar?.changeColor(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1))
                          
       }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shimmerViews.forEach { (shimmer) in
        
                 shimmer.StopAnimation()
            
            
        }
        
    }
    @IBAction func changeTintColor(_ sender: UIButton) {
        jDTabBarController?.tabBar.tabBarTintColor = sender.backgroundColor ?? .white
    }
    

}
