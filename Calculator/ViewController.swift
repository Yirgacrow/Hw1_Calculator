//
//  ViewController.swift
//  Calculator
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import UIKit
import CalculatorCore

class ViewController: UIViewController {

    var core: Core<Float>!
    func resetCore() {
        self.core = Core()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetCore()
    }
    
    var userIsEnteringNumbers = false
    var userInsertedADot = false
    
    @IBOutlet weak var displayLabel: DisplayLabel!

    @IBAction func numericButtonClicked(sender: UIButton) {
        if sender.tag >= 1000 && sender.tag < 1010 {
            self.displayLabel.append(sender.tag - 1000)
            userIsEnteringNumbers = true
        } else if sender.tag == 1010 {
            
            if self.displayLabel.text?.containsString(".") == true{
                userInsertedADot = true
            }
            
            if !userInsertedADot && userIsEnteringNumbers {
                displayLabel.text = displayLabel.text! + "."
                userInsertedADot = true
            }
            if !userInsertedADot && !userIsEnteringNumbers {
                displayLabel.text =  "0."
                userInsertedADot = true
                userIsEnteringNumbers = true
            }
        }
        else if sender.tag == 1011 {
            self.displayLabel.append(0)
            self.displayLabel.append(0)
        }
        print("operandStack = \(displayLabel)")
    }

    @IBAction func negativeButtonClicked(sender: UIButton) {
        self.displayLabel.changeSign()
    }
    
    @IBAction func percentButtonClicked(sender: UIButton) {
        self.displayLabel.percent()
    }

    @IBAction func operatorButtonClicked(sender: UIButton) {
        try! self.core.addStep(self.displayLabel.floatValue)

        switch (sender.titleForState(.Normal)!) {
        case "+":
            try! self.core.addStep(+)
        case "-":
            try! self.core.addStep(-)
        case "×":
            try! self.core.addStep(*)
        case "÷":
            try! self.core.addStep(/)
        default:
            break
        }
        self.displayLabel.clear()
        userIsEnteringNumbers = false
        userInsertedADot = false
    }

    @IBAction func calculateButtonClicked(sender: UIButton) {
        try! self.core.addStep(self.displayLabel.floatValue)
        self.displayLabel.floatValue = try! self.core.calculate()
        self.resetCore()
    }

    @IBAction func resetButtonClicked(sender: UIButton) {
        self.resetCore()
        self.displayLabel.clear()
        userIsEnteringNumbers = false
        userInsertedADot = false
    }
}
