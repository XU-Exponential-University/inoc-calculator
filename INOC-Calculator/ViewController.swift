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
        
        self.view.addGestureRecognizer(sideAreaScreenEdgeDrag)
        self.sideDrawer.addGestureRecognizer(sideAreaDrag)

        
        //calculating the amount of points the constraint is able to have max
        maxDraggablePointsTopArea = (CGFloat(view.frame.size.height) * 0.61 - (CGFloat(view.frame.size.height) * 0.15)) * -1
        
        //calculating the amount of points the constraint is able to have max
        maxDraggablePointsSideDrawer = (CGFloat(view.frame.size.width) * 0.7) * -1
        
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
                    if panRecognizer.velocity(in: self.view).y > 1500{
                        changeTopCardViewHeightWithBunce(to: maxDraggablePointsTopArea)
                    }else {
                        changeTopCardViewHeightWithAnimation(to: maxDraggablePointsTopArea)
                        topAreaState = .expanded
                    }
                } else {
                    changeTopCardViewHeightWithAnimation(to: 0)
                }
                
            case .expanded:
                if self.topAreaBottomConstraint.constant > maxDraggablePointsTopArea / 2 {
                    changeTopCardViewHeightWithAnimation(to: 0)
                    self.view.layoutIfNeeded()
                    topAreaState = .normal
                } else {
                    changeTopCardViewHeightWithAnimation(to: maxDraggablePointsTopArea)
                }
            }
            
        default:
            break
        }
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
                self.view.layoutIfNeeded()
            }
            
        case .ended:
            switch topAreaState{
            case .normal:
                if self.sideDrawerTrailingConstraint.constant < maxDraggablePointsSideDrawer / 2 {
                    if panRecognizer.velocity(in: self.view).x > 1500{
                        changeSideDrawerWidthWithBunce(to: maxDraggablePointsSideDrawer)
                    }else {
                        changesideDrawerWidthWithAnimation(to: maxDraggablePointsSideDrawer)
                        sideDrawerState = .expanded
                    }
                } else {
                    changesideDrawerWidthWithAnimation(to: 0)
                }
                
            case .expanded:
                if self.sideDrawerTrailingConstraint.constant > maxDraggablePointsSideDrawer / 2 {
                    changeTopCardViewHeightWithAnimation(to: 0)
                    self.view.layoutIfNeeded()
                    sideDrawerState = .normal
                } else {
                    changesideDrawerWidthWithAnimation(to: maxDraggablePointsSideDrawer)
                }
            }
            
        default:
            break
        }
    }
    
    
    func changeTopCardViewHeightWithAnimation(to: CGFloat){
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            self.topAreaBottomConstraint.constant = to
            self.view.layoutIfNeeded()
        }).startAnimation()
    }
    
    func changesideDrawerWidthWithAnimation(to: CGFloat){
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            self.sideDrawerTrailingConstraint.constant = to
            self.view.layoutIfNeeded()
        }).startAnimation()
    }
    
    
    
    
    func changeTopCardViewHeightWithBunce(to: CGFloat){
        UIView.animate(withDuration: 0.6, //1
            delay: 0.0, //2
            usingSpringWithDamping: 0.3, //3
            initialSpringVelocity: 1, //4
            options: UIView.AnimationOptions.curveEaseInOut, //5
            animations: ({ //6
                self.topAreaBottomConstraint.constant = to
                self.view.layoutIfNeeded()
            }), completion: nil)
    }
    
    func changeSideDrawerWidthWithBunce(to: CGFloat){
        UIView.animate(withDuration: 0.6, //1
            delay: 0.0, //2
            usingSpringWithDamping: 0.3, //3
            initialSpringVelocity: 1, //4
            options: UIView.AnimationOptions.curveEaseInOut, //5
            animations: ({ //6
                self.sideDrawerTrailingConstraint.constant = to
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
