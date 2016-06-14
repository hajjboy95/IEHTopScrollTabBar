//
//  IEHTopScrollTabBar.swift
//  IEHTopScrollTabBar
//
//  Created by ismail el habbash on 14/06/2016.
//  Copyright © 2016 ismail el habbash. All rights reserved.
//

import UIKit

protocol IEHTopScrollTabBarDelegate: class {
    func scrollTabBarButtonPressed(sender:IEHTopScrollTabBar, buttonTapped:UIButton, atIndex index:Int)
}

class IEHTopScrollTabBar: UIScrollView {

    private let lineY:CGFloat = 39.0
    private let buttonPadding:CGFloat = 10.0
    private lazy var topScrollBarButtons = [UIButton]()
    private lazy var bottomLayer = CALayer()
    weak var iehDelegate:IEHTopScrollTabBarDelegate?

    private var selectedButton:UIButton = UIButton() {
        didSet {
            for i in 0..<topScrollBarButtons.count {
                if selectedButton == topScrollBarButtons[i] {
                    iehDelegate?.scrollTabBarButtonPressed(self,buttonTapped: selectedButton, atIndex: i)
                    break
                }
            }
            selectedButton.layer.cornerRadius = 6.0
            selectedButton.layer.masksToBounds = true
            selectedButton.backgroundColor = selectedButton.titleColorForState(.Normal)
            selectedButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
            selectedButton.backgroundColor = selectedButton.titleColorForState(.Normal)
            scrollViewBottomLayerColor(selectedButton.titleColorForState(.Normal)!)
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
        let rect = CGRect(x: inView.bounds.origin.x , y: yPoint, width: inView.frame.width, height: 40)
        self.init(frame: rect)
        showsHorizontalScrollIndicator = false
        addScrollItems(items)
        intialiseFirstLook()
        intialiseBottomLayer()
    }

    private func intialiseBottomLayer() {
        let bottomLayerOffSet: CGFloat = bounds.size.width
        bottomLayer.frame = CGRect(origin: CGPoint(x: -bottomLayerOffSet/2, y:lineY-3 ) , size: CGSize(width: contentSize.width + bottomLayerOffSet, height: 4))
        bottomLayer.borderWidth = 3.0
        layer.addSublayer(bottomLayer)
    }

    private func scrollViewBottomLayerColor(color:UIColor) {
        bottomLayer.borderColor = color.CGColor
        bottomLayer.backgroundColor = color.CGColor
    }

    private func intialiseFirstLook() {
        topScrollBarButtons.first?.selected = true
        selectedButton = topScrollBarButtons.first ?? UIButton()
        scrollViewBottomLayerColor(selectedButton.titleColorForState(.Normal)!)
    }

    private func addScrollItems(items:[TopScrollTabBarItem]) {
        var accumulatedWidth:CGFloat = 0.0

        for item in items {
            let button = createButtonForItem(item)
            let buttonWidth = button.frame.size.width
            accumulatedWidth += buttonWidth

            button.center = CGPoint(x:accumulatedWidth - buttonWidth/2, y: button.center.y)

            topScrollBarButtons.append(button)
            addSubview(button)
        }
        self.contentSize = CGSize(width: accumulatedWidth, height: lineY)
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
        button.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .TouchUpInside)

        return button
    }

    @objc private func buttonTapped(sender: UIButton) {
        focusOnButton(sender)
        selectedButton.selected = false
        selectedButton = sender
        for btn in topScrollBarButtons {
            if btn == selectedButton {
                selectedButton.selected = true
            } else {
                btn.backgroundColor = UIColor.whiteColor()
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
                moveableDistance.x = 0
        } else {
            let offsetAvailable = maxOffsetX - contentOffset.x
            if offsetAvailable > centerOfScreen || rightSpace - buttonWidth > centerOfScreen {
                let availableSpace = leftSpace - centerOfScreen + buttonWidth/2
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
