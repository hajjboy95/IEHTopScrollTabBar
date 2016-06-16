//
//  TopScrollTabBar.swift
//  IEHTopScrollTabBar
//
//  Created by ismail el habbash on 14/06/2016.
//  Copyright © 2016 ismail el habbash. All rights reserved.
//

import UIKit

class TopScrollTabBar: UIScrollView {

    private let height:CGFloat = 44.0
    private let buttonPadding:CGFloat = 10.0
    private lazy var topScrollBarButtons = [UIButton]()
    private lazy var bottomLayer = CALayer()

    private var selectedButton:UIButton = UIButton() {
        didSet {
            selectedButton.backgroundColor = selectedButton.titleColorForState(.Normal)
            selectedButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
            selectedButton.backgroundColor = selectedButton.titleColorForState(.Normal)
            self.backgroundColor = selectedButton.titleColorForState(.Normal)
            scrollViewBottomLayerColor(self.backgroundColor!)
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(inView:UIView, items:[TopScrollTabBarItem]) {
        let yPoint = UIApplication.sharedApplication().statusBarFrame.height
        let rect = CGRect(x: inView.bounds.origin.x , y: yPoint, width: inView.frame.width, height: 44)
        self.init(frame: rect)
        showsHorizontalScrollIndicator = false
        addScrollItems(items)
        intialiseFirstLook()
        intialiseBottomLayer()

    }
    private func intialiseBottomLayer() {
        bottomLayer.frame = CGRect(origin: CGPoint(x:0, y:height-2 ) , size: CGSize(width: contentSize.width, height: 2))
        bottomLayer.borderWidth = 2.0
        layer.addSublayer(bottomLayer)

    }
    private func scrollViewBottomLayerColor(color:UIColor) {
        bottomLayer.borderColor = color.CGColor
        bottomLayer.backgroundColor = color.CGColor
    }

    private func intialiseFirstLook() {
        topScrollBarButtons.first?.selected = true
        selectedButton = topScrollBarButtons.first ?? UIButton()
        self.backgroundColor = selectedButton.titleColorForState(.Normal)
        scrollViewBottomLayerColor(self.backgroundColor!)
    }

    private func addScrollItems(items:[TopScrollTabBarItem]) {
        // initialise the top scrollbar items
        var accumulatedWidth:CGFloat = 0.0

        for item in items {
            let button = createButtonForItem(item)
            let buttonWidth = button.frame.size.width
            accumulatedWidth += buttonWidth

            button.center = CGPoint(x:accumulatedWidth - buttonWidth/2, y: button.center.y)

            topScrollBarButtons.append(button)
            addSubview(button)
        }
        self.contentSize = CGSize(width: accumulatedWidth, height: height)
    }

    private func createButtonForItem(item:TopScrollTabBarItem) -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        button.setTitle(item.title, forState: .Normal)

        button.setTitleColor(item.color, forState: .Normal)
        button.backgroundColor = UIColor.whiteColor()
        button.setTitleColor(item.color.colorWithAlphaComponent(0.4) , forState: .Highlighted)

        button.sizeToFit()
        let buttonFrame = button.frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: buttonFrame.width + 2*buttonPadding, height: self.frame.size.height)
        button.addTarget(self, action: #selector(TopScrollTabBar.buttonTapped(_:)), forControlEvents: .TouchUpInside)

        return button
    }

    func buttonTapped(sender: UIButton) {
        focusOnButton(sender)
        selectedButton.selected = false
        selectedButton = sender
        for b in topScrollBarButtons {
            if b == selectedButton {
                selectedButton.selected = true
            } else {
                b.backgroundColor = UIColor.whiteColor()
            }
        }
    }

    private func focusOnButton(button:UIButton) {
        let leftSpace = button.frame.origin.x
        let rightSpace = self.contentSize.width - leftSpace
        let centerOfScreen = bounds.size.width/2
        let buttonWidth = button.frame.size.width
        var moveableDistance:CGPoint = CGPoint.zero
        let maxOffsetX = contentSize.width - frame.size.width

        if (leftSpace < centerOfScreen ) {
            print("leftspace = \(leftSpace)")
            if leftSpace != 0 {
                moveableDistance.x = leftSpace - buttonWidth/2
            }
        } else {
            let offsetAvailable = maxOffsetX - contentOffset.x
            if offsetAvailable > centerOfScreen || rightSpace - buttonWidth > centerOfScreen {
                let availableSpace = leftSpace - centerOfScreen + buttonWidth/2
                print("available space = \(availableSpace) withButton = \(availableSpace + buttonWidth)")
                moveableDistance.x = availableSpace
            } else {
                moveableDistance.x = maxOffsetX
            }
        }
        setContentOffset(moveableDistance,animated: true)
    }
}

struct TopScrollTabBarItem {
    var title:String
    var color:UIColor
}
