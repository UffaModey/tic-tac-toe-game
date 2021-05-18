//
//  ViewController.swift
//  ticTacToeAssesment2
//
//  Created by MAC on 10/05/2021.
//

import UIKit


public var pOrC = 0 // sets the player play vs computer, or the player vas player mode. 1 = pvc, 2 = pvp

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playerVsComputerButtonPressed(_ sender: UIButton) {
        
        pOrC = 1
        performSegue(withIdentifier: "playTheGame", sender: self)
        
    }
    
    @IBAction func playerVsPlayerButtonPressed(_ sender: UIButton) {
        
        pOrC = 2
        performSegue(withIdentifier: "playTheGame", sender: self)
    }
    
    
    
    
    
}

