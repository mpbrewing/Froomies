//
//  CreateProfileViewController.swift
//  FR3
//
//  Created by Michael Brewington on 10/31/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleLogout(_ target:UIButton){
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
}
