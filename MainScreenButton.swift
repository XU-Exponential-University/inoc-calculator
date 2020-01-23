//
//  MainScreenButton.swift
//  INOC-Calculator
//
//  Created by FelixP on 21.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

public class MainScreenButton: UIButton{
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        doStyling()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        doStyling()
    }
    
    func doStyling(){
        //adds the custom font to all buttons
        self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Exo-ExtraLight", size: 35)!)
    }
}
