//
//  ViewController.swift
//  INOC-Calculator
//
//  Created by FelixP on 15.01.20.
//  Copyright © 2020 XU Exponential University. All rights reserved.
//

import UIKit
import Foundation

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
//    last digit that was pressed
    var lastDigit = ""
//   last number (which later piles up from the digits)
    var lastNumber = ""
//    the last operstor that was clicked
    var currentOperator = ""
    
    var calculationString = ""
    
    var previousCalculation = ""
    
    var result = 0.0
//    the number that should be toggled with positive or negative sign
    var toggledNumber = ""
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var decimalButton: UIButton!
    
    //    This clears all the calculation and resets every variable:
    @IBAction func clearButtonClicked(_ sender: Any) {
        
        clearText()

        currentOperator = ""
        resultLabel.text = "0"
        calculationString = ""
        
    }
    
    @IBAction func toggleSignButtonClicked(_ sender: Any){
//        the function should not execute if there is no number (when first open the app or after clearing)
        if lastNumber != "" || calculationString != "" {
            if lastNumber == "" {
            lastNumber = calculationString
        }
            removeLastNumber()
//            change the sign of the number and put it back
            toggledNumber = String(Double(-1) * Double(lastNumber)!)
            lastNumber = toggledNumber
            calculationString += lastNumber
            resultLabel.text = calculationString
        
        }
    }
    
    func removeLastNumber() {
//          check the length of the last number
         let stringLength = lastNumber.count
        //            remove the last number
                    for _ in 1...stringLength {
                        calculationString.removeLast()
                    }
    }
    
    @IBAction func percentageButtonClicked(_ sender: UIButton){

        if calculationString != "" {
            if currentOperator != "" || currentOperator != "="  {
                convertToDouble()
            resultLabel.text = calculationString + "%"
                removeLastNumber()
                calculationString.removeLast()
                    calculationString = calculationString.replacingOccurrences(of: "x", with: "*")
                
                        let y = NSExpression(format:calculationString)
                        result = y.expressionValue(with: nil, context: nil) as! Double
                        result = result.rounded(toPlaces: 5)
                
                 let percentage = result * Double(lastNumber)! / 100
                
                
                 calculationString += currentOperator
                calculationString += String(percentage)
                print("S \(calculationString)")
                 currentOperator = "%"
             }
    }
    }
    
    @IBAction func numberZeroButtonClicked(_ sender: UIButton){
        if currentOperator == "=" {
            calculationString = ""
            currentOperator = ""
        }
//      the function will add a 0 only if the number is not already 0:
        if lastNumber != "0" {
            getLastDigitAndNumber(button: sender)
            
            resultLabel.text = calculationString
        }
    }
    
    @IBAction func decimalButtonClicked(_ sender: UIButton){
        //        preventing the button from being pressed twice in a number
        if lastNumber.contains(".") == false && currentOperator != "=" {
            
            if lastNumber == "" {
                lastNumber = "0."
                calculationString += lastNumber
            }
            else {
                getLastDigitAndNumber(button: sender)
            }
            resultLabel.text = calculationString
        }
    }
    //    4 operators are connected from the storyboard here: (multiply, devide, plus, minus)
    @IBAction func operatorClicked(_ sender: UIButton){
        print(lastNumber)
        if calculationString != ""  {
            if calculationString.last! == "+" || calculationString.last! == "-" || calculationString.last! == "x" || calculationString.last! == "/"  {
                calculationString.removeLast()
            }
            else if currentOperator != "=" {
               convertToDouble()
            }
            currentOperator = "\(sender.currentTitle!)"
            calculationString += currentOperator
            print(calculationString)
            resultLabel.text = calculationString
            
            clearText()
            
        }
    }
    func convertToDouble() {

        removeLastNumber()
        let convertedNumber = Double(lastNumber)!
        lastNumber = String(convertedNumber)
        calculationString += lastNumber
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton){
//        prevent crashing if there is no number after an operator
       
        if lastNumber == "" {
            resultLabel.text = "Error"
            clearText()
            calculationString = ""
        }
        else if currentOperator != "=" {
       if currentOperator != "%" { convertToDouble() }
        currentOperator = "="
        
//            replacing x to * so it can calculate
        calculationString = calculationString.replacingOccurrences(of: "x", with: "*")
//            change the calculation String to an expression that can be calculated
        let y = NSExpression(format:calculationString)
        result = y.expressionValue(with: nil, context: nil) as! Double
        print(result)
        result = result.rounded(toPlaces: 5)
        calculationString += currentOperator
        calculationString += "\(result)"
        resultLabel.text = calculationString
//        to store the calculation String for the History before it will be deleted:
        previousCalculation = calculationString
//            After calculation there should only be the result in the string
        calculationString = "\(result)"
        clearText()

    }
    }
    
    //    This function is connected to the buttons of number 1 to 9 from the storyboard:
    @IBAction func numberButtonClicked(_ sender: UIButton){
//        after previous calculation if there was no operator clicked, then when clicking a number
        if currentOperator == "=" {
//            to start a new calculation
            calculationString = ""
//            so it does not add additional .0 twice in operator function,
            currentOperator = ""
        }
        getLastDigitAndNumber(button: sender)
        
        resultLabel.text = calculationString

    }
    func getLastDigitAndNumber(button: UIButton) {
        lastDigit = button.currentTitle!
        lastNumber += lastDigit
        calculationString += lastDigit
    }
    
    //    This function clears the text on the Label and enables the decimal BUtton
    func clearText() {
        lastDigit = ""
        lastNumber = ""
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
extension Double {
       func rounded(toPlaces places:Int) -> Double {
           let divisor = pow(10.0, Double(places))
           return (self * divisor).rounded() / divisor
       }
   }
