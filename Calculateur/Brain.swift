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

class Brain {

    // read-only property (only get is implemented)
    var result: Double {
        get {
            return accumulator
        }
    }
    private var accumulator = 0.0

    func setOperand(operand: Double) {
        accumulator = operand
    }

    func perform(symbol: String) {
        switch symbol {
        case "π": accumulator = M_PI
        case "√": accumulator = sqrt(accumulator)
        default: break
        }
    }
}