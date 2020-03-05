//
//  CalculationHistoryCell.swift
//  INOC-Calculator
//
//  Created by FelixP on 05.03.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

class CalculationHistoryCell: UITableViewCell {
    
    @IBOutlet weak var calculationText: UIButton!
    @IBOutlet weak var resultText: UIButton!
    
    
    func setText(calculation: Calculation){
        self.calculationText.setAttributedTitle(NSAttributedString(string: calculation.calculationText, attributes: calculationText.attributedTitle(for: .normal)?.attributes(at: 0, effectiveRange: nil)), for: .normal)
        self.resultText.setAttributedTitle(NSAttributedString(string: calculation.resultText, attributes: resultText.attributedTitle(for: .normal)?.attributes(at: 0, effectiveRange: nil)), for: .normal)
    }
}
