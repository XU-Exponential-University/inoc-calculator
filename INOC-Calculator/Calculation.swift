//
//  Calculation.swift
//  INOC-Calculator
//
//  Created by FelixP on 05.03.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//
//all of this code was written by the author of the file

import Foundation

//data model to hold the calculation items of the history

class Calculation{
    
    let calculationText: String
    let resultText: String
    
    init(calculation: String, result: String) {
        calculationText = calculation
        resultText = result
    }
}
