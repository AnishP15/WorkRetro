//
//  ChatLogViewController.swift
//  WorkRetro
//
//  Created by Anish Palvai on 3/25/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ChatLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentSubject = ""
    
    let subject = SubjectViewController()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.text
        
        return cell
    }
 
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        
        currentSubject = subject.getCurrentSubject()
        
        
       observeMessages()
    
    
    }
    
    var messages = [Message]()
    
    func observeMessages(){
        print(currentSubject)
        let ref = Database.database().reference().child(currentSubject).child("messages")
        
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:Any]{
               
                let message = Message()
               
                message.setValuesForKeys(dictionary)
            
                self.messages.append(message)
                
                self.tableView.reloadData()
            }
            
        }, withCancel: nil)
    }
    
    @IBAction func handleSend(_ sender: Any) {
        let ref = Database.database().reference().child(currentSubject).child("messages")
        let childRef = ref.childByAutoId()
        let timeStamp: Int = Int(NSDate().timeIntervalSince1970)
        let values:[String:Any] = ["text":textField.text!, "timeStamp":timeStamp]
        childRef.updateChildValues(values)
        
    }
    
}
