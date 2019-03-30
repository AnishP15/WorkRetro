//
//  SignUpViewController.swift
//  WorkRetro
//
//  Created by Anish Palvai on 3/20/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var gradeLvlButtons: [UIButton]!
    
    @IBOutlet weak var gradeLvlText: UIButton!

    @IBOutlet weak var unableToSignUp: UILabel!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    

    @IBAction func gradeLvlTapped(_ sender: UIButton) {
        gradeLvlText.titleLabel?.text = "Grade Level \(sender.titleLabel?.text ?? "fff" )"
        
        
        }
    
    
    @IBAction func handleSelection(_ sender: Any) {
        gradeLvlButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    @IBAction func dissmissViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

 
    
    @IBAction func signUpTapped(_ sender: Any) {
        if let password = passwordTextField.text{
            if let email = emailTextField.text{
                if gradeLvlText.titleLabel?.text != "Select a grade level"{
                    if let gradeText = gradeLvlText.titleLabel?.text{
                        if email != "" && password != "" && password.count>5{
                            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                            let userInfo : [String:Any] = ["email": email, "grade level":gradeText]
                            self.ref.child("Users").childByAutoId().setValue(userInfo)
                                
                                
                            self.dismiss(animated: true, completion: nil)
                            }
                            
                        }
                        
                        else{
                            unableToSignUp.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                            unableToSignUp.text = "Make sure that your password is atleast 6 characters and you enter a valid email."
                        }
                    }
                    
                    else{
                        unableToSignUp.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        
                    }
                    
           }
               else{
                 unableToSignUp.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                 unableToSignUp.text = "Make sure to enter a password and valid email."
            }
        }
            else{
                unableToSignUp.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                unableToSignUp.text = "Make sure to enter a password and valid email."
            }
    }
        
    }
    
    
}
