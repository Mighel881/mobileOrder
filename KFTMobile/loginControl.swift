//
//  loginControl.swift
//  KFTMobile
//
//  Created by Raffer Li on 7/14/19.
//  Copyright © 2019 Raffer Li. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth


class loginController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var cusernameField: UITextField!
    @IBOutlet weak var cpasswordField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet var loginPage: UIView!
    
    
    override func viewDidLoad() {
        
         self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //loginButton.layer.cornerRadius = 10
        //loginButton.clipsToBounds = true
        //usernameField.autocorrectionType = .no
        //passwordField.autocorrectionType = .no
    }
    
    @IBAction func returnLogin(_ sender: Any) {
        
        guard let username = usernameField.text, let password = passwordField.text else {
            return
        }
        
        //let USERN: String = "li.raffer0@gmail.com"
        //let PASSW: String = "123456"
        
        Auth.auth().signIn(withEmail: username, password: password) {(result, error) in
        //Auth.auth().signIn(withEmail: USERN, password: PASSW) {(result, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "The username and password do not match", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion:  nil)
            } else {
                self.performSegue(withIdentifier: "beginOrder", sender: self)
            }
            
            
        }
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let username = usernameField.text, let password = passwordField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: username, password: password) {(result, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "The username and password do not match", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion:  nil)
            } else {
                self.performSegue(withIdentifier: "beginOrder", sender: self)
            }

        
    }
}
    
    
    @IBAction func createTap(_ sender: UIButton) {
        
        
        if ((cpasswordField.text!.count >= 6) && (cusernameField.text!.contains("@") && cusernameField.text!.contains("."))){
        Auth.auth().createUser(withEmail: (cusernameField.text ?? ""), password: (cpasswordField.text ?? "")) { (result, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion:  nil)
            }else{
                ref.child(userID + "/count").setValue("1")
                
                
                
                
                var userCountString: String = ""
                var userCountInt: Int = 0
                
                
                ref.child("0userBase").child("count").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let userCount = snapshot.value as? String ?? ""
                    

                    userCountString = userCount
                    userCountInt = Int(userCountString)!
                    userCountInt = userCountInt + 1
                    ref.child("0userBase/count").setValue(String(userCountInt))
                    ref.child("0userBase/user" + String(userCountInt)).setValue(userID)
                    
                })
                
                self.performSegue(withIdentifier: "clearedOrder", sender: self)
            }
        }
        
        
        }else{
            
            if cpasswordField.text!.count < 6 {
            let alert = UIAlertController(title: "Error", message: "The password needs to be atleast 6 characters long", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion:  nil)
            }
            if (cusernameField.text!.contains("@")){
            let alert = UIAlertController(title: "Error", message: "That email is not valid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion:  nil)
            
            }
        }
        
        

        
        
    }
}

