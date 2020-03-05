//
//  CalculationHistoryCell.swift
//  INOC-Calculator
//
//  Created by FelixP on 05.03.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

class CalculationHistoryCell: UITableViewCell {

    @IBOutlet weak var calculationLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    func setText(calculation: Calculation){
        print("setText")
        calculationLabel.text = calculation.calculationText
        resultLabel.text = calculation.resultText
        
    }
}
