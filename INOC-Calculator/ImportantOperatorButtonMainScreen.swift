//
//  ImportantOperatorMainScreen.swift
//  INOC-Calculator
//
//  Created by FelixP on 22.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//
//all of this code was written by the author of the file

import UIKit

@IBDesignable public class ImportantOperatorButtonMainScreen: UIButton{
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

        //setting primary color
        self.setTitleColor(UIColor(red: 246/255.0, green: 78/255.0, blue: 78/255.0, alpha: 1.0), for: .normal)
        
        self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Exo-Regular", size: 31.0 * CGFloat(UIScreen.main.bounds.width / 414.0))!)
    }
}
