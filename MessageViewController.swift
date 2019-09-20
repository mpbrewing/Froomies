//
//  MessageViewController.swift
//  FR3
//
//  Created by Michael Brewington on 3/19/19.
//  Copyright © 2019 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class MessageViewController: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var db = Firestore.firestore()
    var currentImageView: UIImageView?
    
    @IBOutlet weak var Return: UIButton!
    @IBOutlet weak var Button: UIButton!
    @IBAction func ButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ChatToProfile", sender: self)
    }
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Flag: UIButton!
    @IBAction func ReturnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ViewController", sender: self)
    }
    @IBAction func FlagAction(_ sender: UIButton) {
    }
    

    
    func CellImage()->UIImageView{
        let profilePhoto = UIImageView()
        
       // profilePhoto.tag = 20000 + input
        uploadExistingTesting(String: "hpFqL8gul7V8VFXLvStxNH9ozaC2", Int: 1, Next: profilePhoto)
        uploadExistingNameTesting(UserID: "hpFqL8gul7V8VFXLvStxNH9ozaC2", UILabel: Name)
        
        profilePhoto.frame = CGRect(x: 138, y: 11, width: 40, height: 40)
        profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
        profilePhoto.contentMode = .scaleAspectFill

        return profilePhoto
    }
    
    func uploadExistingTesting(String: String, Int: Int, Next:UIImageView){

        self.currentImageView = Next
        
        let store = Storage.storage()
        let storeRef = store.reference()
        
        self.db = Firestore.firestore()
        let settings = self.db.settings
      //  settings.areTimestampsInSnapshotsEnabled = true
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
    
    func sendButton()->UIButton{
        let button = UIButton(type: .custom)

        button.tag = 981023
        button.frame = CGRect(x: CGFloat(chatInput.frame.size.width - 55), y: CGFloat(0), width: CGFloat(40), height: CGFloat(30))
       // print(button.frame)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 13.0)
        button.autoresizesSubviews = true
        if chatInput.text.count < 1 {
        button.setTitleColor(.gray, for: .normal)
        } else {
            button.setTitleColor(.red, for: .normal)
        }
        button.addTarget(self, action: #selector(refresh), for: .touchUpInside)

        chatInput.layer.cornerRadius = 11.0
        chatInput.clipsToBounds = true
        
        
        return button
    }
    
    @objc func refresh(sender: UIButton!) {
        print(chatInput.text)
        uploadMessage(User: "hpFqL8gul7V8VFXLvStxNH9ozaC2")
        pullMessages()
        chatInput.text = ""
    }
    
    var lines = 1
    
    @IBOutlet weak var chatInput: UITextView!
    
    var previousRect = CGRect.zero
    
    func textViewDidChange(_ textView: UITextView) {
        let pos = textView.endOfDocument
        
        let currentRect = textView.caretRect(for: pos)
        self.previousRect = self.previousRect.origin.y == 0.0 ? currentRect : previousRect
        
        print("Current \(currentRect.origin.y) --- Previous \(previousRect.origin.y) --- \(textView.frame.height)")
        
        if textView.frame.height == 29.5 {
            if currentRect.origin.y == -1 {
                if previousRect.origin.y == -1{
                    if lines == 2{
                TextView.frame.origin.y = TextView.frame.origin.y + 17
                collection.frame.origin.y = collection.frame.origin.y + 17
                lines -= 1
                    }
                }
            }
        }
        
        if (currentRect.origin.y == -1 || currentRect.origin.y > previousRect.origin.y || currentRect.origin.y != CGFloat.infinity ){
            
            if currentRect.origin.y > previousRect.origin.y{
            print("Started New Line")
            lines += 1
               print(lines)
                
             TextView.frame.origin.y = TextView.frame.origin.y - 17
             collection.frame.origin.y = collection.frame.origin.y - 17
                
                if currentRect.origin.y != -1{
                    print(currentRect.origin.y)
                }
                

                
            } else if (previousRect.origin.y > currentRect.origin.y){
               
                
                if currentRect.origin.y != -1{
                print("Removed A Line")
                 lines -= 1
                print(lines)
                TextView.frame.origin.y = TextView.frame.origin.y + 17
                collection.frame.origin.y = collection.frame.origin.y + 17
                print(textView.frame.height)
                } else {
                
                    print(textView.frame.height)
                    print("WHAT")
 
                }
                
                print(previousRect.origin.y)
                print(currentRect.origin.y)
                
            }
            let fixedWidth = textView.frame.size.width
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(CGFloat.greatestFiniteMagnitude)))
            let val = CGFloat(newSize.height+10)
            textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: val)
        }
        
        previousRect.origin.y = currentRect.origin.y
        
        for subview in chatInput.subviews {
            if subview.tag == 981023 {
                subview.removeFromSuperview()
                self.chatInput.addSubview(sendButton())
            }
        }
     
        
    }
    
    
    
    func textView(_ shouldTextview: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (shouldTextview.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
       // print(numberOfChars)
        return numberOfChars < 120    // 10 Limit Value
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        print("begin")
    }
 
    func textViewDidEndEditing(_ textView: UITextView) {

        print("end")
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.performWithoutAnimation {
            
        //    self.collection.setNeedsLayout()
            //self.collection.layoutIfNeeded()
        }
        super.viewDidAppear(animated)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var TextView: UIView!

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIView.performWithoutAnimation {
            
         //   self.collection.setNeedsLayout()
           // self.collection.layoutIfNeeded()
        }
       //collection.collectionViewLayout.invalidateLayout()

        print("viewWillLayoutSubviews")
    }

 
    @objc func keyboardWillShow(sender: NSNotification) {
        print("show")
        self.TextView.frame.origin.y = 510 - testAnchor()
        self.collection.frame.origin.y = 90 - testAnchor()
          // Move view 150 points upward
    }
  
    @objc func keyboardWillHide(sender: NSNotification) {
        print("hide")

        self.TextView.frame.origin.y = 310 - testAnchor()
        self.collection.frame.origin.y = -120 - testAnchor()

    }
    
    
    
    func uploadMessage(User: String){
        let userId = Auth.auth().currentUser?.uid
        
        
        let ref = self.db.collection("users").document("\(userId!)").collection("messages").document("users").collection("hpFqL8gul7V8VFXLvStxNH9ozaC2").document()
        
        ref.setData([
            "Message": "\(chatInput.text!)",
            "Sender": "\(userId!)",
            "Recipient": "\(User)",
            "Time": "\(Date().timeIntervalSinceReferenceDate)"
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.pullMessages()
        }
       
        UIView.performWithoutAnimation {
            
        //    self.collection.reloadData()
          //  self.collection.setNeedsLayout()
           // self.collection.layoutIfNeeded()
        }
        
        view.insertSubview(TextView, aboveSubview: collection)
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        topView.addSubview(CellImage())
        chatInput.addSubview(sendButton())
        
  
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UIView.performWithoutAnimation {
            
       //     self.collection.setNeedsLayout()
          //  self.collection.layoutIfNeeded()
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        collection!.collectionViewLayout = layout
        
        self.view.addSubview(collection)
        collection.dataSource = self as UICollectionViewDataSource

        collection.delegate = self as UICollectionViewDelegate

        print(collection.frame.height)
        print(collection.frame.width)
        print("viewDidLayoutSubviews")
 
    }

    
    @IBOutlet weak var collection: UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    if textArray.count > 0 {
    //        return textArray.count
    //    }
        return messages.count
    }
    
    func setTime(time: Double){
        let timeStampDate = NSDate(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        print(dateFormatter.string(from: timeStampDate as Date))
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  collectionView.collectionViewLayout.invalidateLayout()
        
       // collectionView.contentInset = UIEdgeInsets.zero
        
        
       let TheCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
       // TheCell.clipsToBounds = true
        
      //  if textArray.count > 0 {
       
       // TheCell.name = "\(textArray[indexPath.row])"
        let message = messages[indexPath.row]
    
        TheCell.name = message.Message!
        
        let userId = Auth.auth().currentUser?.uid
        
        //let seconds = message.Time
        //setTime(time: seconds!)
        
        let  frame = TheCell.Bubble.sizeThatFits(CGSize(width: 250, height: CGFloat.greatestFiniteMagnitude))
        TheCell.Bubble.frame.size = CGSize(width: frame.width, height: frame.height)
       
        TheCell.BubbleWidthAnchor?.constant = frame.width
        
        
        if userId! == message.Sender! {
            TheCell.Bubble.backgroundColor = UIColor.red
            TheCell.value = true
            TheCell.BubbleViewLeftAnchor?.isActive = false
            TheCell.BubbleViewRightAnchor?.isActive = true
          
        } else {
            TheCell.Bubble.backgroundColor = UIColor.gray
            TheCell.value = false
            TheCell.BubbleViewLeftAnchor?.isActive = true
            TheCell.BubbleViewRightAnchor?.isActive = false
        }
        
        return TheCell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
      let TheCell = Bundle.main.loadNibNamed("CollectionViewCell", owner: self, options: nil)?.first as! CollectionViewCell
        
     //   if textArray.count > 0 {
     //       TheCell.Bubble.text = "\(textArray[indexPath.row])"
    //   }
        let message = messages[indexPath.row]
        TheCell.name = message.Message!
    
        let  frame = TheCell.Bubble.sizeThatFits(CGSize(width: 250, height: CGFloat.greatestFiniteMagnitude))
        
        
        let  frame2 = TheCell.sizeThatFits(CGSize(width: 370, height: frame.height))
      
        //let value = frame2.width
      //  TheCell.BubbleWidthAnchor?.constant = value
        //TheCell.BubbleValue?.constant = value
      //  let userId = Auth.auth().currentUser?.uid
        
        
         return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height:frame2.height);
        
    }
    
    
    var totalText = 0
    
    var textArray = [String](repeating: "", count: 0)
    
    var messages = [Message]()
    
    func pullMessages(){
        let userId = Auth.auth().currentUser?.uid
        
        totalText = 0
        
        messages.removeAll()
        
        db.collection("users").document("\(userId!)").collection("messages").document("users").collection("hpFqL8gul7V8VFXLvStxNH9ozaC2").order(by: "Time").getDocuments() { (querySnapshot,  err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                  for document in querySnapshot!.documents {
                    self.totalText += 0
                    self.textArray.append((document.get("Message")) as! String)
                    print("\(document.documentID) => \(document.data())")
                    let message = Message(with: document.data())
                    
                    self.messages.append(message)
                
                 // print(document.get("Message") ?? "")
                 
                  //  DispatchQueue.main.async {
                       // self.collection.reloadData()
                  //      self.collection.setNeedsLayout()
                      // self.collection.layoutIfNeeded()
                  //  }
                    self.collection.reloadData()
                    
                  //  self.collection.setNeedsLayout()
                  //  self.collection.layoutIfNeeded()
                    
                    
                    if self.messages.count > 0 {
                        let lastItemIndex = NSIndexPath(item: self.messages.count-1, section: 0)
                        self.collection?.scrollToItem(at: lastItemIndex as IndexPath, at: .bottom, animated: false)
                    }
 
                }
                
            }
            
        }
    
        
    }
    
    func testAnchor()->CGFloat{
        let value = CGFloat(((self.lines)*(10)))
        print(value)
        return value
    }
    
    @IBOutlet weak var topView: UIView!
    
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
       
        super.viewDidLoad()
        
        UIView.performWithoutAnimation {
            
        //    self.collection.setNeedsLayout()
           // self.collection.layoutIfNeeded()
        }
        
        topView.layer.zPosition = 1
        self.view.bringSubview(toFront: topView)
        topView.isUserInteractionEnabled = true
        
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        collection.register(nibCell, forCellWithReuseIdentifier: "CollectionViewCell")

        chatInput.isScrollEnabled = false
        TextView.addSubview(chatInput)
        
        collection.contentInset.bottom = 8
        collection.contentInset.top = 8
        chatInput.clipsToBounds=true
        chatInput.contentInset = UIEdgeInsets.zero
        chatInput.delegate = self as UITextViewDelegate
        chatInput.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 70)
      
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.white

    }
    
}
