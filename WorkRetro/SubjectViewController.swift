//
//  SubjectViewController.swift
//  WorkRetro
//
//  Created by Anish Palvai on 3/27/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SubjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var count = 0

    @IBAction func toMath(_ sender: Any) {
        self.count = 1
        performSegue(withIdentifier: "toMath", sender: sender)
        
    }
    
    @IBAction func toEnglish(_ sender: Any) {
        self.count = 2
        performSegue(withIdentifier: "toEnglish", sender: sender)
        
    }
    
    @IBAction func toScience(_ sender: Any) {
        self.count = 3
        performSegue(withIdentifier: "toScience", sender: sender)
    }

    @IBAction func toAdvice(_ sender: Any) {
        self.count = 4
        performSegue(withIdentifier: "toAdvice", sender: sender)
    }
    
    
    func getCurrentSubject()->String{
        if self.count == 1{
            return "math"
        }
        else if self.count == 2{
            return "english"
        }
        else if self.count == 3{
            return "science"
        }
        else {
            return "advice"
        }
    }
    
}
