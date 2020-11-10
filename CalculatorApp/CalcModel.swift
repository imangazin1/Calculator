//
//  CalcModel.swift
//  CalculatorApp
//
//  Created by Магжан Имангазин on 9/13/20.
//  Copyright © 2020 Магжан Имангазин. All rights reserved.
//

import Foundation

enum Operation {
    case constant(Double)
    case unaryOperation((Double) -> Double)
    case binaryOperation((Double, Double) -> Double)
    case equals
}

func factorial(op1: Double) -> Double {
    let n = op1
    if n == 1 {
        return 1
    } else {
        return n * factorial(op1: n - 1)
    }
}

struct CalculatorModel {
    var myOperation : Dictionary<String, Operation> =
    [
        "+": Operation.binaryOperation({$0 + $1}),
        "-": Operation.binaryOperation({$0 - $1}),
        "×": Operation.binaryOperation({$0 * $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "=": Operation.equals,
        "AC": Operation.constant(0),
        "+/-": Operation.unaryOperation({-$0}),
        "%": Operation.unaryOperation({$0 / 100.0}),
        
        //"(": Operation
        //")": Operation
        //"mc": Operation
        //"m+": Operation
        //"m-": Operation
        "mr": Operation.constant(0),
        
        "x^​2": Operation.unaryOperation({pow($0, 2)}),
        "x^3": Operation.unaryOperation({pow($0, 3)}),
        "x^y": Operation.binaryOperation({pow($0, $1)}),
        "e^x": Operation.unaryOperation({pow(M_E, $0)}),
        "10^x": Operation.unaryOperation({pow(10, $0)}),
        
        "1/x": Operation.unaryOperation({1 / $0}),
        "√": Operation.unaryOperation(sqrt),
        "∛": Operation.unaryOperation({pow($0, 1 / 3)}),
        "y/x": Operation.binaryOperation({pow($0, 1 / $1)}),
        "ln": Operation.unaryOperation({log($0)}),
        "log10": Operation.unaryOperation({log10($0)}),
        
        "x!": Operation.unaryOperation({factorial(op1: $0)}),
        "sin": Operation.unaryOperation({sin($0 * Double.pi / 180)}),
        "cos": Operation.unaryOperation({cos($0 * Double.pi / 180)}),
        "tan": Operation.unaryOperation({tan($0 * Double.pi / 180)}),
        "e": Operation.constant(M_E),
        "EE": Operation.binaryOperation({$0 * pow(10, $1)}),
            
        "sinh": Operation.unaryOperation({sinh($0)}),
        "cosh": Operation.unaryOperation({cosh($0)}),
        "tanh": Operation.unaryOperation({tanh($0)}),
        "𝝅": Operation.constant(Double.pi),
        "Rand": Operation.unaryOperation({_ in Double.random(in: 0...1)})
    ]
    
    private var globalValue: Double?
    
    mutating func setOperand(_ operand: Double) {
        globalValue = operand
    }
    
    mutating func performOperation(_ operation: String) {
        let symbol = myOperation[operation]!
        switch symbol {
        case .constant(let value):
            globalValue = value
            saving = nil
        case .unaryOperation(let function):
            globalValue = function(globalValue!)
        case .binaryOperation(let function):
            if saving?.firstOperand != nil {
                let value = saving?.performOperationWith(secondOperand: globalValue!)
                saving?.firstOperand = value!
            } else {
                saving = SaveFirstOperandAndOperation(firstOperand: globalValue!, operation: function)
            }
        case .equals:
            if globalValue != nil {
                globalValue = saving?.performOperationWith(secondOperand: globalValue!)
                saving = nil
            }
        }
    }
    
    var result: Double? {
        get {
            return globalValue
        }
    }
    
        private var saving: SaveFirstOperandAndOperation?
    
    struct SaveFirstOperandAndOperation {
        var firstOperand: Double
        var operation: (Double, Double) -> Double
        
        func performOperationWith(secondOperand op2: Double) -> Double {
            return operation(firstOperand, op2)
        }
    }
}
