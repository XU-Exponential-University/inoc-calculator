//
//  SideDrawerButton.swift
//  INOC-Calculator
//
//  Created by FelixP on 29.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//
//all of this code was written by the author of the file

import UIKit

@IBDesignable class SideDrawerButton: UIButton {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        doStyling()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        doStyling()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        doStyling()
    }
    
    func doStyling(){

        //setting white color with alpha
        self.setTitleColor(UIColor(red: 32/255.0, green: 28/255.0, blue: 26/255.0, alpha: 1.0), for: .normal)
        
        self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Exo-Medium", size: 22.0 * CGFloat(UIScreen.main.bounds.width / 414.0))!)
    }

}
