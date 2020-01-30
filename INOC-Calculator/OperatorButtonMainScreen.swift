//
//  OperatorButtonMainScreen.swift
//  INOC-Calculator
//
//  Created by FelixP on 22.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

@IBDesignable class OperatorButtonMainScreen: UIButton{
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
        self.setTitleColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0), for: .normal)
        
        self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Exo-ExtraLight", size: 31.0 * CGFloat(UIScreen.main.bounds.width / 414.0))!)
    }
}
