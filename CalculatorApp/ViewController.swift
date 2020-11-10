//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Магжан Имангазин on 9/13/20.
//  Copyright © 2020 Магжан Имангазин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myDisplay: UILabel!
    
    @IBOutlet weak var cosButton: UIButton!
    @IBOutlet weak var tanButton: UIButton!
    @IBOutlet weak var tanhButton: UIButton!
    @IBOutlet weak var sinhButton: UIButton!
    @IBOutlet weak var coshButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var lnButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var sinButton: UIButton!
    
    var typing: Bool = false
    var dotPress: Bool = false
    
    @IBAction func digitPressed(_ sender: UIButton) {
        let currentDigit = sender.currentTitle!
        if typing {
            let currentDisplay = myDisplay.text!
            myDisplay.text = currentDisplay + currentDigit
        } else {
            myDisplay.text = currentDigit
            typing = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(myDisplay.text!)!
        } set {
            myDisplay.text = String(newValue)
        }
    }
    
    private var calculatorModel = CalculatorModel()
    
    @IBAction func changeButton(_ sender: UIButton) {
        if sender.tag == 1 {
            sinButton.titleLabel!.text = "sin^-1"
            sinhButton.titleLabel!.text = "sinh^-1"
            cosButton.titleLabel!.text = "cos^-1"
            coshButton.titleLabel!.text = "cosh^-1"
            tanButton.titleLabel!.text = "tan^-1"
            tanhButton.titleLabel!.text = "tanh^-1"
            eButton.titleLabel!.text = "y^x"
            lnButton.titleLabel!.text = "logy"
            tenButton.titleLabel!.text = "2^x"
            logButton.titleLabel!.text = "log2"
        } else {
            sender.titleLabel!.text = "Deg"
        }
    }
    
    @IBAction func dotPressed() {
        if typing && !dotPress {
            myDisplay.text = myDisplay.text! + "."
            dotPress = true
        } else if !typing && !dotPress {
            myDisplay.text = "0."
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        calculatorModel.setOperand(displayValue)
        calculatorModel.performOperation(sender.currentTitle!)
        displayValue = calculatorModel.result!
        typing = false
        dotPress = false
    }
    
}

