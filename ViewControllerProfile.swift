//
//  ViewControllerProfile.swift
//  FR3
//
//  Created by Michael Brewington on 12/14/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class ViewControllerProfile: UIViewController {
    
    var currentImageView: UIImageView?
    var db = Firestore.firestore()
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    func uploadExisting(String: String, Int: Int, Next: UIImageView){
        
        self.currentImageView = self.profilePhoto
        
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
    
    override func viewDidLoad() {
        profilePhoto.layer.masksToBounds = true;
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeActionProfile(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        let userID = Auth.auth().currentUser!.uid
        uploadExisting(String:"\(userID)",Int: 1,Next: profilePhoto)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var EditProfileButton: UIButton!
    
    @IBAction func EditProfileSegue(_ sender: UIButton) {
        self.performSegue(withIdentifier: "EditProfileSegue", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet var uploadButton: UIButton!
    @IBAction func uploadButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SwipeRightUpload", sender: self)
    }
    
    @IBOutlet var chatButton: UIButton!
    @IBAction func chatButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SwipeRightChat", sender: self)
    }
    
    
    @IBOutlet weak var TestQButton: UIButton!
    @IBAction func TestQButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ProfiletoTestSegue", sender: self)
    }
    
    
}
extension UIViewController
{
    @objc func swipeActionProfile(swipe: UISwipeGestureRecognizer)
    {
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "SwipeRightUpload", sender: self)
            
        default:
            break
        }
    }
}

