//
//  Calculator.swift
//  CalculatorMVC
//
//  Created by Kim Kiori on 1/25/20.
//  Copyright © 2020 Kim Kiori. All rights reserved.
//

import Foundation
class Calculator {
    
    //MARK: - Constants
    enum Operation {
        case equals
        case binary(function: (Double, Double) -> Double)
        case unary(function: (Double) -> Double)
        case constant(value: Double)
        case clean
    }
    
    var map: [String: Operation] = [
        "+" : .binary{ $0 + $1 },
        "-" : .binary{ $0 - $1 },
        "*" : .binary{ $0 * $1 },
        "/" : .binary{ $0 / $1 },
        "%" : .unary { $0 / 100 },
        "Sqrt" : .unary{ sqrt($0) },
        "Pi" : .constant(value: Double.pi),
        "x!" : .unary{ factorial($0) },
        "x^y" : .binary{ pow($0, $1) },
        "Rand" : .constant( value: Double.random(in: 0.0 ..< 100000.0)),
        "C" : .constant (value: 0),
        "AC" : .clean,
        "=" : .equals
    ]
        
    //MARK: - Variables
    var result:Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0 //первое введенное число
    
    //MARK: - Methods
    func setOperands (number: Double) {
        result = number
    }
    
    func execute (symbol: String) {
        guard let operation = map[symbol] else { return }
        
        switch operation {
        case .clean:
            result = 0
            lastBinaryOperation = nil
            reminder = 0
        case .constant(let value):
            result = value
        case .unary(let function):
            result = function(result)
        case .binary( let function):
            lastBinaryOperation = function
            reminder = result
        case .equals:
            if let lastOperation = lastBinaryOperation {
//                print(result)
//                if result != 0 {
//                    swap(&result, &reminder)
//                    result = lastOperation(reminder, result)
//                }
//                else {
                    result = lastOperation(reminder, result)
                    lastBinaryOperation = nil
                    reminder = 0
//                }
            }
        }
        
    }
    
    static func factorial(_ n: Double) -> Double {
        if n == 0 {
            return 1
        }
        else {
            return n * factorial(n - 1)
        }
    }

}
