//
//  ViewController.swift
//  Demo
//
//  Created by Jawad Ali on 09/09/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
import LiquidTabBarController
class ViewController: LiquidTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HOME_ID")
        let chatStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CHAT_ID")
        let sleepStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SLEEP_ID")
        let musicStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MUSIC_ID")
       
        
        homeStoryboard.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tab1"), tag: 0)
        chatStoryboard.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "tab2"), tag: 1)
        sleepStoryboard.tabBarItem = UITabBarItem(title: "Report", image: UIImage(named: "tab3"), tag: 2)
        musicStoryboard.tabBarItem = UITabBarItem(title: "tab4", image: UIImage(named: "tab4"), tag: 3)
       
           
        viewControllers = [homeStoryboard, chatStoryboard,sleepStoryboard,musicStoryboard]

    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController: LiquidTabBarControllerDelegate {
    func tabBarController(_ tabBarController: LiquidTabBarController, didSelect viewController: UIViewController) {
        print(viewController.tabBarItem.title ?? "")
    }
}
 
