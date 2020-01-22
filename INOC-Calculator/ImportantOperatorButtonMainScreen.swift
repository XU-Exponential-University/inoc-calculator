//
//  ImportantOperatorMainScreen.swift
//  INOC-Calculator
//
//  Created by FelixP on 22.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

public class ImportantOperatorButtonMainScreen: MainScreenButton{
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func doStyling(){
        super.doStyling()

        //setting primary color
        self.setTitleColor(UIColor(red: 246/255.0, green: 78/255.0, blue: 78/255.0, alpha: 1.0), for: .normal)
        
        //setting correct font
        self.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Exo", size: 35)!)
    }
}
