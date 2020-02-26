//
//  ResultButton.swift
//  INOC-Calculator
//
//  Created by FelixP on 21.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

public class ResultButton: MainScreenButton{
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func doStyling(){
        super.doStyling()
        
        //adding a round corner shape to the buttons
        self.layer.cornerRadius = CGFloat(Double(self.bounds.size.width / 2))
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        
        //setting correct font
        self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Exo-Regular", size: (self.titleLabel?.font.pointSize)!)!)
    }
}
