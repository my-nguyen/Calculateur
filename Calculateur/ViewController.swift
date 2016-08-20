//
//  ViewController.swift
//  Calculateur
//
//  Created by My Nguyen on 8/18/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsTyping = false

    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            let text = display.text!
            display.text = text + digit
        } else {
            display.text = digit
        }
        userIsTyping = true
    }

    @IBAction func performOperation(sender: UIButton) {
        userIsTyping = false
        if let symbol = sender.currentTitle {
            if symbol == "π" {
                display.text = String(M_PI)
            }
        }
    }
}

