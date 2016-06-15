//
//  ViewController.swift
//  IEHTopScrollTabBar
//
//  Created by ismail el habbash on 14/06/2016.
//  Copyright © 2016 ismail el habbash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = TopScrollTabBarItem(title: "Hot", color: UIColor(red: 2/255, green: 174/255, blue: 220/255, alpha: 1))
        let item2 = TopScrollTabBarItem(title: "Social", color: UIColor(red: 255/255, green: 212/255, blue: 100/255, alpha: 1))
        let item3 = TopScrollTabBarItem(title: "Politics", color: UIColor(red: 18/255, green: 83/255, blue: 164/255, alpha: 1))
        let item4 = TopScrollTabBarItem(title: "Business", color: UIColor(red: 47/255, green: 205/255, blue: 180/255, alpha: 1))
        let item5 = TopScrollTabBarItem(title: "Entertaiment", color: UIColor(red: 251/255, green: 168/255, blue: 72/255, alpha: 1))
        let item6 = TopScrollTabBarItem(title: "Tech", color: UIColor(red: 12/255, green: 85/255, blue: 93/255, alpha: 1))
        let item7 = TopScrollTabBarItem(title: "Media", color: UIColor(red: 2/255, green: 150/255, blue: 200/255, alpha: 1))
        let item8 = TopScrollTabBarItem(title: "Comedy", color: UIColor(red: 255/255, green: 83/255, blue: 200/255, alpha: 1))
        let topScrollTabBarItems = [item1, item2, item3, item4, item5, item6, item7, item8]

        let topScrollTabBar = TopScrollTabBar(inView: view, items: topScrollTabBarItems)

        view.addSubview(topScrollTabBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

