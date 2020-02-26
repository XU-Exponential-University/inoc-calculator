//
//  FunnyButton.swift
//  INOC-Calculator
//
//  Created by FelixP on 29.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

@IBDesignable class FunnyButton: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 10 {
        didSet {
            self.setupButton()
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 5 {
        didSet {
            self.setupButton()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.red {
        didSet {
            self.setupButton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
            
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
    }
    
    
}
