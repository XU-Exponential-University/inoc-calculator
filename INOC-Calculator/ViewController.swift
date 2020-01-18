//
//  ViewController.swift
//  INOC-Calculator
//
//  Created by FelixP on 15.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    This array was not used in caculation, just for viewing in the console:
    var numbersArray = [Double]()
    
    var currentStateOfCalculation = 0.0
    
    var numberOnScreen = ""
    
    var previousNumber = ""
    
//    var newNumber = ""
    
    var calculation = [String]()
    
    var currentOperator = ""
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var decimalButton: UIButton!
    
    //    This clears all the calculation and resets every variable:
    @IBAction func clearButtonClicked(_ sender: Any) {
        
        clearText()
        numbersArray = [Double]()
        currentStateOfCalculation = 0.0
        previousNumber = ""
//        newNumber = ""
        calculation = [String]()
        currentOperator = ""
        resultLabel.text = "0"
        
        unblockOperatorButton(unblock: previousButton)
        previousButton = UIButton()
    }
    
    @IBAction func toggleSignButtonClicked(_ sender: Any){
        resultLabel.text = String(Double(-1) * Double(numberOnScreen)!)
    }
    
    @IBAction func percentageButtonClicked(_ sender: UIButton){
        // if the result label is emppty(when we haven't typed a number), it should have the value of 0:
        if numberOnScreen == "" {
            numberOnScreen = "0"
        }
        //  converting the String to a double:
        let convertedNumber = Double(numberOnScreen)!
//        if there is no operator involved and % is clicked, the number will be just devided by 100, else the number will be calculated as percentage from the previous number:
        if currentOperator == "" || currentOperator == "=" {
            if currentOperator == "" {
                currentStateOfCalculation = convertedNumber
            }
            currentStateOfCalculation = currentStateOfCalculation / 100
            numberOnScreen = String(currentStateOfCalculation)
        } else {
            let percentage = currentStateOfCalculation * convertedNumber / 100
            numberOnScreen =  String(percentage)
        }
        resultLabel.text = numberOnScreen
        
    }
    
    @IBAction func numberZeroButtonClicked(_ sender: UIButton){
        if resultLabel.text != "0" {
            getNumber(of: sender)
        }
    }
    
    @IBAction func decimalButtonClicked(_ sender: UIButton){
        decimalButton.isEnabled = false
        if numberOnScreen == "" {
            numberOnScreen = "0."
            resultLabel.text = numberOnScreen
        }
        else {
            getNumber(of: sender)
            unblockOperatorButton(unblock: previousButton)
        }
    }
    
//    4 operators are connected from the storyboard here: (multiply, devide, plus, minus)
    @IBAction func operatorClicked(_ sender: UIButton){
        calculationWithOperators(of: sender.currentTitle!)
        
        blockOperatorButton(block: sender)
        
        if previousButton != UIButton() {
            unblockOperatorButton(unblock: previousButton)
        }
        previousButton = sender
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton){
        calculationWithOperators(of: sender.currentTitle!)
        //        numberOnScreen = String(format: "%.1f", currentStateOfCalculation)
        //        currentOperator = ""
        unblockOperatorButton(unblock: previousButton)
        previousButton = UIButton()
    }
    
    //    This function is connected to the buttons of number 1 to 9 from the storyboard:
    @IBAction func numberButtonClicked(_ sender: UIButton){
        getNumber(of: sender)
        unblockOperatorButton(unblock: previousButton)
    }
//    This takes the string(title) of the button and put it in the result label
    func getNumber(of button: UIButton) {
        numberOnScreen += button.currentTitle!
        
        resultLabel.text = numberOnScreen
        
    }
    
    //    This function clears the text on the Label and enables the decimal BUtton
    func clearText() {
        numberOnScreen = ""
        decimalButton.isEnabled = true
    }
    
    //    operations are not performed when clicked, but stored to be operated after the next number is clicked, and the next operator is clicked
    func calculationWithOperators(of buttonTitle: String){
        print("numberonscreen before \(numberOnScreen)")
        
        if numberOnScreen == "" { numberOnScreen = "0" }
        let convertedNumber = Double(numberOnScreen)!
        numbersArray.append(convertedNumber)
        print(numbersArray)
        print("c: \(currentOperator)")
        print("numberonscreen \(numberOnScreen)")
        
        switch currentOperator {
        case "+":
            currentStateOfCalculation += convertedNumber
            currentOperator = buttonTitle
            print("real \(currentOperator)")
        case "-":
            currentOperator = buttonTitle
            currentStateOfCalculation -= convertedNumber
            
        case "x":
            currentStateOfCalculation *= convertedNumber
            print("real \(currentOperator)")
            currentOperator = buttonTitle
            
        case "/":
            if currentStateOfCalculation == 0.0 && numbersArray.count == 1 {
                currentStateOfCalculation = convertedNumber
            } else {
                currentStateOfCalculation /= convertedNumber }
            currentOperator = buttonTitle
        case "":
            currentStateOfCalculation = convertedNumber
            currentOperator = buttonTitle
            
        case "=":
            currentOperator = buttonTitle
        default:
            print("error calculation")
        }
//        print("current \(currentStateOfCalculation)")
        resultLabel.text = String(currentStateOfCalculation)
        //        fix , after clicking x and then + numberonscreen = ""
        clearText()
        
    }
    //    empty Button
    var previousButton = UIButton()
    //    This function should block operator from being executed twice unnessasarily:
    //    Maybe we should change the background color when its blocked..?
    func blockOperatorButton(block button: UIButton) {
        button.isEnabled = false
    }
    func unblockOperatorButton(unblock button: UIButton) {
        previousButton.isEnabled = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //This is another test comment to show anita how branches work
        //this is another another comment :D
    }
    
    
}

