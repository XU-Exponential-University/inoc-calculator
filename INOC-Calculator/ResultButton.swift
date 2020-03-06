//
//  ResultButton.swift
//  INOC-Calculator
//
//  Created by FelixP on 29.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

@IBDesignable class ResultButton: UIButton {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        doStyling()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        doStyling()
    }
    
    func doStyling(){
        
        //adding a round corner shape to the buttons
        self.layer.cornerRadius = CGFloat(Double(self.bounds.size.width / 2))
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        
        self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Exo-Regular", size: 35)!)
    }

}
