//
//  LoginViewController.swift
//  WorkRetro
//
//  Created by Anish Palvai on 3/20/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var unableToLoginText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = emailTextField.text{
                if let password = passwordTextField.text{
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if(error == nil){
                            self.performSegue(withIdentifier: "toMain", sender: self)
                        }
                        else{
                            self.unableToLoginText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        }
                    }
                
            }
        }
    }

}
