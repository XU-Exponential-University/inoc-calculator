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
    
    //this is the red side drawer used for further calculations
    @IBOutlet weak var sideDrawer: UIView!
    
    //this is the result Button. Outlet needed for round corners
    @IBOutlet weak var resultButton: UIButton!
    
    
    
    
    //constraint of top area used to resize on drag
    @IBOutlet weak var topAreaBottomConstraint: NSLayoutConstraint!
    
    //default value of bottomContraint of top area
    var topAreaBottomContraintVal: CGFloat = 0.0
    //maximum amounts of points the top card can be dragged
    var maxDraggablePointsTopArea: CGFloat = 0.0
    
    
    
    //constraint of side drawer used to resize
    @IBOutlet weak var sideDrawerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideDrawerLeadingConstraint: NSLayoutConstraint!
    
    //default value of bottomContraint of top area
    var sideDrawerTrailingConstraintVal: CGFloat = 0.0
    //maximum amounts of points the top card can be dragged
    var maxDraggablePointsSideDrawer: CGFloat = 0.0
    
    
    
    
    
    /*
     Logic Variables
     */
    
    //expanding states of top area
    enum DrawerState{
        case normal
        case expanded
    }
    
    //current state of the top area
    var topAreaState: DrawerState = .normal
    
    //current state of the top area
    var sideDrawerState: DrawerState = .normal
    
    var lastDigit = ""
    
    var lastNumber = ""
    
    var currentOperator = ""
    
    var currentNumber = ""
    
    var calculationString = ""
    
    var previousCalculation = ""
    
    var result = 0.0
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var decimalButton: UIButton!
    
    //    This clears all the calculation and resets every variable:
    @IBAction func clearButtonClicked(_ sender: Any) {
        
        clearText()
//        currentNumber = ""
        currentOperator = ""
        resultLabel.text = "0"
        calculationString = ""
        
        unblockOperatorButton()
        previousButton = UIButton()
    }
    
    @IBAction func toggleSignButtonClicked(_ sender: Any){
        resultLabel.text = String(Double(-1) * Double(lastDigit)!)
    }
    
    @IBAction func percentageButtonClicked(_ sender: UIButton){
        
        
    }
    
    @IBAction func numberZeroButtonClicked(_ sender: UIButton){
        if lastNumber != "0" {
            lastDigit = sender.currentTitle!
            
            lastNumber += lastDigit
            
            calculationString += lastDigit
            
            resultLabel.text = calculationString
        }
    }
    
    @IBAction func decimalButtonClicked(_ sender: UIButton){
        decimalButton.isEnabled = false
        if lastNumber == "" {
            lastNumber = "0."
            calculationString += lastNumber
            
        }
        else {
            lastDigit = sender.currentTitle!
            
            lastNumber += lastDigit
            calculationString += lastDigit
            
            unblockOperatorButton()
        }
        resultLabel.text = calculationString
    }
    
    //    4 operators are connected from the storyboard here: (multiply, devide, plus, minus)
    @IBAction func operatorClicked(_ sender: UIButton){
        print(lastNumber)
        print(currentOperator != "=")
        
        if calculationString.last! == "+" || calculationString.last! == "-" || calculationString.last! == "x" || calculationString.last! == "/"  {
            calculationString.removeLast()
            print("1. \(calculationString)")
        }
        else {
            if lastNumber.contains(".") == false && currentOperator != "=" {
                lastNumber += ".0"
                calculationString += ".0"
            } }
        currentOperator = "\(sender.currentTitle!)"
        calculationString += currentOperator
        print(calculationString)
        
        clearText()
        
        blockOperatorButton(block: sender)
        
        if previousButton != sender {
            unblockOperatorButton()
        }
        previousButton = sender
        
    }
    
    
    @IBAction func resultButtonClicked(_ sender: UIButton){
        //        calculationString += numberOnScreen
        if lastNumber.contains(".") == false {
            lastNumber += ".0"
            calculationString += ".0"
        }
        currentOperator = "="
        print(calculationString)
        calculationString = calculationString.replacingOccurrences(of: "x", with: "*")
        let y = NSExpression(format:calculationString)
        
        result = y.expressionValue(with: nil, context: nil) as! Double
        print(result)
        calculationString += currentOperator
        calculationString += "\(result)"
        resultLabel.text = calculationString
//        to store the calculation String for the History before it will be deleted:
        previousCalculation = calculationString
        calculationString = "\(result)"
        clearText()
        blockOperatorButton(block: sender)
        previousButton = sender
        unblockOperatorButton()
    }
    
    //    This function is connected to the buttons of number 1 to 9 from the storyboard:
    @IBAction func numberButtonClicked(_ sender: UIButton){
//        currentOpertor = "" so it does not add additional .0 twice in operator function, calculationString ="" to start a new calculation
        if currentOperator == "=" {
            calculationString = ""
            currentOperator = ""
        }
        lastDigit = sender.currentTitle!
        
        lastNumber += lastDigit
        
        calculationString += lastDigit
        
        resultLabel.text = calculationString
        unblockOperatorButton()
        print("last digit \(lastDigit) & \(lastNumber) calculation \(calculationString)")
    }
    
    
    //    This function clears the text on the Label and enables the decimal BUtton
    func clearText() {
        lastDigit = ""
        lastNumber = ""
        decimalButton.isEnabled = true
    }
    
    //    empty Button
    var previousButton = UIButton()
    //    This function should block operator from being executed twice unnessasarily:
    //    Maybe we should change the background color when its blocked..?
    func blockOperatorButton(block button: UIButton) {
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.2658390411)
    }
    func unblockOperatorButton() {
        previousButton.isEnabled = true
        previousButton.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //rounding the bottom corners of the top card view
        topCardView.roundCorners(cornerRadius: 40)
        topCardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        //rounding top right corner of the side drawer menu
        sideDrawer.roundCorners(cornerRadius: 40)
        sideDrawer.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        //adding pan gesture recognizer to top area
        let topAreaDrag = UIPanGestureRecognizer(target: self, action: #selector(topAreaDragged(_:)))
        //disabling delays of recognition
        topAreaDrag.delaysTouchesBegan = false
        topAreaDrag.delaysTouchesEnded = false
        
        //adding gestureRecognizer to top area
        self.topCardView.addGestureRecognizer(topAreaDrag)
        
        //adding screen edge pan gesture recognizer to side drawer
        let sideAreaScreenEdgeDrag = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(sideDrawerDragged(_:)))
        //disabling delays of recognition
        sideAreaScreenEdgeDrag.delaysTouchesBegan = false
        sideAreaScreenEdgeDrag.delaysTouchesEnded = false
        sideAreaScreenEdgeDrag.edges = .left
        
        //adding pan gesture recognizer to side drawer
        let sideAreaDrag = UIPanGestureRecognizer(target: self, action: #selector(sideDrawerDragged(_:)))
        //disabling delays of recognition
        sideAreaDrag.delaysTouchesBegan = false
        sideAreaDrag.delaysTouchesEnded = false
        
        //adding gestureRecognizer to main and side view
        self.view.addGestureRecognizer(sideAreaScreenEdgeDrag)
        self.sideDrawer.addGestureRecognizer(sideAreaDrag)
        
        
        //calculating the amount of points the constraint is able to have max
        maxDraggablePointsTopArea = (CGFloat(view.frame.size.height) * 0.61 - (CGFloat(view.frame.size.height) * 0.15)) * -1
        
        //calculating the amount of points the constraint is able to have max
        maxDraggablePointsSideDrawer = (CGFloat(view.frame.size.width) * 0.72) * -1
        
        //setting size of leading constraint for sideDrawer
        sideDrawerLeadingConstraint.constant = maxDraggablePointsSideDrawer
        
    }
    
    @IBAction func topAreaDragged(_ panRecognizer: UIPanGestureRecognizer){
        let translation = panRecognizer.translation(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            //saving current state of constraint
            topAreaBottomContraintVal = topAreaBottomConstraint.constant
            
        case .changed:
            let newValue = self.topAreaBottomContraintVal - translation.y
            if newValue > maxDraggablePointsTopArea && newValue < 0 {
                self.topAreaBottomConstraint.constant = newValue
                self.view.layoutIfNeeded()
                
                //fold sideDrawer back if expanded
                if sideDrawerState == .expanded{
                    sideDrawerToCollapsed()
                }
            }
            
        case .ended:
            switch topAreaState{
            case .normal:
                //top area is in the lower half
                if self.topAreaBottomConstraint.constant < maxDraggablePointsTopArea / 2 {
                    //velocity of drag is high enough for bounce
                    if panRecognizer.velocity(in: self.view).y > 1500{
                        topAreaToExpanded(withBounce: true)
                        //animate top area down without bounce, due to low velocity
                    }else {
                        topAreaToExpanded(withBounce: false)
                    }
                    //top area has not been dragged down far enough, animate back up
                } else {
                    topAreaToCollapsed()
                }
                
            case .expanded:
                //top area is in the top half when let go of drag
                if self.topAreaBottomConstraint.constant > maxDraggablePointsTopArea / 2 {
                    topAreaToCollapsed()
                    //top area is in lower half when let go of drag and gets back to expanded position
                } else {
                    topAreaToExpanded(withBounce: false)
                }
            }
            
        default:
            break
        }
    }
    
    //moving top area back in
    func topAreaToCollapsed(){
        changeConstraintWithAnimation(of: topAreaBottomConstraint, to: 0)
        topAreaState = .normal
    }
    
    //expanding top area with or without bounce animation
    func topAreaToExpanded(withBounce: Bool){
        if withBounce {
            changeConstraintValueWithBounce(of: topAreaBottomConstraint, to: maxDraggablePointsTopArea)
        }else{
            changeConstraintWithAnimation(of: topAreaBottomConstraint, to: maxDraggablePointsTopArea)
            
        }
        topAreaState = .expanded
    }
    
    
    @IBAction func sideDrawerDragged(_ panRecognizer: UIPanGestureRecognizer){
        let translation = panRecognizer.translation(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            //saving current value
            sideDrawerTrailingConstraintVal = sideDrawerTrailingConstraint.constant
            
        case .changed:
            let newValue = self.sideDrawerTrailingConstraintVal - translation.x
            if newValue > maxDraggablePointsSideDrawer && newValue < 0 {
                self.sideDrawerTrailingConstraint.constant = newValue
                self.sideDrawerLeadingConstraint.constant = maxDraggablePointsSideDrawer + -1 * newValue
                self.view.layoutIfNeeded()
                
                //fold topArea back if extended
                if topAreaState == .expanded{
                    topAreaToCollapsed()
                }
            }
            
        case .ended:
            switch topAreaState{
            case .normal:
                //is the side area let go of whilst being in the right half of screen?
                if self.sideDrawerTrailingConstraint.constant < maxDraggablePointsSideDrawer / 2 {
                    //is the velocity of the drag gesture high enough for bounce animation?
                    if panRecognizer.velocity(in: self.view).x > 1000{
                        sideDrawerToExpanded(withBounce: true)
                        //if not, just animate the side area into the expanded position without bounce
                    }else {
                        sideDrawerToExpanded(withBounce: false)
                    }
                    //side area is not let go of in the right half, so just animate it back up
                } else {
                    sideDrawerToCollapsed()
                }
                
            case .expanded:
                //is swiped back far enough to animate side area back to collapsed state
                if self.sideDrawerTrailingConstraint.constant > maxDraggablePointsSideDrawer / 2 {
                    sideDrawerToCollapsed()
                    //drag is not far enough, so animate side area back out
                } else {
                    sideDrawerToExpanded(withBounce: false)
                }
            }
            
        default:
            break
        }
    }
    
    //animates the top area to its collapsed state
    func sideDrawerToCollapsed(){
        changeConstraintWithAnimation(of: sideDrawerTrailingConstraint, to: 0)
        changeConstraintWithAnimation(of: sideDrawerLeadingConstraint, to: maxDraggablePointsSideDrawer)
        sideDrawerState = .normal
    }
    
    //expands the top area eventually with a bounce
    func sideDrawerToExpanded(withBounce: Bool){
        if withBounce{
            self.sideDrawerLeadingConstraint.constant = 0
            self.view.layoutIfNeeded()
            changeConstraintValueWithBounce(of: sideDrawerTrailingConstraint, to: maxDraggablePointsSideDrawer)
        }else{
            changeConstraintWithAnimation(of: sideDrawerTrailingConstraint, to: maxDraggablePointsSideDrawer)
            changeConstraintWithAnimation(of: sideDrawerLeadingConstraint, to: 0)
        }
        sideDrawerState = .expanded
    }
    
    
    func changeConstraintWithAnimation(of: NSLayoutConstraint, to: CGFloat){
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            of.constant = to
            self.view.layoutIfNeeded()
        }).startAnimation()
    }
    
    func changeConstraintValueWithBounce(of: NSLayoutConstraint, to: CGFloat){
        UIView.animate(withDuration: 0.4, //1
            delay: 0.0, //2
            usingSpringWithDamping: 0.3, //3
            initialSpringVelocity: 1, //4
            options: UIView.AnimationOptions.curveEaseInOut, //5
            animations: ({ //6
                of.constant = to
                self.view.layoutIfNeeded()
            }), completion: nil)
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
