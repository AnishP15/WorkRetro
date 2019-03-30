//
//  SubjectSelectionViewController.swift
//  WorkRetro
//
//  Created by Anish Palvai on 3/24/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseDatabase

class ChatRoomsLocation: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let ref = Database.database().reference()
    var userZipCode:String? = ""
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
                if error == nil{
                    if let place = placemark?[0]{
                        self.ref.child("zipCodes").childByAutoId().child("zipCode").observeSingleEvent(of: .value, with: { (snapshot) in
                            if let zip = snapshot.value as? String{
                                self.performSegue(withIdentifier: "toSubjectSelection", sender: UIViewController())
                            }
                            else{
                                let controller = self.storyboard?.instantiateViewController(withIdentifier: "subjectSelection")
                                //self.performSegue(withIdentifier: "toSubjectSelection", sender: UIViewController())
                                self.present(controller!, animated: true, completion: nil)
                                self.userZipCode = place.postalCode
                                let info: [String: Any] = ["zipCode":self.userZipCode]
                                self.ref.child("zipCodes").childByAutoId().setValue(info)
                                
                            }
                            
                        })
                        

                    }
                }
                
                else{
                    print(error?.localizedDescription)
                }
                
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied){
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp(){
        let alertController = UIAlertController(title: "Backgroung Location Access Denied", message: "In order to put you in a regional chat room, we need your location", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
  
    
}
