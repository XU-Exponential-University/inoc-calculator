//
//  NumberPadButton.swift
//  INOC-Calculator
//
//  Created by FelixP on 21.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

public class NumberPadButton: MainScreenButton{
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func doStyling(){
        super.doStyling()

        //setting white color with alpha
        self.setTitleColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.56), for: .normal)
    }
}
