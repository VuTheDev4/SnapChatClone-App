//
//  LoginViewController.swift
//  CatChat
//
//  Created by Vu Duong on 9/7/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signupMode = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func topTapped(_ sender: Any) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if signupMode {
                    // sign up
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        } else {
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                            print("Sign up was successful!!!!")
                        }
                    }
                    
                } else {
                    // log in
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        } else {
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                            print("Log in was successful!!!!!!")
                        }
                    }
                    
                }
            }
        }
        
    }
    // error alert
    func presentAlert(alert : String) {
        let alertVC =  UIAlertController(title: "error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    @IBAction func bottomTapped(_ sender: Any) {
        
        if signupMode {
            // switch to login
            signupMode = false
            topButton.setTitle("Log in", for: .normal)
            bottomButton.setTitle("Swith to sign up", for: .normal)
        } else {
            // switch to signup
            signupMode = true
            topButton.setTitle("Sign up", for: .normal)
            bottomButton.setTitle("Switch to Log in", for: .normal)
        }
    }
    
}

