//
//  FunctionClass.swift
//  CalculatorWithSB
//
//  Created by (^ㅗ^)7 iMac on 2023/07/18.
//

import Foundation

class AbstractOperation {
    func CalculatorAdd(_ firstValue: Double, _ secondValue: Double) -> String {
        return ""
    }
    
    func CalculatorSubtract(firstValue: Double, secondValue: Double) -> String {
        return ""
    }
    
    func CalculatorMultiply(firstValue: Double, secondValue: Double) -> String {
        return ""
    }
    
    func CalculatorDivide(firstValue: Double, secondValue: Double) -> String {
        return ""
    }
}

class AddOperation: AbstractOperation {
    override func CalculatorAdd(_ firstValue: Double, _ secondValue: Double) -> String {
        let result = "\(firstValue + secondValue)"
        return result
    }
}

class SubtractOperation: AbstractOperation {
    override func CalculatorSubtract(firstValue: Double, secondValue: Double) -> String {
        let result = "\(firstValue - secondValue)"
        return result
    }
}

class MultiplyOperation: AbstractOperation {
    override func CalculatorMultiply(firstValue: Double, secondValue: Double) -> String {
        let result = "\(firstValue * secondValue)"
        return result
    }
}

class DivideOperation: AbstractOperation {
    override func CalculatorDivide(firstValue: Double, secondValue: Double) -> String {
        let result = String(format: "%.2f", firstValue / secondValue)
        return result
    }
}

