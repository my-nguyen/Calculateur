//
//  Brain.swift
//  Calculateur
//
//  Created by My Nguyen on 8/20/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

// since this is a model class, so it imports Foundation and not UIKit (which is for UI stuff)
// this file is created via menu File > New > File. Then choose iOS > Source > Swift File
import Foundation

func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class Brain {

    enum Operation {
        // 1. associated value
        case Constant(Double)
        case Unary((Double) -> Double)
        case Binary((Double, Double) -> Double)
        case Equal
    }

    // struct example. note a struct doesn't require an initializer (as with a class)
    struct PendingInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }

    // read-only property (only get is implemented)
    var result: Double {
        get {
            return accumulator
        }
    }
    private var accumulator = 0.0
    var operations: Dictionary<String, Operation> = [
        // 2. assign different associated values (M_PI, sqrt)
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        // see the explanation below for Operation.Binary({ $0 * $1 })
        "±" : Operation.Unary({ -$0 }),
        "√" : Operation.Unary(sqrt),
        "cos" : Operation.Unary(cos),
        // fully expressed original version of the closure:
        // Operation.Binary({ (op1: Double, op2: Double) -> Double in return op1 * op2 }),
        // 1. as defined in enum Operation, Operation.Binary accepts a function taking 2 Double params and
        // returning a Double. using type inference that expression can be shorted to
        // Operation.Binary({ (op1, op2) in return op1 * op2 }),
        // 2. closure has default arguments $0, $1, etc. so:
        // Operation.Binary({ ($0, $1) in return $0 * $1 }),
        // 3. even better:
        // Operation.Binary({ return $0 * $1 }),
        // 4. finally:
        // Operation.Binary({ $0 * $1 }),
        "×" : Operation.Binary({ $0 * $1 }),
        "÷" : Operation.Binary({ $0 / $1 }),
        "+" : Operation.Binary({ $0 + $1 }),
        "−" : Operation.Binary({ $0 - $1 }),
        "=" : Operation.Equal
    ]
    private var pending: PendingInfo?

    func setOperand(operand: Double) {
        accumulator = operand
    }

    func perform(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                // 3. extract associated value
                accumulator = value
            case .Unary(let function):
                accumulator = function(accumulator)
            case .Binary(let function):
                // allow intermediary execution on operands without pressing the "=" button
                execute()
                // save binary function and first operand
                pending = PendingInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equal:
                execute()
            }
        }
    }

    private func execute() {
        if pending != nil {
            // second operand collected: execute binary function on first and second operands
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
}