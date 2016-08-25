//
//  ViewController.swift
//  Calculateur
//
//  Created by My Nguyen on 8/18/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

var calculatorCount = 0

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    private var userIsTyping = false
    // a computed property; here it's used to facilitate converting between Double and String
    private var displayValue: Double {
        get {
            // need to unwrap the Double because the text string may not be convertible to a Double, e.g. "Hello"
            return Double(display.text!)!
        }
        set {
            // newValue is a keyword
            display.text = String(newValue)
        }
    }
    private var brain = Brain()
    var savedProgram: Brain.MyPropertyList?

    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorCount += 1
        print("new calculator, count: \(calculatorCount)")
    }

    // deinit gets called something leaves the heap
    deinit {
        calculatorCount -= 1
        print("calculator destroyed, count: \(calculatorCount)")
    }

    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            let text = display.text!
            display.text = text + digit
        } else {
            display.text = digit
        }
        userIsTyping = true
    }

    @IBAction private func performOperation(sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let symbol = sender.currentTitle {
            brain.perform(symbol)
        }
        displayValue = brain.result
    }

    @IBAction func save() {
        savedProgram = brain.program
    }

    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
}

