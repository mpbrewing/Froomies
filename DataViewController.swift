//
//  DataViewController.swift
//  FR3

//    @IBOutlet weak var dataLabel: UILabel!
//    var dataObject: String = ""

//  Created by Michael Brewington on 8/30/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import UIKit
import Foundation

class DataViewController: UIViewController {
    

    
    var dataObject: String = ""
    
    override func viewDidLoad() {
       // let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
      //  statusBar?.backgroundColor = UIColor.black
      //  statusBar?.tintColor = UIColor.white
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Page is loaded")
    }
    
    

    @IBAction func Login(_ sender: UIButton) {
        print("Button is clicked")
        self.performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    @IBAction func Signup(_ sender: UIButton) {
        print("Signup is clicked")
        self.performSegue(withIdentifier: "SignupSegue", sender: self)
    }

    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
 
