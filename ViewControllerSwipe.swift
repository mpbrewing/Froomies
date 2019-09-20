//
//  ViewControllerSwipe.swift
//  FR3
//
//  Created by Michael Brewington on 12/14/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class MyCell: UICollectionViewCell {
   
   
    override func awakeFromNib() {
        super.awakeFromNib()
 }

}
/*
struct MemeModel {
    let image: UIImage
    let name: String
}
*/
class ViewControllerSwipe: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    

    var currentImageView: UIImageView?
    
    var db = Firestore.firestore()
    

   // var profilePhoto : UIImageView!
   // let profilePhoto = UIImageView()
   // let profileButton2 = UIButton()
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped -- Open Chat")
       performSegue(withIdentifier: "MessageView", sender: self)
        print(GlobalSwipe.name)
    }
    
      struct GlobalSwipe {
        static var matchArray = [String](repeating:"",count: 0)
        static var name = ""
    }
   
    func uploadExistingName(UserID: String, number: Int)  {
        
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        //let userId = Auth.auth().currentUser?.uid
        let ref = db.collection("users").document("\(UserID)")
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                if let latMax2 = document.get("name") as! String?{
                print(latMax2)
                GlobalSwipe.name = "\(latMax2)" as String
                self.nameLabel(Number: number, String: GlobalSwipe.name)
                }
                
               // self.Name.text = "\(latMax2!)"
             //   self.Name.font = UIFont.boldSystemFont(ofSize: 24.0)
            } else {
                print("Document does not exist in cache")
            }
        }
    }
    func uploadExistingNameTesting(UserID: String, UILabel: UILabel)  {
        
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        //let userId = Auth.auth().currentUser?.uid
        let ref = db.collection("users").document("\(UserID)")
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                if let latMax2 = document.get("name") as! String?{
                    print(latMax2)
                    UILabel.text = "\(latMax2)"
                }
            } else {
                print("Document does not exist in cache")
            }
        }
    }
    //var name = ""
    //CGFloat(150+110*(Number-1))
    func nameLabel(Number: Int, String: String){
        let label4 = UILabel(frame: CGRect(x: 140 + CGFloat(110*(Number-1)), y: 84, width: 60, height: 20))
        label4.tag = 7000+Number
        print(label4.frame.midX)
        if GlobalSwipe.name != "" {
            label4.text = "\(String)"
        } else {
            //label4.text = "test"
        }
        label4.lineBreakMode = .byCharWrapping
        label4.textColor = .black
        label4.alpha = 1
        label4.font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
       
        label4.clipsToBounds = false
        label4.adjustsFontForContentSizeCategory = true
        label4.adjustsFontSizeToFitWidth = true
        label4.autoresizesSubviews = true
        label4.baselineAdjustment = .none
      
         scroller.addSubview(label4)
    }
    
    func imageCircles(){
        let number = self.matches
        
        for c in 5000..<5000+number{
            for subview in self.scroller.subviews {
                if (subview.tag == c) {
                    subview.removeFromSuperview()
                }
            }
        }
        
        //download2()
      //  let profilePhoto = UIImageView()
       
        
             //   let profilePhoto = UIImageView(image: #imageLiteral(resourceName: "Circle1"))
        print("MATCH ARRAY COUNT \(GlobalSwipe.matchArray.count)")
        
        
        if GlobalSwipe.matchArray.count > 0 {
            for a in 0..<GlobalSwipe.matchArray.count {
                if GlobalSwipe.matchArray[a] != ""{
                let profilePhoto = UIImageView()
                uploadExisting(String: "\(GlobalSwipe.matchArray[a])", Int: 1, Next: profilePhoto, val: a)
                profilePhoto.tag = 5000+a
                    
                   
                profilePhoto.frame = CGRect(x:CGFloat(130+110*(a-1)), y: 0, width: 80, height: 80)
                    print(profilePhoto.frame.midX)
                   // profilePhoto.frame.origin.x = CGFloat(15+110*(a-1))
                profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
                profilePhoto.contentMode = .scaleAspectFill
                scroller.addSubview(profilePhoto)
                    
                     let profileButton2 = UIButton()
                profileButton2.frame = CGRect(x: CGFloat(130+110*(a-1)), y: 0, width: 80, height: 80)
                    profileButton2.tag = 6000+a
                profileButton2.layer.cornerRadius = profileButton2.frame.height/2
            //    profileButton2.sizeToFit()
                
        profileButton2.setBackgroundImage(profilePhoto.image, for: UIControlState.normal)
        profileButton2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
      //  profileButton2.addTarget(self, action: Selector(("buttonAction")), for:UIControlEvents.touchUpInside)
        scroller.addSubview(profileButton2)
                }
            }
        }
        
        
       
        let label2 = UILabel(frame: CGRect(x: 17, y: 86, width: 90, height: 21))
        label2.text = "Matches"
        label2.textColor = .red
        label2.alpha = 1
        label2.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)

        view.addSubview(label2)
        let label3 = UILabel(frame: CGRect(x: 17, y: 240, width: 90, height: 21))
        label3.text = "Messages"
        label3.textColor = .red
        label3.alpha = 1
        label3.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        
        view.addSubview(label3)
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
        fetchUsers2()
       view.addSubview(collection)
        scroller.contentSize = CGSize(width: 1000, height: 115)
      // scrollview2.contentSize = CGSize(width: scrollview2.contentSize.width, height: 1000)
        collection.reloadData()
      
       // self.profilePhoto!.clipsToBounds = true
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeActionChat(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        scroller.isScrollEnabled = true
        collection.collectionViewLayout.invalidateLayout()
     //   scrollview2.isScrollEnabled = true
      super.viewDidLayoutSubviews()
         print("viewDidLayoutSubviews")
        // Do any additional setup after loading the view
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
      //  collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(GlobalSwipe.matchArray.count)
        var count = 2
        if GlobalSwipe.matchArray.count > 0 {
            count = GlobalSwipe.matchArray.count
        }
        return matches-1
    }
    
    struct users {
        let userId: String
    }
    
    var collString : URL? = nil
    
    
    @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
       // print(GlobalSwipe.matchArray[indexPath.row])
        myCell.backgroundColor = UIColor.white
       // let input = myCell.frame.origin.y
        print(myCell.frame.origin.y)
        refresh(input: indexPath.row)
        for _ in indexPath {
        collection.addSubview(CellLabel(input: indexPath.row))
        collection.addSubview(CellImage(input: indexPath.row))
            
        }
        
        return myCell
    }
    
    func refresh(input: Int){
        let c = 10000+input
        let d = 20000+input
        
            for subview in collection.subviews {
                if (subview.tag == c) {
                    subview.removeFromSuperview()
                }
                if (subview.tag == d) {
                    subview.removeFromSuperview()
                }
            }
        
    }
    
    func CellLabel(input: Int)->UILabel{
        let label = UILabel(frame: CGRect(x: 96, y: 20+(input*90), width: 100, height: 20))
        label.tag = 10000 + input
        label.lineBreakMode = .byCharWrapping
        label.textColor = .black
        label.alpha = 1
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.clipsToBounds = false
        uploadExistingNameTesting(UserID: "hpFqL8gul7V8VFXLvStxNH9ozaC2", UILabel: label)
        //label.text = "Test"
        label.baselineAdjustment = .none
        return label
    }
    
    func CellImage(input: Int)->UIImageView{
        let profilePhoto = UIImageView()
        
        profilePhoto.tag = 20000 + input
        uploadExistingTesting(String: "hpFqL8gul7V8VFXLvStxNH9ozaC2", Int: 1, Next: profilePhoto)
        
        profilePhoto.frame = CGRect(x:20, y: 20+(input*90), width: 70, height: 70)
        profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
        profilePhoto.contentMode = .scaleAspectFill
        //scroller.addSubview(profilePhoto)
        return profilePhoto
    }
 
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 370, height: 90)
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "MessageView", sender: self)
        print("User tapped on item \(indexPath.row)")
    }
    
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        collection.dataSource = self as UICollectionViewDataSource
        collection.delegate = self as UICollectionViewDelegate
        collection.contentInset = UIEdgeInsets.zero
        collection.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        //collection.reloadData()
        //collection.contentSize = CGSize(width: collection.intrinsicContentSize.width, height: collection.intrinsicContentSize.height)
        print(collection.frame.height)
        print(collection.frame.width)
    }
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var scroller: UIScrollView!
    
    func fetchUsers2(){
        print("Fetch Users")
        let userId = Auth.auth().currentUser?.uid
        let testEmail = Auth.auth().currentUser!.email
        //self.matches = 0
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let schoolEmail = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(schoolEmail)")
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                
                let latMax = document.get("matches") as! Int
                print(latMax)
                // self.AboutMeTextView.text = "\(latMax)"
                self.matches = latMax
                
            } else {
                print("Document does not exist in cache")
            }
            let ref2 = self.db.collection("users").document("\(userId!)").collection("profile").document("\(schoolEmail)").collection("List").document("MatchBoolean")
            
            //let GlobalSwipe.matchArray = = [String](repeating:"",count: 0)
            
            ref2.getDocument(source: .cache) { (document, error) in
                if let document = document {
                    //let a = 1
                    //       for a in 0..<self.matches+1 {
                    for a in 0..<self.matches{
                        if let latMax = document.get("Match\(a)") as! String?{
                            print(latMax)
                            // self.AboutMeTextView.text = "\(latMax)"
                            // self.matches = latMax
                            if a > 0 {
                                if GlobalSwipe.matchArray.count > 0 {
                                if (latMax != GlobalSwipe.matchArray[a-1]) {
                                    //if latMax != GlobalSwipe.matchArray[a] {
                                        GlobalSwipe.matchArray.append(latMax)
                                        self.imageCircles()
                                  //  }
                                }
                                }
                                 self.imageCircles()
                            } else if a<=0{
                                if GlobalSwipe.matchArray.count <= 0 {
                                
                                GlobalSwipe.matchArray.append(latMax)
                                self.imageCircles()
                                }
                            }
                        }
                    }
                    //        }
                } else {
                    print("Document does not exist in cache")
                }
                print("COUNT \(GlobalSwipe.matchArray.count)")
                //self.imageCircles()
            }
        }
    }
    
    var matches = 0
    
    //var matchArray = [String](repeating:"",count: 0)
    
    func uploadExistingTesting(String: String, Int: Int, Next:UIImageView){
       // makePhoto()
    //    uploadExistingName(UserID: String, number: val)
        //self.currentImageView = self.profilePhoto
        self.currentImageView = Next
        
        let store = Storage.storage()
        let storeRef = store.reference()
        
        self.db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        let userID = Auth.auth().currentUser!.uid
        
        print(userID)
        
        self.currentImageView?.clipsToBounds = true
        
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
    
    func uploadExisting(String: String, Int: Int, Next:UIImageView, val: Int){
        // makePhoto()
        uploadExistingName(UserID: String, number: val)
        //self.currentImageView = self.profilePhoto
        self.currentImageView = Next
        
        let store = Storage.storage()
        let storeRef = store.reference()
        
        self.db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        let userID = Auth.auth().currentUser!.uid
        
        print(userID)
        
        self.currentImageView?.clipsToBounds = true
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var profileButton: UIButton!
    
    @IBAction func profileButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SwipeLeftProfile", sender: self)
    }
    @IBOutlet var uploadButton: UIButton!
    @IBAction func uploadButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SwipeLeftUpload", sender: self)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController
{
    @objc func swipeActionChat(swipe: UISwipeGestureRecognizer)
    {
        switch swipe.direction.rawValue {
        case 2:
            performSegue(withIdentifier: "SwipeLeftUpload", sender: self)
        default:
            break
        }
    }
}

