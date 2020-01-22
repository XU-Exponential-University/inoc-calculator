//
//  File.swift
//  INOC-Calculator
//
//  Created by FelixP on 21.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

public class MainScreenButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        doStyling()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        doStyling()
    }
    
    func doStyling(){
        self.layer.cornerRadius = CGFloat(Double(self.bounds.size.width / 2))
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
}
