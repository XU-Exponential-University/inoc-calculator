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
    
    //this is the result Button. Outlet needed for round corners
    @IBOutlet weak var resultButton: UIButton!
    
    //constraint of top area used to resize on drag
    @IBOutlet weak var topAreaBottomConstraint: NSLayoutConstraint!
    
    //default value of bottomContraint of top area
    var topAreaBottomContraintVal: CGFloat = 0.0
    //maximum amounts of points the top card can be dragged
    var maxDraggablePointsTopArea: CGFloat = 0.0
    
    
    /*
     Logic Variables
     */
    
    //expanding states of top area
    enum TopAreaState{
        case normal
        case expanded
    }
    
    var topAreaState: TopAreaState = .normal
    
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
        // Do any additional setup after loading the
        
        //rounding the bottom corners of the top card view
        topCardView.roundCorners(cornerRadius: 40)
        topCardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        //adding pan gesture recognizer to top area
        let topAreaDrag = UIPanGestureRecognizer(target: self, action: #selector(topAreaDragged(_:)))
        //disabling delays of recognition
        topAreaDrag.delaysTouchesBegan = false
        topAreaDrag.delaysTouchesEnded = false
        
        self.topCardView.addGestureRecognizer(topAreaDrag)
        
        //calculating the amount of points the constraint is able to have max
        print(view.frame.size.height)
        maxDraggablePointsTopArea = (CGFloat(view.frame.size.height) * 0.61 - (CGFloat(view.frame.size.height) * 0.2)) * -1
        
        print("max draggable points. \(maxDraggablePointsTopArea)")
        
        
    }
    
    @IBAction func topAreaDragged(_ panRecognizer: UIPanGestureRecognizer){
        let translation = panRecognizer.translation(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            //saving current value
            topAreaBottomContraintVal = topAreaBottomConstraint.constant
            
        case .changed:
            let newValue = self.topAreaBottomContraintVal - translation.y
            if newValue > maxDraggablePointsTopArea && newValue < 0 {
                self.topAreaBottomConstraint.constant = newValue
                self.view.layoutIfNeeded()
            }
            
        case .ended:
            switch topAreaState{
            case .normal:
                if self.topAreaBottomConstraint.constant < maxDraggablePointsTopArea / 2 {
                    changeTopCardViewHeihtWithAnimation(to: maxDraggablePointsTopArea)
                    topAreaState = .expanded
                } else {
                    changeTopCardViewHeihtWithAnimation(to: 0)
                }
                
            case .expanded:
                if self.topAreaBottomConstraint.constant > maxDraggablePointsTopArea / 2 {
                    changeTopCardViewHeihtWithAnimation(to: 0)
                    self.view.layoutIfNeeded()
                    topAreaState = .normal
                } else {
                    changeTopCardViewHeihtWithAnimation(to: maxDraggablePointsTopArea)
                }
            }
        
        default:
            break
        }
    }
    
    
    func changeTopCardViewHeihtWithAnimation(to: CGFloat){
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            self.topAreaBottomConstraint.constant = to
            self.view.layoutIfNeeded()
            }).startAnimation()
    }
}

extension UIView {
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
    
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
