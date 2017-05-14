//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Shivam Sharma on 5/12/17.
//  Copyright © 2017 ShivamSharma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // Outlets
    @IBOutlet weak var outpulLabel: UILabel!
    
    // Properties
    var buttonSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty
    
    // Enum
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "btn", withExtension: "wav")!
        do {
            buttonSound = try AVAudioPlayer(contentsOf: url)
            
            buttonSound.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton!) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outpulLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(_ sender: UIButton) {
        processOperation(op: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(_ sender: UIButton) {
        processOperation(op: Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(_ sender: UIButton) {
        processOperation(op: Operation.Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: UIButton) {
        processOperation(op: Operation.Add)
    }
    
    @IBAction func onEqualsPressed(_ sender: UIButton) {
        processOperation(op: currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: UIButton) {
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
        outpulLabel.text = "0"
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        
        if (currentOperation != Operation.Empty) {
            
            if (runningNumber != "") {
                rightValStr = runningNumber
                runningNumber = ""
                
                if (currentOperation == Operation.Divide) {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if (currentOperation == Operation.Multiply) {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if (currentOperation == Operation.Add) {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if (currentOperation == Operation.Subtract) {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outpulLabel.text = result
            }
            
            currentOperation = op
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if (buttonSound.isPlaying) {
            buttonSound.stop()
        }
        buttonSound.play()
    }
}

