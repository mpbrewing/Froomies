//
//  ProfileViewController.swift
//  FR3
//
//  Created by Michael Brewington on 1/7/19.
//  Copyright © 2019 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    let db = Firestore.firestore()
    
    var currentImageView: UIImageView?
    
    var DisplayText = ""
    
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
                
                let latMax = document.get("current") as! String
                print(latMax)
               // self.AboutMeTextView.text = "\(latMax)"
                self.DisplayText = "\(latMax)"
                
                if self.DisplayText != "" {
                self.Testing(String: self.DisplayText, Int: self.counter, Next: self.profilephoto)
                self.uploadExistingName(UserID: self.DisplayText)
                }
                
            } else {
                print("Document does not exist in cache")
            }
        }
    }
    
    func download3(){
        
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        //  let ref = db.collection("users").document("\(userId!)")
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                
                let latMax = document.get("counter") as! Int
                print(latMax)
                // self.AboutMeTextView.text = "\(latMax)"
                self.counter = latMax
                 self.imageCircles()
            } else {
                print("Document does not exist in cache")
            }
        }
        
    }
    
    @IBOutlet weak var LeftButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    @IBAction func LeftButtonTap(_ sender: UIButton) {
        if counter > 1 {
            counter = counter - 1
            imageCircles()
            print(counter)
            if DisplayText.isEmpty != true {
                Testing(String:DisplayText,Int: counter,Next: profilephoto)
                
            }
        }
        uploadCounter()
    }
    @IBAction func RightButtonTap(_ sender: UIButton) {
        if counter < 6{
            counter = counter + 1
            print(counter)
            imageCircles()
            if DisplayText.isEmpty != true {
                Testing(String:DisplayText,Int: counter,Next: profilephoto)
              
        }
    }
        uploadCounter()
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
    
    var counter = 1
    
    func imageCircles(){
        let number = 6
        
        for c in 4000..<4000+number{
            for subview in self.stretchView.subviews {
                if (subview.tag == c) {
                    subview.removeFromSuperview()
                }
            }
        }
        
        for a in 0..<number{
            if a != (counter-1){
                let imageView = UIImageView(image: #imageLiteral(resourceName: "Circle1"))
                imageView.tag = 4000 + a
                imageView.frame = CGRect(x: (7+(a*30)), y: 8, width: 20, height: 20)
                
                stretchView.addSubview(imageView)
            } else {
                let imageView = UIImageView(image: #imageLiteral(resourceName: "Circle2"))
                imageView.tag = 4000 + a
                imageView.frame = CGRect(x: (7+(a*30)), y: 8, width: 20, height: 20)
              
                stretchView.addSubview(imageView)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Storage.storage()
    //    let storeRef = store.reference()
          test()
        download3()
        download2()
        
        
      //  let db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        
       // uploadExistingName(UserID: "7fBtanpGhHYtrLoecI0tdRUsReY2")
        
        profilephoto.layer.masksToBounds = true
        downarrow.layer.masksToBounds = true
        
        scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: 1000)
     //   scrollViewDidScroll(scrollview)
      
        //
        
    }
    
    func test(){
        view.insertSubview(profilephoto, at: 0)
        scrollview.addSubview(stretchView)
        stretchView.addSubview(profilephoto)
         scrollview.addSubview(downarrow)
         scrollview.addSubview(Name)
        stretchView.topAnchor.constraint(equalTo: self.scrollview.topAnchor).isActive=true
        self.automaticallyAdjustsScrollViewInsets = false
        scrollview.delegate = self
        //scrollview.delegate = (self as! UIScrollViewDelegate)
        
    }
    func test2(){
        let imageHeight = profilephoto.frame.height
        
        let newOrigin = CGPoint(x: 0, y: -imageHeight)
        
        //scrollview.contentOffset = newOrigin
        //scrollview.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0,right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0
        {
            profilephoto.frame.origin.x = 0
            profilephoto.frame.origin.y = offsetY
            profilephoto.topAnchor.constraint(equalTo: scrollView.topAnchor)
            scrollView.topAnchor.constraint(equalTo: profilephoto.topAnchor)
            //profilephoto.frame.size.width =
            profilephoto.frame.size.height =  392.5 + -offsetY
            print(offsetY)
            print(profilephoto.frame.size.height)
            for c in 4000..<4007{
                for subview in self.stretchView.subviews {
                    if (subview.tag == c) {
                        subview.frame.origin.y = offsetY + 8
                    }
                }
            }
        }
        else
        {
            for c in 4000..<4007{
                for subview in self.stretchView.subviews {
                    if (subview.tag == c) {
                        subview.frame.origin.y = 8
                    }
                }
            }
            profilephoto.frame.size.height = profilephoto.frame.height
        }
    }
    
    @IBOutlet weak var stretchView: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //   self.setNeedsStatusBarAppearanceUpdate()
       // self.navigationController?.isNavigationBarHidden =  true
        
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var downarrow: UIButton!
    
    @IBAction func downArrow(_ sender: UIButton) {
        performSegue(withIdentifier: "ProfileToButtonSegue", sender: self)
    }
    
    
    @IBOutlet weak var profilephoto: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    
    override func viewDidLayoutSubviews() {
        scrollview.isScrollEnabled = true
        test2()
        // Do any additional setup after loading the view
    }
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        profilephoto.contentMode = .scaleAspectFill
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 460), 460)
        profilephoto.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
   */
    
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
    
    func Testing(String: String, Int: Int, Next: UIImageView){
        let store = Storage.storage()
        let storeRef = store.reference()
        
       // let db = Firestore.firestore()
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
    
}
