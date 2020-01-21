//
//  ViewController.swift
//  INOC-Calculator
//
//  Created by FelixP on 15.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     UI Variables
     */
    
    //this is the red top card in the UI
    @IBOutlet weak var topCardView: UIView!
    
    
    var numberOnScreen = ""
    
    var currentOperator = ""
    
    var currentNumber = ""
    
    var calculationString = ""
    
    var result = 0.0
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var decimalButton: UIButton!
    
    //    This clears all the calculation and resets every variable:
    @IBAction func clearButtonClicked(_ sender: Any) {
        
        clearText()
        currentNumber = ""
        currentOperator = ""
        resultLabel.text = "0"
        calculationString = ""
        
        unblockOperatorButton()
        previousButton = UIButton()
    }
    
    @IBAction func toggleSignButtonClicked(_ sender: Any){
        resultLabel.text = String(Double(-1) * Double(numberOnScreen)!)
    }
    
    @IBAction func percentageButtonClicked(_ sender: UIButton){
        
        
    }
    
    @IBAction func numberZeroButtonClicked(_ sender: UIButton){
        if resultLabel.text != "0" {
            numberOnScreen += sender.currentTitle!
            
            resultLabel.text = numberOnScreen
        }
    }
    
    @IBAction func decimalButtonClicked(_ sender: UIButton){
        decimalButton.isEnabled = false
        if numberOnScreen == "" {
            numberOnScreen = "0."
            resultLabel.text = numberOnScreen
        }
        else {
            numberOnScreen += sender.currentTitle!
            
            resultLabel.text = numberOnScreen
            unblockOperatorButton()
        }
    }
    
    //    4 operators are connected from the storyboard here: (multiply, devide, plus, minus)
    @IBAction func operatorClicked(_ sender: UIButton){
        
        if numberOnScreen.contains(".") == false && currentOperator != "=" {
            numberOnScreen += ".0"
        }
        currentOperator = " \(sender.currentTitle!) "
        calculationString += numberOnScreen + currentOperator
        print(calculationString)
       
        clearText()
        
        blockOperatorButton(block: sender)
        
        if previousButton != UIButton() {
            unblockOperatorButton()
        }
        previousButton = sender
    }
    

    @IBAction func resultButtonClicked(_ sender: UIButton){
        calculationString += numberOnScreen
        currentOperator = "="
        print(calculationString)
        calculationString = calculationString.replacingOccurrences(of: "x", with: "*")
        let y = NSExpression(format:calculationString)
        
        result = y.expressionValue(with: nil, context: nil) as! Double
        print(result)
        resultLabel.text = "\(result)"
        calculationString = "\(result)"
        clearText()
        unblockOperatorButton()
    }
    
    //    This function is connected to the buttons of number 1 to 9 from the storyboard:
    @IBAction func numberButtonClicked(_ sender: UIButton){
        if currentOperator == "=" {
            calculationString = ""
        }
        numberOnScreen += sender.currentTitle!
        
        resultLabel.text = numberOnScreen
        unblockOperatorButton()
    }
    
    //    This function clears the text on the Label and enables the decimal BUtton
    func clearText() {
        numberOnScreen = ""
        decimalButton.isEnabled = true
    }
    
    //    empty Button
    var previousButton = UIButton()
    //    This function should block operator from being executed twice unnessasarily:
    //    Maybe we should change the background color when its blocked..?
    func blockOperatorButton(block button: UIButton) {
        button.isEnabled = false
    }
    func unblockOperatorButton() {
        previousButton.isEnabled = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //rounding the bottom corners of the top card view
        topCardView.layer.cornerRadius = CGFloat(40)
        topCardView.clipsToBounds = true
        topCardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    
}

