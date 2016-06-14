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
        let item8 = TopScrollTabBarItem(title: "Top Stories", color: UIColor(red: 255/255, green: 83/255, blue: 200/255, alpha: 1))

        let item9 = TopScrollTabBarItem(title: "Hot", color: UIColor(red: 2/255, green: 174/255, blue: 220/255, alpha: 1))
        let item10 = TopScrollTabBarItem(title: "Social", color: UIColor(red: 255/255, green: 212/255, blue: 100/255, alpha: 1))
        let item11 = TopScrollTabBarItem(title: "Politics", color: UIColor(red: 18/255, green: 83/255, blue: 164/255, alpha: 1))
        let item12 = TopScrollTabBarItem(title: "Business", color: UIColor(red: 47/255, green: 205/255, blue: 180/255, alpha: 1))
        let item13 = TopScrollTabBarItem(title: "Entertaiment", color: UIColor(red: 251/255, green: 168/255, blue: 72/255, alpha: 1))
        let item14 = TopScrollTabBarItem(title: "Tech", color: UIColor(red: 12/255, green: 85/255, blue: 93/255, alpha: 1))
        let item15 = TopScrollTabBarItem(title: "Media", color: UIColor(red: 2/255, green: 150/255, blue: 200/255, alpha: 1))
        let item16 = TopScrollTabBarItem(title: "Top Stories", color: UIColor(red: 255/255, green: 83/255, blue: 200/255, alpha: 1))

        let topScrollTabBarItems = [item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, item16]

        let topScrollTabBar = IEHTopScrollTabBar(inView: view, items: topScrollTabBarItems)
        topScrollTabBar.iehDelegate = self

        view.addSubview(topScrollTabBar)
    }
}

extension ViewController: IEHTopScrollTabBarDelegate {
    func scrollTabBarButtonPressed(sender:IEHTopScrollTabBar, buttonTapped: UIButton, atIndex index: Int) {
        print("sender = \(sender) ")
        print("buttonTapped = \(buttonTapped)")
        print("index = \(index)")
    }
}
