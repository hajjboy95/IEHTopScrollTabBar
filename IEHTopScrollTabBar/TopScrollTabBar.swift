//
//  TopScrollTabBar.swift
//  IEHTopScrollTabBar
//
//  Created by ismail el habbash on 14/06/2016.
//  Copyright © 2016 ismail el habbash. All rights reserved.
//

import UIKit

class TopScrollTabBar: UIScrollView {

    let height:CGFloat = 44.0
    let buttonPadding:CGFloat = 10.0
    private var selectedButton:UIButton = UIButton() {
        didSet {
            selectedButton.backgroundColor = selectedButton.titleColorForState(.Normal)
            selectedButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
            selectedButton.backgroundColor = selectedButton.titleColorForState(.Normal)
            self.backgroundColor = selectedButton.titleColorForState(.Normal)
        }
    }

    private lazy var topScrollBarButtons = [UIButton]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        showsHorizontalScrollIndicator = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(inView:UIView, items:[TopScrollTabBarItem]) {
        let yPoint = UIApplication.sharedApplication().statusBarFrame.height
        let rect = CGRect(x: inView.bounds.origin.x , y: yPoint, width: inView.frame.width, height: 44)
        self.init(frame: rect)

        addScrollItems(items)
        intialiseFirstLook()
    }

    private func intialiseFirstLook() {
        showsHorizontalScrollIndicator = false

        topScrollBarButtons.first?.selected = true
        selectedButton = topScrollBarButtons.first ?? UIButton()
        self.backgroundColor = selectedButton.titleColorForState(.Normal)
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
        let buttonXpos  = button.frame.origin.x
        var moveableDistance:CGPoint = CGPoint.zero
        let maxOffsetX = contentSize.width - frame.size.width

        if (leftSpace < centerOfScreen) {
            // empty
            print("empty buttonWIdth \(buttonWidth)")
            if leftSpace != 0 {
                moveableDistance.x = leftSpace - buttonWidth/2
            }

        }
        else if (leftSpace < contentSize.width/2 && leftSpace > centerOfScreen) {
            let availableSpace = leftSpace - centerOfScreen
            print("left:availableSpace = \(availableSpace)")
            moveableDistance.x = availableSpace + buttonWidth/2
            // for the right most buttons
        } else {//if (rightSpace < centerOfScreen) {
            //checks to see if user is able to scroll - if his able then scroll
            
            if contentOffset.x < maxOffsetX {

                moveableDistance.x = maxOffsetX
            } else {
                moveableDistance.x = maxOffsetX
            }
        }
             print("moveableDistance = \(moveableDistance)")
        setContentOffset(moveableDistance,animated: true)
    }
}

class TopScrollTabBarItem {
    var title:String
    var color:UIColor

    init(title:String, color:UIColor) {
        self.title = title
        self.color = color
    }
}

//extension UIImage {
//    class func imageWithColor(color: UIColor) -> UIImage {
//        let rect: CGRect = CGRectMake(0.0, 0.0, 1.0, 1.0)
//        UIGraphicsBeginImageContext(rect.size)
//        let context: CGContextRef = UIGraphicsGetCurrentContext()!
//        CGContextSetFillColorWithColor(context, color.CGColor)
//        CGContextFillRect(context, rect)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return image
//    }
//}
