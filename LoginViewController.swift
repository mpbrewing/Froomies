//
//  LoginViewController.swift
//  FR3
//
//  Created by Michael Brewington on 8/30/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    
    @IBOutlet weak var emailInputText: UITextField!
    @IBOutlet weak var passwordInputText: UITextField!
    
    @IBAction func Continue(_ sender: UIButton) {
        print(self.emailInputText.text!)
        print(self.passwordInputText.text!)
        
        Auth.auth().signIn(withEmail: self.emailInputText.text!, password: self.passwordInputText.text!) { (authResult, error) in
            
            if error == nil && authResult != nil {
                print("User logged in!")
                if Auth.auth().currentUser != nil{
                    self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                       self.performSegue(withIdentifier: "LoginToMainSegue", sender: self)
                    }
                }
            } else {
                print("Error Logging in user: \(error!.localizedDescription)")
            }
            
            // ...
        }
        
    }
 
    override func viewDidLoad() {
      //  let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
    //    statusBar?.backgroundColor = UIColor.black
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
        //   self.dataLabel!.text = dataObject
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "LoginToMainSegue", sender: self)
        }
    }
    
    @IBAction func BackArrow(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginToDataViewSegue", sender: self)
    }
    
}
