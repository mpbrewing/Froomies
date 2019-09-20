//
//  UploadViewController.swift
//  FR3
//
//  Created by Michael Brewington on 9/6/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SDWebImage


class UploadViewController: UIViewController {
    
    let db = Firestore.firestore()
 
    var currentImageView: UIImageView?
    
    struct GlobalStructureUpload {
        static var counter = 0
        static var list = ["7fBtanpGhHYtrLoecI0tdRUsReY2","ZImCpCdQJTXDq0xNzd8TzvTicwI2","jXkG9351pRd6QY3lT4RiytOVu3q1","nfb06eruI5bwOYiqp0unial3xAQ2","test"]
         static var globalArray = [String](repeating: "", count: list.count)
        static var Bool : Bool!
        static var gender: String = ""
        static var swipeArray = [String](repeating: "",count: 0)
        static var swipeArray2 = [String](repeating:"",count: 0)
        static var mainString = ""
        static var matchBool = false
        static var matchCount = 0
        static var nextString = ""
    }
    
    @IBOutlet weak var Card: UIView!
    
    @IBAction func profileButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SwipeLeftProfile", sender: self)
    }
    
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var chatButton: UIButton!
    @IBAction func chatButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SwipeRightChat", sender: self)
    }
    
    @IBOutlet weak var SmilingEmoji: UIImageView!
    @IBOutlet weak var WearyEmoji: UIImageView!
    
    func loadData(){
        Card.reloadInputViews()
    }
    
    func uploadData(value: String,b:String,d:String){
        let userId = Auth.auth().currentUser?.uid
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let schoolEmail = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(schoolEmail)").collection("List").document(value)
        
        ref.setData([
            "\(b)": "\(d)"
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                // print("Document added with ID: \(self.ref!.documentID)")
            }
        }
        //
        
        
    }
    func orderData(){
        print("Order Data")
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let schoolEmail = studentId2[0]
        
        let ref = db.collection("users").document("\(userID)").collection("profile").document("\(schoolEmail)").collection("List").document("Boolean")
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let latMax2 = document.get("Gender") as! String?
                GlobalStructureUpload.gender = "\(latMax2!)"
            //    print(latMax2!)
            } else {
                print("Document does not exist in cache")
            }
        }
       // let userId = Auth.auth().currentUser?.uid
      //  print("\(GlobalStructureUpload.gender)")
       self.fetchUsers()
      //  let ref2 = db.collection("users")
        
    }
    
    func fetchUsers(){
        print("Fetch Users")
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let schoolEmail = studentId2[0]
        GlobalStructureUpload.swipeArray = [String](repeating: "",count: 0)
        //WhereField BothSwiped isEqualTo False
        //Save Top String and Counter
        //Display Top String and Counter in Profile View
        //Save Q&A
        //Design Question Style
        //Upload Matched Users and Chat
        /*
        if GlobalStructureUpload.counter > 1 {
            GlobalStructureUpload.counter = 0
        }
        */
        if GlobalStructureUpload.counter > 1 {
            GlobalStructureUpload.counter = 0
        }
        
        db.collection("users").whereField("Gender", isEqualTo: "Woman").whereField("school", isEqualTo: "\(schoolEmail)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let TestString = String(document.documentID)
                    GlobalStructureUpload.swipeArray.append(TestString)
                    
                    if GlobalStructureUpload.swipeArray.count > GlobalStructureUpload.counter{
                        self.DisplayString = "\(GlobalStructureUpload.swipeArray[GlobalStructureUpload.counter])"
                       
                         if GlobalStructureUpload.swipeArray.count > 1{
                            
                        self.SecondString = "\(GlobalStructureUpload.swipeArray[GlobalStructureUpload.counter])"
                        }
                    }
                    if GlobalStructureUpload.swipeArray2.count > 0 {
                        self.DisplayString = "\(GlobalStructureUpload.swipeArray2[GlobalStructureUpload.counter])"
                        if GlobalStructureUpload.swipeArray2.count > 1 {
                        self.SecondString = "\(GlobalStructureUpload.swipeArray2[GlobalStructureUpload.counter])"
                        }
                    }
                    
                    self.uploadCurrent()
                    
                  //  print("\(document.documentID) => \(document.data())")
                    //print(GlobalStructureUpload.swipeArray.count)
                    print("\(document.documentID)")
                }
                if self.DisplayString.isEmpty != true {
                    self.Testing(String:self.DisplayString,Int: self.counter,Next: self.ImageDownload)
                    self.uploadExistingName(UserID: self.DisplayString)
                    self.secondCard(String:self.SecondString,Int: self.counter,Next: self.ImageView)
                }
                print(GlobalStructureUpload.swipeArray.count)
                
                if GlobalStructureUpload.swipeArray.count > 1 {
                      GlobalStructureUpload.swipeArray2 = [String](repeating: "",count: GlobalStructureUpload.swipeArray.count)
                if GlobalStructureUpload.swipeArray.count == GlobalStructureUpload.swipeArray2.count {
                for a in 0..<GlobalStructureUpload.swipeArray.count{
                    GlobalStructureUpload.swipeArray2[a] = GlobalStructureUpload.swipeArray[a]
                }
                }
                }

                GlobalStructureUpload.swipeArray = [String](repeating: "",count: 0)
            }
        }
        
    }
    
    var PreviousString = ""
    var DisplayString = ""
    var SecondString = ""
    //var counter2 = 0
    
    func moveString(){
        
        if GlobalStructureUpload.counter > 1 {
            GlobalStructureUpload.counter = 0
        }
        self.uploadPrevious()
        
        self.DisplayString = "\(GlobalStructureUpload.swipeArray2[GlobalStructureUpload.counter])"
        
        if GlobalStructureUpload.counter == 1 {
        self.SecondString = "\(GlobalStructureUpload.swipeArray2[GlobalStructureUpload.counter-1])"
        } else {
        self.SecondString = "\(GlobalStructureUpload.swipeArray2[GlobalStructureUpload.counter+1])"
        }
        self.uploadCurrent()
            print(GlobalStructureUpload.counter)
            print(DisplayString)
    }
    
    
    func uploadCurrent(){
        let userId = Auth.auth().currentUser?.uid
        
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        //let ref = self.db.collection("users").document("\(studentId!)").collection("Gender").document("\(userID)")
        
        //let ref = db.collection("users").document("\(userId!)").collection("profile").document("\(studentId!)")
        
        ref.setData([
            "current": DisplayString
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
        
    }
    func uploadPrevious(){
        let userId = Auth.auth().currentUser?.uid
        
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        //let ref = self.db.collection("users").document("\(studentId!)").collection("Gender").document("\(userID)")
        
        //let ref = db.collection("users").document("\(userId!)").collection("profile").document("\(studentId!)")
        
        ref.setData([
            "previous": DisplayString
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
        
    }
    
    func uploadMatchCounter(){
        let userId = Auth.auth().currentUser?.uid
        let testEmail = Auth.auth().currentUser!.email
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        match = match + 1
        
        ref.setData([
            "matches": match
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
        
    }
    
    func matchCounterDownload(){
        
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        //  let ref = db.collection("users").document("\(userId!)")
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
             //   self.match = 0
                if let latMax = document.get("matches") as! Int? {
                    print(latMax)
                    self.match = latMax
            //       self.match = 0
                } else {
                    
                }
                
                // self.AboutMeTextView.text = "\(latMax)"
                
            } else {
                print("Document does not exist in cache")
            }
        }
        
    }
    
    var match = 0
    
    func matchDownload(){
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("SwipeBoolean")
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                
                if let latMax = document.get("\(self.DisplayString)") as! String? {
                    print(latMax)
                    if latMax == "0" {
                        
                    } else if latMax == "1"{
                        let ref2 = self.db.collection("users").document("\(self.DisplayString)").collection("profile").document("\(email)").collection("List").document("SwipeBoolean")
                        ref2.getDocument(source: .cache) { (document, error) in
                            if let document = document {
                                
                                if let latMax = document.get("\(userId!)") as! String? {
                                    print(latMax)
                                    if latMax == "0" {
                                        
                                    } else if latMax == "1"{
                                        self.uploadMatchCounter()
                                        self.matchUpload()
                                    }
                                } else {
                                    
                                }
                                
                            } else {
                                print("Document does not exist in cache")
                            }
                        }
                    }
                } else {
                    
                }
                
            } else {
                print("Document does not exist in cache")
            }
        }

    }
    
    func matchUpload(){
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("MatchBoolean")
        self.downloadcurrent()
        
        ref.setData([
            "Match\(match)": "\(self.returnString)"
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
    }
    
    func download2(){
        
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        //  let ref = db.collection("users").document("\(userId!)")
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                
                if let latMax = document.get("counter") as! Int? {
                    print(latMax)
                    self.counter = latMax
                } else {
                    
                }
                
                // self.AboutMeTextView.text = "\(latMax)"
               
                 self.imageCircles()
            } else {
                print("Document does not exist in cache")
            }
        }
       
    }
    
    func downloadcurrent(){
        
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        //  let ref = db.collection("users").document("\(userId!)")
        returnBool = false
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                
                if let latMax = document.get("current") as! String? {
                    print(latMax)
                    self.returnString = latMax
                    self.returnBool = true
                } else {
                    self.returnBool = false
                }
                
                // self.AboutMeTextView.text = "\(latMax)"
                
             //   self.imageCircles()
            } else {
                print("Document does not exist in cache")
            }
        }
        
    }
    var returnBool = false
    var returnString = ""
    
    func runMatch(){
        matchCounterDownload()
        let userId = Auth.auth().currentUser?.uid
        let testEmail = Auth.auth().currentUser!.email
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let schoolEmail = studentId2[0]
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(schoolEmail)").collection("List").document("MatchBoolean")
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
           //     self.matchBool = false
                for a in 0..<self.match{
                    if let latMax = document.get("Match\(a)") as! String? {
                    print("LATMAX \(latMax)")
                    if latMax == "\(self.DisplayString)"{
                       GlobalStructureUpload.matchCount = GlobalStructureUpload.matchCount + 1
                        GlobalStructureUpload.matchBool = true
                    }
                }
                }
            } else {
                print("Document does not exist in cache")
            }
        }
       
        if GlobalStructureUpload.matchBool == false {
            if GlobalStructureUpload.matchCount < 1 {
        if self.DisplayString != userId! {
            //Search Contains Display String
            self.matchDownload()
            self.matchCounterDownload()
        }
            }
        }
    }
    
   
    
    func uploadCounter(){
        let userId = Auth.auth().currentUser?.uid
        
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        //let ref = self.db.collection("users").document("\(studentId!)").collection("Gender").document("\(userID)")
        
        //let ref = db.collection("users").document("\(userId!)").collection("profile").document("\(studentId!)")
        
        ref.setData([
            "counter": counter
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
        
    }
    
    @IBAction func PanGesture(_ sender: UIPanGestureRecognizer) {

        let Card = sender.view!
        let translationPoint = sender.translation(in: view)
        Card.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
        //
        let distanceMoved = Card.center.x - view.center.x
        if distanceMoved > 0 { // moved right side
            WearyEmoji.alpha = 0
            SmilingEmoji.alpha = abs(distanceMoved)/view.center.x
            SmilingEmoji.alpha = 1
            
            
        } else { // moved left side
            SmilingEmoji.alpha = 0
            WearyEmoji.alpha = abs(distanceMoved)/view.center.x
            WearyEmoji.alpha = 1
            
        }
        
        //
        //
        if sender.state == UIGestureRecognizerState.ended {
            if Card.center.x < 20 { // Moved to left
                UIView.animate(withDuration: 0.3, animations: {
                    Card.center = CGPoint(x: Card.center.x-200, y: Card.center.y)
                    print("left")
                    //Send 0 to Database
                    GlobalStructureUpload.counter = GlobalStructureUpload.counter + 1
                    self.counter = 1
                    self.uploadCounter()
                 //   print(GlobalStructureUpload.counter)
                    self.moveString()
                    if self.DisplayString.isEmpty != true {
                        self.uploadData(value: "SwipeBoolean",b:self.DisplayString,d: "0")
                    }
                   self.currentImageView?.alpha = 0
                    self.Card.alpha = 0
                  //
                    //resetCardViewToOriginalPosition()
                })
                download2()
                resetCard()
                return
            }
            else if (Card.center.x > (view.frame.size.width-20)) { // Moved to right
                UIView.animate(withDuration: 0.3, animations: {
                    self.downloadcurrent()
                    self.runMatch()
                    Card.center = CGPoint(x: Card.center.x+200, y: Card.center.y)
                    print("right")
                    self.Card.alpha = 0
                    //Send 1 to Database
                    if self.DisplayString.isEmpty != true {
                      //  self.runMatch()
                        self.uploadData(value: "SwipeBoolean",b:self.DisplayString,d: "1")
                    }
                    self.counter = 1
                    self.uploadCounter()
                    
                    GlobalStructureUpload.counter = GlobalStructureUpload.counter + 1
                    self.moveString()
                    //
                    self.currentImageView?.alpha = 0
                    self.currentImageView?.alpha = 0
                })
                 download2()
                resetCard()
                return
            }
            //resetCard()
            UIView.animate(withDuration: 0.2, animations: {
                self.Card.center = CGPoint(x: self.view.center.x, y: self.view.center.y+30)
                self.WearyEmoji.alpha = 0
                self.SmilingEmoji.alpha = 0
            })
        }
        //
        //
        //
        
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetCard()
    }
    
    func resetCard() {
        
        UIView.animate(withDuration: 0.5, animations:    {
            self.Card.center = CGPoint(x: self.view.center.x, y: self.view.center.y+30)
            self.WearyEmoji.alpha = 0
            self.SmilingEmoji.alpha = 0
            self.currentImageView?.alpha = 0
            self.Card.alpha = 0
        }, completion: { (finished: Bool) in
            self.Card.alpha = 1
            self.currentImageView?.alpha = 1
        })

    
        var list = ["7fBtanpGhHYtrLoecI0tdRUsReY2","ZImCpCdQJTXDq0xNzd8TzvTicwI2","jXkG9351pRd6QY3lT4RiytOVu3q1","nfb06eruI5bwOYiqp0unial3xAQ2","test"]
        
        if DisplayString.isEmpty != true {
            Testing(String:DisplayString,Int: counter,Next: ImageDownload)
            uploadExistingName(UserID: DisplayString)
            secondCard(String:SecondString,Int: counter,Next: ImageView)
        }
        ///
        let store = Storage.storage()
        let storeRef = store.reference()
        
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
       
        
        let refTest = Storage.storage().reference(forURL: "gs://froomies3-1.appspot.com/gs:/profiles/\(list[0])()_\(2).jpg")
        let placeholderImage = UIImage(named: "placeholder.jpg")
        
      //  print(storeRef.downloadURL)
        
        self.currentImageView?.clipsToBounds = true
        self.currentImageView = ImageDownload
        self.currentImageView?.clipsToBounds = true
        
        print("Image updated")
        
        refTest.downloadURL(completion: {
            (url: URL?, error: Error?) in
            if (error == nil) {
                if let downloadUrl = url {
                    // Get the download URL.
                    let downloadURL = downloadUrl.absoluteString
                    print("This is the downloadURL: \(downloadURL)")
                    
                    self.ImageDownload.sd_setImage(with: URL(string: "\(downloadURL)"), placeholderImage: placeholderImage)
                }
            } else {
                print("Error:\n\(error!)")
            }
        });
        
        
 
    }

    func secondCard(String: String, Int: Int, Next: UIImageView){
            let store = Storage.storage()
            let storeRef = store.reference()
            
            let db = Firestore.firestore()
            let settings = self.db.settings
            settings.areTimestampsInSnapshotsEnabled = true
            self.db.settings = settings
            
            
            let refTest = Storage.storage().reference(forURL: "gs://froomies3-1.appspot.com/gs:/profiles/\(String)_\(Int).jpg")
            
            let storage = Storage.storage().reference(forURL: "gs://froomies3-1.appspot.com")
            let imageName = "\(String)_\(Int).jpg"
            let imageURL = storage.child(imageName)
            
            
            _ = imageURL.downloadURL(completion: { (url, error) in
                
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                } else {
                    print(url!)
                    return
                }
                //Now you can start downloading the image or any file from the storage using URLSession.
                
            })
            
            
            //  let ImageDownload: UIImageView = self.ImageDownload
            // let Next: UIImageView = Next
            
            let placeholderImage = UIImage(named: "placeholder.jpg")
            
            print(storeRef.downloadURL)
            /*
            
            self.currentImageView?.clipsToBounds = true
            self.currentImageView = Next
            self.currentImageView?.clipsToBounds = true
            */
            print("Image updated")
            
            refTest.downloadURL(completion: {
                (url: URL?, error: Error?) in
                if (error == nil) {
                    if let downloadUrl = url {
                        // Get the download URL.
                        let downloadURL = downloadUrl.absoluteString
                        print("This is the downloadURL: \(downloadURL)")
                        
                        Next.sd_setImage(with: URL(string: "\(downloadURL)"), placeholderImage: placeholderImage)
                    }
                } else {
                    print("Error:\n\(error!)")
                }
            });
            
        
    }
    
    

    
    @IBOutlet weak var ImageDownload: UIImageView!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    let userID = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Button: UIButton!
    
    @IBAction func Button(_ sender: UIButton) {
        print(self.Name.text!)
        //print(cardData())
     //   cardData()
        orderData()
       
        
        performSegue(withIdentifier: "ButtonToProfileSegue", sender: self)
    }
    
    
    func uploadExistingName(UserID: String) {
        
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        //let userId = Auth.auth().currentUser?.uid
        let ref = db.collection("users").document("\(UserID)")
            
            ref.getDocument(source: .cache) { (document, error) in
                if let document = document {
                    let latMax2 = document.get("name") as! String?
                    print(latMax2!)
                    self.Name.text = "\(latMax2!)"
                    self.Name.font = UIFont.boldSystemFont(ofSize: 24.0)
                } else {
                    print("Document does not exist in cache")
                }
            }
    }
    
    
    func cardData(){
        //let userId = Auth.auth().currentUser?.uid
        //let ref = db.collection("users").document("\(userId!)")
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    print("\(document.documentID)")
                    for i in 0..<GlobalStructureUpload.list.count{
                        GlobalStructureUpload.globalArray[i] = document.documentID
                     //   print(GlobalStructureUpload.globalArray[i])
                    }
                   
                }
            }
        }
        
    }
    
    func displayStack(){
        
    }
    
    //QUERY USERS -> SCHOOL -> GENDER -> DOWNLOAD USER DATA ->
    /*
     Order by School, Gender, ELO, Sim Score
     Calculate ELO
     Save Trends
 */
    //HasSwiped
    func saveData(){
        /*
        guard let aboutMeText = AboutMeTextView.text, !aboutMeText.isEmpty else { return }
        let _: [String: Any] = ["aboutMe": aboutMeText]
        print(aboutMeText)
        
        _ = Auth.auth().currentUser?.uid
        let userId = Auth.auth().currentUser?.uid
        let ref = db.collection("users").document("\(userId!)")
        
        ref.setData([
            "aboutMe": aboutMeText
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
 */
    }
    
    
    func Testing(String: String, Int: Int, Next: UIImageView){
        let store = Storage.storage()
        let storeRef = store.reference()
        
        let db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        
        let refTest = Storage.storage().reference(forURL: "gs://froomies3-1.appspot.com/gs:/profiles/\(String)_\(Int).jpg")
        
        let storage = Storage.storage().reference(forURL: "gs://froomies3-1.appspot.com")
        let imageName = "\(String)_\(Int).jpg"
        let imageURL = storage.child(imageName)
        
        
        _ = imageURL.downloadURL(completion: { (url, error) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            } else {
                print(url!)
                return
            }
            //Now you can start downloading the image or any file from the storage using URLSession.
            
        })
        
        
      //  let ImageDownload: UIImageView = self.ImageDownload
       // let Next: UIImageView = Next
        
        let placeholderImage = UIImage(named: "placeholder.jpg")
        
        print(storeRef.downloadURL)
        
        
        self.currentImageView?.clipsToBounds = true
        self.currentImageView = Next
        self.currentImageView?.clipsToBounds = true
        
        print("Image updated")
        
        refTest.downloadURL(completion: {
            (url: URL?, error: Error?) in
            if (error == nil) {
                if let downloadUrl = url {
                    // Get the download URL.
                    let downloadURL = downloadUrl.absoluteString
                    print("This is the downloadURL: \(downloadURL)")
                    
                     Next.sd_setImage(with: URL(string: "\(downloadURL)"), placeholderImage: placeholderImage)
                }
            } else {
                print("Error:\n\(error!)")
            }
        });
 
    }
    
    
    override func viewDidLoad() {
        let store = Storage.storage()
        let storeRef = store.reference()
        
        let db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        download2()
        
       // uploadExistingName(UserID: "L6HqCgkI0CevvDMHHtpZyEruY262")
        
        orderData()
        
        Card.layer.cornerRadius = 10;
        Card.layer.masksToBounds = true;
        ImageView.layer.cornerRadius = 10;
        ImageView.layer.masksToBounds = true;
       
        self.view.bringSubview(toFront: SmilingEmoji)
        self.view.bringSubview(toFront: WearyEmoji)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeActionUpload(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeActionUpload(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        
        
       // swipeThroughProfiles()
        
       
       // DisplayString = "\(GlobalStructureUpload.swipeArray2[GlobalStructureUpload.counter])"
        
        if DisplayString.isEmpty != true {
            Testing(String:DisplayString,Int: counter,Next: ImageDownload)
            uploadExistingName(UserID: DisplayString)
            secondCard(String:SecondString,Int: counter,Next: ImageView)
        }
      //  Testing(String:"L6HqCgkI0CevvDMHHtpZyEruY262",Int: counter,Next: ImageDownload)
      //  secondCard(String:"hpFqL8gul7V8VFXLvStxNH9ozaC2",Int: counter,Next: ImageView)
        
 
    //    Testing(String:"nfb06eruI5bwOYiqp0unial3xAQ2",Int: 1,Next: ImageNext)
        /*
         7fBtanpGhHYtrLoecI0tdRUsReY2
         ZImCpCdQJTXDq0xNzd8TzvTicwI2
         jXkG9351pRd6QY3lT4RiytOVu3q1
         nfb06eruI5bwOYiqp0unial3xAQ2
         test
 */
        /*
        let refTest = Storage.storage().reference(forURL: "gs://froomies3-1.appspot.com/gs:/profiles/test_image1.jpg")
        
        let storage = Storage.storage().reference(forURL: "gs://froomies3-1.appspot.com")
        let imageName = "test_image1.jpg"
        let imageURL = storage.child(imageName)
        
        
        _ = imageURL.downloadURL(completion: { (url, error) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            } else {
                print(url!)
                return
            }
            //Now you can start downloading the image or any file from the storage using URLSession.
            
        })
        
        
        let ImageDownload: UIImageView = self.ImageDownload
        
        let placeholderImage = UIImage(named: "placeholder.jpg")
        
        print(storeRef.downloadURL)
        
        ImageDownload.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/froomies3-1.appspot.com/o/gs%3A%2Fprofiles%2Ftest_image1.jpg?alt=media&token=9403b793-2648-4c67-90e1-c5545d56d51b"), placeholderImage: placeholderImage)
        
        self.currentImageView?.clipsToBounds = true
        self.currentImageView = self.ImageDownload
        self.currentImageView?.clipsToBounds = true
        
        print("Image updated")
        
        refTest.downloadURL(completion: {
            (url: URL?, error: Error?) in
            if (error == nil) {
                if let downloadUrl = url {
                    // Get the download URL.
                    let downloadURL = downloadUrl.absoluteString
                    print("This is the downloadURL: \(downloadURL)")
                }
            } else {
                print("Error:\n\(error!)")
            }
        });
 */
        
      //  print("URLTEST");
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func swipeThroughProfiles(){
        if GlobalStructureUpload.swipeArray.count > 0{
            for users in 0..<GlobalStructureUpload.swipeArray.count {
                print("\(users) and \(GlobalStructureUpload.swipeArray2[users])")
            }
        }
    }
    
    
    
    var counter = 1
    
    func imageCircles(){
        let number = 6
        
        for c in 4000..<4000+number{
            for subview in self.Card.subviews {
                if (subview.tag == c) {
                    subview.removeFromSuperview()
                }
            }
        }
        
        //download2()
        
        for a in 0..<number{
            if a != (counter-1){
                let imageView = UIImageView(image: #imageLiteral(resourceName: "Circle1"))
                imageView.tag = 4000 + a
                imageView.frame = CGRect(x: (7+(a*30)), y: 8, width: 20, height: 20)
                Card.addSubview(imageView)
            } else {
                let imageView = UIImageView(image: #imageLiteral(resourceName: "Circle2"))
                imageView.tag = 4000 + a
                imageView.frame = CGRect(x: (7+(a*30)), y: 8, width: 20, height: 20)
                Card.addSubview(imageView)
            }
        }
        /*
        for b in 1..<7{
            if (counter / b) == 1 {
                let b = b-1
                let imageView = UIImageView(image: #imageLiteral(resourceName: "Circle2"))
                imageView.tag = 4000 + b
                imageView.frame = CGRect(x: (7+(b*30)), y: 8, width: 20, height: 20)
                Card.addSubview(imageView)
            } 
        }
        */
    }
 
    
    @IBOutlet weak var LeftTap: UIButton!
    @IBAction func LeftTapAction(_ sender: UIButton) {
        if counter > 1 {
            counter = counter - 1
            imageCircles()
            print(counter)
            if DisplayString.isEmpty != true {
                Testing(String:DisplayString,Int: counter,Next: ImageDownload)
                secondCard(String:SecondString,Int: counter,Next: ImageView)
            }
        }
        uploadCounter()
    }
    
    @IBOutlet weak var RightTap: UIButton!
    @IBAction func RightTapAction(_ sender: UIButton) {
        if counter < 6{
        counter = counter + 1
            print(counter)
        imageCircles()
            if DisplayString.isEmpty != true {
                Testing(String:DisplayString,Int: counter,Next: ImageDownload)
                secondCard(String:SecondString,Int: counter,Next: ImageView)
            }
        }
        uploadCounter()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        orderData()
        super.viewWillAppear(animated)
        print("Upload Page is loaded")
    }
    
}

extension UIViewController
{
    @objc func swipeActionUpload(swipe: UISwipeGestureRecognizer)
    {
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "SwipeRightChat", sender: self)
        case 2:
            performSegue(withIdentifier: "SwipeLeftProfile", sender: self)
        default:
            break
        }

        
    }
}

