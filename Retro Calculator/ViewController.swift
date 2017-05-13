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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "btn", withExtension: "wav")!
        do {
            buttonSound = try AVAudioPlayer(contentsOf: url)
            guard let buttonSound = buttonSound else { return }
            
            buttonSound.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton!) {
        buttonSound.play()
    }
}

