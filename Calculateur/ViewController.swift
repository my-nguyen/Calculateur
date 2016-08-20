//
//  ViewController.swift
//  Calculateur
//
//  Created by My Nguyen on 8/18/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

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
        userIsTyping = false
        if let symbol = sender.currentTitle {
            if symbol == "π" {
                displayValue = M_PI
            } else if symbol == "√" {
                displayValue = sqrt(displayValue)
            }
        }
    }
}

