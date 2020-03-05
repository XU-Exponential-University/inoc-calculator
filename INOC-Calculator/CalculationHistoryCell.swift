//
//  CalculationHistoryCell.swift
//  INOC-Calculator
//
//  Created by FelixP on 05.03.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//
//all of this code was written by the author of the file

import UIKit

class CalculationHistoryCell: UITableViewCell {
    
    @IBOutlet weak var calculationText: UIButton!
    @IBOutlet weak var resultText: UIButton!
    
    
    func setText(calculation: Calculation){
        //replacing the attributed title whilst keeping attributes
        //i know this looks very broken, but for now there is no alternative
        self.calculationText.setAttributedTitle(NSAttributedString(string: calculation.calculationText, attributes: calculationText.attributedTitle(for: .normal)?.attributes(at: 0, effectiveRange: nil)), for: .normal)
        self.resultText.setAttributedTitle(NSAttributedString(string: calculation.resultText, attributes: resultText.attributedTitle(for: .normal)?.attributes(at: 0, effectiveRange: nil)), for: .normal)
    }
}
