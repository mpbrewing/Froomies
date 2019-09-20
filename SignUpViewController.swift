//
//  SignupViewController.swift
//  FR3
//
//  Created by Michael Brewington on 8/30/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    // @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    

        var tags = ["Affectionate","Aloof","Ambitious","Amusing","Analytical","Anxious","Artistic","Charismatic","Creative","Curious","Dependable","Emotional","Extroverted","Introverted","Generous","Hard-Working","Diligent","Humorous","Impatient","Impulsive","Inconsistent","Independent","Intelligent","Joyful","Cheerful","Kind","Compassionate","Laid-Back","Lazy","Loyal","Organized","Original","Passionate","Proactive","Quiet","Shy","Sociable","Straight-forward","Stubborn","Sympathetic","Talkative","Temperamental","Moody","Upbeat","Warm-Hearted","Resident","Out of State","International"]
        var likes = ["Animals and Pets","Babysitting","Beauty and Hair Care","Being a Leader of a Group","Going to Church, Synagogue, or Temple","Listening to Music","Making and Enjoying Art","Playing Sports","Playing an Instrument","Taking Care of Others","The Great Outdoors","Watching TV or Movies","Writing Songs, Stories, and Poems","Visiting Friends","Eating","Playing Video Games","Cooking","Reading","Exercising","Traveling","Learning","Politics","Meeting New People","Fraternities and Sororities","Volunteering","Business and Finance","Drama and Theatre","Journalism","Science and Technology"]
        var list = ["What are your favorite movies?","What are your favorite books?","Favorite activity?","What are you passionate about?","Favorite meme?","List 5 things you want to do this year","Favorite quote?"]
    
    
    @IBOutlet weak var nameInputText: UITextField!
    @IBOutlet weak var emailInputText: UITextField!
    @IBOutlet weak var passwordInputText: UITextField!
    
    var ref: DocumentReference? = nil
    //var docRef: DocumentReference!
    
    func uploadData(value: String,size:Int,b:Array<Any>){
        let userId = Auth.auth().currentUser?.uid
        let emailTextArray = emailInputText.text?.components(separatedBy: "@")
        print(emailTextArray![0])
        print(emailTextArray![1])
        let Period = emailTextArray![1] as String
        let periodArray = Period.components(separatedBy: ".edu")
        let schoolEmail = periodArray[0] as String
         guard let emailText = emailInputText.text, !emailText.isEmpty else { return }
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(schoolEmail)").collection("List").document(value)
        
        
        if value == "Q&A"{
            for c in 0..<size{
                
                ref.setData([
                    "Question_\(c)": "0"
                ], merge: true) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        // print("Document added with ID: \(self.ref!.documentID)")
                    }
                }
                //
            }
        } else {
            for a in 0..<size{
                
                ref.setData([
                    "\(b[a])": "0"
                ], merge: true) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        // print("Document added with ID: \(self.ref!.documentID)")
                    }
                }
                //
            }
        }
        
    }

    
    @IBAction func Continue(_ sender: UIButton) {
        print(self.emailInputText.text!)
        print(self.passwordInputText.text!)
        print(self.nameInputText.text!)
        
        let emailTextArray = emailInputText.text?.components(separatedBy: "@")
        print(emailTextArray![0])
        print(emailTextArray![1])
        let Period = emailTextArray![1] as String
        let periodArray = Period.components(separatedBy: ".edu")
        let schoolEmail = periodArray[0] as String
        
        guard let nameText = nameInputText.text, !nameText.isEmpty else { return }
        guard let emailText = emailInputText.text, !emailText.isEmpty else { return }
        guard let passwordText = passwordInputText.text, !passwordText.isEmpty else { return }
        
        /*
        let dataToSave: [String: Any] = ["name": nameText, "email": emailText, "password": passwordText]
        */
        print(nameText)
        print(emailText)
        print(passwordText)
        /*
        docRef.setData(dataToSave) { (error) in
            if let error = error {
                print("Oh no! Got an error: \(error.localizedDescription)")
            } else {
                print("Data has been saved!")
            }
            
        }
        */
        print("test1")
        
        Auth.auth().createUser(withEmail: self.emailInputText.text!, password: self.passwordInputText.text!){ (authResult, error) in
            
            if error == nil && authResult != nil {
                print("User logged in!")
                //
                let userId = Auth.auth().currentUser?.uid
                self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                    self.uploadData(value: "Tag",size:self.tags.count,b:self.tags)
                    self.uploadData(value: "Dislikes",size:self.likes.count,b:self.likes)
                    self.uploadData(value: "Likes",size:self.likes.count,b:self.likes)
                    self.uploadData(value: "Q&A",size:self.list.count,b:self.list)
                    self.uploadData(value: "Looking",size:self.tags.count,b:self.tags)
                }
               
                
                let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(schoolEmail)")
                
                ref.setData([
                    "name": nameText,
                    "email": emailText,
                    "password": passwordText,
                    "school" : schoolEmail,
                    "photolink_1": "",
                    "aboutMe": ""
                ], merge: true) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                       // print("Document added with ID: \(self.ref!.documentID)")
                    }
                }
                //
                let ref2 = self.db.collection("users").document("\(userId!)")
                ref2.setData([
                    "name": nameText,
                    "email": emailText,
                    "password": passwordText,
                    "school" : schoolEmail,
                    "photolink_1": "",
                    "aboutMe": ""
                ], merge: true) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        // print("Document added with ID: \(self.ref!.documentID)")
                    }
                }
            } else {
                print("Error Logging in user: \(error!.localizedDescription)")
            }
            
            // ...
        }
        
        //let userID = Auth.auth().currentUser!.uid
        
        print("test2")
        /*
        let userId = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document("\(userId!)")
        
        ref.setData([
            "name": nameText,
            "email": emailText,
            "password": passwordText,
            "school" : schoolEmail
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
        }
        */
       
        print("test3")
        
        self.performSegue(withIdentifier: "SignupToProfileSegue", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
     //   docRef = Firestore.firestore().document("users")
      //  ref = Firestore.firestore().document("users")
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        print("testv4")
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            print("testv5")
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
        //   self.dataLabel!.text = dataObject
        print("testv3")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
        print("testv2")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "SignupToProfileSegue", sender: self)
        }
        print("testv1")
    }
    
    @IBAction func BackArrow(_ sender: Any) {
        self.performSegue(withIdentifier: "SignupToDataViewSegue", sender: self)
    }
    
    
}
