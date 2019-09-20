//
//  MainViewController.swift
//  FR3
//
//  Created by Michael Brewington on 8/31/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

//Questionnaire View -> Looking For -> Social/Spotify -> Design Profile View Graphics -> Chat element/graphics -> Fill out profile view elements -> Upload View information/stars -> 1/1 Match -> Clean up tables -> Create firebase elements in Sign Up -> Connect proper wireframe -> Limit Tags -> Code algorithm -> Demo aglorithm questions -> Clean up(Have Dad's friend run through code) -> Demo App with friends -> QA to see if it can handle code -> BETA!!!

import Foundation
import UIKit
import Firebase


class MainViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
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
                
                let latMax = document.get("school") as! String
                print(latMax)
                self.AboutMeTextView.text = "\(latMax)"
                

                
            } else {
                print("Document does not exist in cache")
            }
        }
    }
    
    func download3(){
            
            let userId = Auth.auth().currentUser?.uid
            //let ref = db.collection("users").document("\(userId!)")
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Looking")
            
            //If it doesnt exist return empty
            
            ref
                .addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        GlobalVariables.tags2String = ""
                        return
                    }
                    let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                    //     print("\(source) data: \(document.data() ?? [:])")
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        GlobalVariables.tags2String = ""
                        return
                    }
                    
                    
                    for b in 0..<GlobalVariables.list.count{
                        let text2 = GlobalVariables.list[b]
                        guard let latMax = document.get("\(text2)") as? String else {
                            return
                        }
                        
                        if latMax.isEmpty != true {
                            GlobalVariables.textValue2 = latMax
                            
                            if GlobalVariables.textValue2 == "1" {
                                GlobalVariables.tags2String = GlobalVariables.tags2String + "\(text2), "
                                GlobalVariables.globalArray2[b] = 1
                                
                            } else {
                                GlobalVariables.globalArray2[b] = 0
                            }
                        }
                    }
                    
                    GlobalVariables.next2String = String(GlobalVariables.tags2String.dropLast(2))
                    GlobalVariables.next2String = "  \(GlobalVariables.next2String)"
                    GlobalVariables.tags2String = ""
                    //    print("Current data: \(data)")
                    UIView.performWithoutAnimation {
                        if GlobalVariables.next2String.isEmpty != true {
                            self.LookingButton.setTitle(GlobalVariables.next2String, for: [])
                        }
                    }
        }
        
    }
    
    func download5(){
        let userId = Auth.auth().currentUser?.uid
        //let ref = db.collection("users").document("\(userId!)")
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Likes")
        ref
            .addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    GlobalVariables.tags3String = ""
                    return
                }
                let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                //     print("\(source) data: \(document.data() ?? [:])")
                guard let data = document.data() else {
                    print("Document data was empty.")
                    GlobalVariables.tags3String = ""
                    return
                }
                GlobalVariables.tags3String = ""
                
                for b in 0..<GlobalVariables.likes.count{
                    let text2 = GlobalVariables.likes[b]
                    guard let latMax = document.get("\(text2)") as? String else {
                        return
                    }
                    
                    if latMax.isEmpty != true {
                        GlobalVariables.textValue3 = latMax
                        
                        if GlobalVariables.textValue3 == "1" {
                            GlobalVariables.tags3String = GlobalVariables.tags3String + "\(text2), "
                            GlobalVariables.globalArray3[b] = 1
                            
                        } else {
                            GlobalVariables.globalArray3[b] = 0
                        }
                    }
                }
                
                GlobalVariables.next3String = String(GlobalVariables.tags3String)
                GlobalVariables.string1 = "\(GlobalVariables.next3String)"
                GlobalVariables.tags3String = ""
                //   GlobalVariables.next3String = ""
                //    print("Current data: \(data)")
                /*
                UIView.performWithoutAnimation {
                    if GlobalVariables.next3String.isEmpty != true {
                        self.button.setTitle(GlobalVariables.next3String, for: [])
                    }
                }
                */
                let string1 = GlobalVariables.string1
                let att = NSMutableAttributedString(string: "\(string1)");
                att.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: string1.count))
                self.button.setAttributedTitle(att, for: [])
                if string1.isEmpty == true {
                    let att = NSMutableAttributedString(string: "");
                    self.button.setAttributedTitle(att, for: [])
                }
                
        }
    }
    
    func download4(){
        
        let userId = Auth.auth().currentUser?.uid
        //let ref = db.collection("users").document("\(userId!)")
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
      //  let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Likes")
        GlobalVariables.tags3String = ""
        GlobalVariables.next3String = ""

        
        let ref2 = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Dislikes")
        
        ref2
            .addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                     GlobalVariables.tags3String = ""
                    return
                }
                let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                //     print("\(source) data: \(document.data() ?? [:])")
                guard let data = document.data() else {
                    print("Document data was empty.")
                      GlobalVariables.tags3String = ""
                    return
                }
                
                
                for b in 0..<GlobalVariables.likes.count{
                    let text2 = GlobalVariables.likes[b]
                    guard let latMax = document.get("\(text2)") as? String else {
                        return
                    }
                    
                    if latMax.isEmpty != true {
                        GlobalVariables.textValue3 = latMax
                        
                        if GlobalVariables.textValue3 == "1" {
                            GlobalVariables.tags3String = GlobalVariables.tags3String + "\(text2), "
                            GlobalVariables.globalArray3[b] = 1
                            
                        } else {
                            GlobalVariables.globalArray3[b] = 0
                        }
                    }
                }
                /*
                 let string1 = "..."
                 let string2 = "..."
                 let att = NSMutableAttributedString(string: "\(string1)\(string2)");
                 att.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: 0, length: string1.characters.count))
                 att.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSRange(location: string1.characters.count, length: string2.characters.count))
                 button.setAttributedTitle(att, forState: .Normal)
                 
                 
                 */
                GlobalVariables.next3String = String(GlobalVariables.tags3String.dropLast(2))
                GlobalVariables.string2 = "\(GlobalVariables.next3String)"
                
                
                var string1 = GlobalVariables.string1
                var string2 = GlobalVariables.string2
                let string3 = "\(string1)\(string2)"
                print("1--\(string1)")
                print("2--\(string2)")
                if string2.count == 0{
                    string2 = ""
                }
                if string1.count == 0{
                    string1 = ""
                }
                let att = NSMutableAttributedString(string: "\(string1)\(string2)");
                self.button.titleEdgeInsets = UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0)
                if (string1.count != 0) {
                att.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: string1.count))
                }
                
                if (string2.count != 0) {
                    att.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: string1.count, length: string2.count))
                }
                /*
                if string1 == GlobalVariables.tags3String {
                    let att = NSMutableAttributedString(string: "\(GlobalVariables.string1)");
                    att.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: GlobalVariables.string1.count))
                  //   att.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: string1.count, length: string2.count))
                   
                } else if string2 == GlobalVariables.tags3String{
                    let att = NSMutableAttributedString(string: "\(GlobalVariables.string1)\(GlobalVariables.string2)");
                    att.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: GlobalVariables.string1.count))
                     att.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: string1.count, length: string2.count))
                    
                }
                */
               
                
                print("\(string1) and \(string2) and \(string1.count)--\(string2.count)")
                let value = string1.count + string2.count
                print(value)
                
               // GlobalVariables.tags3String = ""
                GlobalVariables.next3String = ""
                GlobalVariables.tags3String = ""
              

                UIView.performWithoutAnimation {
                    if string3.isEmpty != true {
                        self.button.setAttributedTitle(att, for: [])
                    }
                }
                
        }
        self.view.addSubview(button)
    }
    
    var currentImageView: UIImageView?
    
    var db = Firestore.firestore()
    
   // var ref: DocumentReference? = nil
    
    @IBOutlet weak var AboutMeTextView: UITextView!
    
    
    @IBOutlet weak var ProfilePhoto: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func tapToChangeProfile(_sender: UIButton!){
    self.currentImageView = self.ProfilePhoto
        imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated:true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]) {
        if let PickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.currentImageView?.image = PickedImage
            self.currentImageView?.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var Profile2: UIImageView!
    
    @IBAction func tapToChange2(_sender: UIButton!){
        self.currentImageView = self.Profile2
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated:true, completion: nil)
    }
    
        @IBOutlet weak var Profile3: UIImageView!
    
    @IBAction func tapToChange3(_sender: UIButton!){
        self.currentImageView = self.Profile3
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated:true, completion: nil)
    }
    
    @IBOutlet weak var Profile4: UIImageView!
 
    @IBAction func tapToChange4(_ sender: UIButton) {
        self.currentImageView = self.Profile4
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated:true, completion: nil)
    }
    
    @IBOutlet weak var Profile5: UIImageView!
    
    @IBAction func tapToChange5(_ sender: UIButton) {
        self.currentImageView = self.Profile5
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated:true, completion: nil)
    }
    
    @IBOutlet weak var Profile6: UIImageView!
    
    @IBAction func tapToChange6(_ sender: UIButton) {
        self.currentImageView = self.Profile6
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated:true, completion: nil)
    }
    
    
    var previousRect = CGRect.zero
    
    func textViewDidChange(_ didTextview: UITextView) {
        
       
       // print(AboutMeTextView.text)
        print(didTextview.text)

           let pos = didTextview.endOfDocument
           let currentRect = didTextview.caretRect(for: pos)
            // if previousRect != CGRect.zero {
        //    self.previousRect = self.previousRect.origin.y == 0 ? currentRect : previousRect
        //print(pos)
        self.previousRect = self.previousRect.origin.y == 0.0 ? currentRect : previousRect
          print("\(previousRect.origin.y)_\(currentRect.origin.y)")
        
            if (currentRect.origin.y == -1 || currentRect.origin.y > previousRect.origin.y || currentRect.origin.y != CGFloat.infinity ){
                print("Started New Line")
                let fixedWidth = didTextview.frame.size.width
                let newSize = didTextview.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                didTextview.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
               
                
               //  self.view.addSubview(AboutMeTextView)
                Tags.frame.origin.y = newSize.height + 365
                TagsB.frame.origin.y = newSize.height + 395
                QA.frame.origin.y = newSize.height + 425
                Question1.frame.origin.y = newSize.height + 450
           //     QuestionTextView.frame.origin.y = newSize.height + 480
                self.likesLabel.frame.origin.y = newSize.height + 480
                self.button.frame.origin.y = newSize.height + 510
                self.lookingForTag.frame.origin.y = newSize.height + 540
                self.LookingButton.frame.origin.y = newSize.height + 570
                for a in 0..<GlobalVariables.zcount{
                    //label.frame.origin.y = newSize.height + CGFloat(a*455)
                    if a == 0{
                    let fill = 1
                    self.likesLabel.frame.origin.y = newSize.height + CGFloat(fill*480)
                    self.button.frame.origin.y = newSize.height + CGFloat(fill*510)
                    self.lookingForTag.frame.origin.y = newSize.height + CGFloat(fill*540)
                    self.LookingButton.frame.origin.y = newSize.height + CGFloat(fill*570)
                    } else {
                        self.likesLabel.frame.origin.y = newSize.height + CGFloat(a*480)
                        self.button.frame.origin.y = newSize.height + CGFloat(a*510)
                        self.lookingForTag.frame.origin.y = newSize.height + CGFloat(a*540)
                        self.LookingButton.frame.origin.y = newSize.height + CGFloat(a*570)
                    }
                    
                }
                saveData()
               // refresh()
               // refresh2()
                print(GlobalVariables.zcount)
                /*
                if QuestionTextView.alpha == 1{
                    label.frame.origin.y = newSize.height + 455
                    likesLabel.frame.origin.y = newSize.height + 530
                    button.frame.origin.y = newSize.height + 560
                    
                } else {
                    label.frame.origin.y = newSize.height + 455
                    likesLabel.frame.origin.y = newSize.height + 480
                    button.frame.origin.y = newSize.height + 510
                    
                }
                */
                print(newSize.height)
               
        }
            //}
        //previousRect = currentRect
 
    }
    
    
    func textView(_ shouldTextview: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

            let newText = (shouldTextview.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            return numberOfChars < 300    // 10 Limit Value

    }
    
   // var myCustomViewController: CheckboxPopUpViewController = CheckboxPopUpViewController()
    
    
    struct GlobalVariables {
        static var questionsList = ["What are your favorite movies?","What are your favorite books?","Favorite activity?","What are you passionate about?","Favorite meme?","List 5 things you want to do this year","Favorite quote?"]
        static var list = ["Affectionate","Aloof","Ambitious","Amusing","Analytical","Anxious","Artistic","Charismatic","Creative","Curious","Dependable","Emotional","Extroverted","Introverted","Generous","Hard-Working","Diligent","Humorous","Impatient","Impulsive","Inconsistent","Independent","Intelligent","Joyful","Cheerful","Kind","Compassionate","Laid-Back","Lazy","Loyal","Organized","Original","Passionate","Proactive","Quiet","Shy","Sociable","Straight-forward","Stubborn","Sympathetic","Talkative","Temperamental","Moody","Upbeat","Warm-Hearted","Resident","Out of State","International"]
        static var likes = ["Animals and Pets","Babysitting","Beauty and Hair Care","Being a Leader of a Group","Going to Church, Synagogue, or Temple","Listening to Music","Making and Enjoying Art","Playing Sports","Playing an Instrument","Taking Care of Others","The Great Outdoors","Watching TV or Movies","Writing Songs, Stories, and Poems","Visiting Friends","Eating","Playing Video Games","Cooking","Reading","Exercising","Traveling","Learning","Politics","Meeting New People","Fraternities and Sororities","Volunteering","Business and Finance","Drama and Theatre","Journalism","Science and Technology"]
        static var globalArray = [Int](repeating: 0, count: list.count)
        static var questionArray =  [Int](repeating: 0, count: questionsList.count)
        static var tagsString = ""
        static var tags2String = ""
        static var tags3String = ""
        static var next2String = ""
        static var next3String = ""
        static var counter = 0
        static var nextString = ""
        static var AnswerArray = [Int](repeating:0,count: questionsList.count)
        static var LabelArray = [String](repeating:"",count:AnswerArray.count)
        static var globalArray2 = [Int](repeating:0,count:list.count)
        static var globalArray3 = [Int](repeating:0,count:list.count)
        static var testString = ""
        static var textValue = ""
        static var textValue2 = ""
        static var textValue3 = ""
        static var aboutMeValue = ""
        static var questionValue = ""
        static var questionText = ""
        static var string1 = ""
        static var string2 = ""
        static var AnswerString = ""
        static var zcount = 0
        //static var booleanTest: Bool!
        static var visited: Bool!
       // static let textView = UITextView(frame: CGRect(x: 0.0, y: 590.0, width: 320.0, height: 50.0))
        
    }
    
    

    @IBOutlet weak var Tags: UILabel!
    
    @IBOutlet weak var QA: UILabel!
    
    @IBOutlet weak var Question1: UIButton!
    
    @IBAction func QuestionB(_ sender: UIButton) {
        print("Question Button")
        saveData()
    }
    
    
    
    @IBAction func TagsB2(_ sender: UIButton) {
        iteration()
        print("Tag Button")
        self.view.addSubview(TagsB)
    }
 
    @IBOutlet weak var TagsB: UIButton!
    

    
    func uploadExisting(type: UIImageView, number: Int){
        
        self.db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        
            let userID = Auth.auth().currentUser!.uid
        
            let testEmail = Auth.auth().currentUser!.email
        
        
            print(userID)
            
            
            let refTest = Storage.storage().reference(forURL: "gs://froomies3-1.appspot.com/gs:/profiles/\(userID)_\(number).jpg")
            let ProfilePhoto: UIImageView = type
            let placeholderImage = UIImage(named: "placeholder.jpg")
            
            self.currentImageView?.clipsToBounds = true
            self.currentImageView = type
            self.currentImageView?.clipsToBounds = true
        
        /*
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: ".edu")
        
        let ref = self.db.collection("users").document("\(studentId!)").collection("Gender").document("\(userID)")
 */
        
          //let ref = db.collection("users").document("\(userID)")
        
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userID)").collection("profile").document("\(email)")
        
        
          // let ref = self.db.collection("users").document("\(studentId!)").collection("Gender").document("\(userID)")
        
            
            refTest.downloadURL(completion: {
                (url: URL?, error: Error?) in
                if (error == nil) {
                    if let downloadUrl = url {
                        // Get the download URL.
                        let downloadURL = downloadUrl.absoluteString
                        //Upload photo link
                        
                        ref.setData([
                            "photolink_\(number)": downloadURL
                        ], merge: true) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Document added with ID: \(ref.documentID)")
                            }
                        }
                        
                        //
                        print("This is the downloadURL: \(downloadURL)")
                        ProfilePhoto.sd_setImage(with: URL(string: "\(downloadURL)"), placeholderImage: placeholderImage)
                    }
                } else {
                    print("Error:\n\(error!)")
                }
            });
        
    }
    
    func uploadExistingAboutMe(){
        
        self.db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        let userId = Auth.auth().currentUser?.uid
        
       // let ref = db.collection("users").document("\(userId!)")
        
        
         let testEmail = Auth.auth().currentUser!.email
         
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
         
       // let ref = self.db.collection("users").document("\(studentId!)").collection("Gender").document("\(userId!))")
 
        
        
        func download(){
            
            let userId = Auth.auth().currentUser?.uid
            
             let testEmail = Auth.auth().currentUser!.email
             
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
            
            
          //  let ref = db.collection("users").document("\(userId!)")
            
            ref.getDocument(source: .cache) { (document, error) in
                if let document = document {
            
                    let latMax = document.get("aboutMe") as! String
                    print(latMax)
                    self.AboutMeTextView.text = "\(latMax)"
                    self.view.addSubview(self.AboutMeTextView)
                    
                } else {
                    print("Document does not exist in cache")
                }
            }
    }
        download()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
        //download3()
        //test()
        //  print("VIEW DID LOAD - \(GlobalVariables.next2String)")
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.white
        
        if Auth.auth().currentUser != nil{
        iteration()
        uploadExisting(type: ProfilePhoto, number: 1)
        uploadExistingAboutMe()
        uploadExisting(type: Profile2, number: 2)
        uploadExisting(type: Profile3, number: 3)
        uploadExisting(type: Profile4, number: 4)
        uploadExisting(type: Profile5, number: 5)
        uploadExisting(type: Profile6, number: 6)
        saveData()
            likesDislikes()
            lookingFor()
            download3()
            download4()
            download5()
            self.view.addSubview(button)
        }
        
        
        //TagsB.setTitle("1", for: .normal)
       // printQuestion()
        //questionTextBox()
       // self.LookingButton.setTitle(GlobalVariables.next2String, for: [])
     //   refButton()
        
       
     //  self.view.addSubview(LookingButton)
       // saveData()
        //
        //let x = UserDefaults.standard.integer(forKey: "myKey")
        
        AboutMeTextView.delegate = self as? UITextViewDelegate
       // AboutMeTextView.delegate = self
        
        
        imagePicker.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        scroller.contentSize = CGSize(width: scroller.contentSize.width, height: 1000)
        //

        AboutMeTextView.clipsToBounds = true
        AboutMeTextView.contentInset = UIEdgeInsets.zero;
        
        Question1.frame.size = CGSize.init(width: 375, height: 26)
        
        Tags.frame.origin.y = AboutMeTextView.frame.height + 365
        TagsB.frame.origin.y = AboutMeTextView.frame.height + 395
        QA.frame.origin.y = AboutMeTextView.frame.height + 425
        Question1.frame.origin.y = AboutMeTextView.frame.height + 450
        likesLabel.frame.origin.y = AboutMeTextView.frame.height + 480
        likesLabel.frame.origin.y = AboutMeTextView.frame.height + CGFloat(GlobalVariables.zcount*30) + 480
        button.frame.origin.y = AboutMeTextView.frame.height + CGFloat(GlobalVariables.zcount*30) + 510
        lookingForTag.frame.origin.y = AboutMeTextView.frame.height + CGFloat(GlobalVariables.zcount*30) + 540
        LookingButton.frame.origin.y = AboutMeTextView.frame.height + CGFloat(GlobalVariables.zcount*30) + 570
       // refresh()
        
        
        
        /*
        for a in 0..<GlobalVariables.zcount{
            //label.frame.origin.y = newSize.height + CGFloat(a*455)
            if a == 0{
                let fill = 1
                self.likesLabel.frame.origin.y = self.AboutMeTextView.frame.height + (CGFloat(fill*480))
                self.button.frame.origin.y = self.AboutMeTextView.frame.height + (CGFloat(fill*510))
                self.lookingForTag.frame.origin.y = self.AboutMeTextView.frame.height + (CGFloat(fill*540))
                self.LookingButton.frame.origin.y = self.AboutMeTextView.frame.height+(CGFloat(fill*570))
            } else {
                self.likesLabel.frame.origin.y = self.AboutMeTextView.frame.height + CGFloat(a*480)
                self.button.frame.origin.y = self.AboutMeTextView.frame.height + CGFloat(a*510)
                self.lookingForTag.frame.origin.y = self.AboutMeTextView.frame.height + CGFloat(a*540)
                self.LookingButton.frame.origin.y = self.AboutMeTextView.frame.height + CGFloat(a*570)
            }
 
        }*/
        
       // QuestionTextView.frame.origin.y = AboutMeTextView.frame.height + 480
        /*
        if QuestionTextView.alpha == 1{
            label.frame.origin.y = AboutMeTextView.frame.height + 455
            likesLabel.frame.origin.y = AboutMeTextView.frame.height + 530
            button.frame.origin.y = AboutMeTextView.frame.height + 560
            lookingForTag.frame.origin.y = AboutMeTextView.frame.height + 580
            LookingButton.frame.origin.y = AboutMeTextView.frame.height + 610
        } else {
            label.frame.origin.y = AboutMeTextView.frame.height + 455
            likesLabel.frame.origin.y = AboutMeTextView.frame.height + 480
            button.frame.origin.y = AboutMeTextView.frame.height + 510
            lookingForTag.frame.origin.y = AboutMeTextView.frame.height + 520
            LookingButton.frame.origin.y = AboutMeTextView.frame.height + 530
        }
        */
        print("test")
        
        
        
     //
        
    }
    
    func refresh(){
        for c in 1000..<1100{
            for subview in self.view.subviews {
                if (subview.tag == c) {
                    subview.removeFromSuperview()
                }
            }
        }
        for c in 2000..<2100{
            for subview in self.view.subviews {
                if (subview.tag == c) {
                    subview.removeFromSuperview()
                }
            }
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        super.viewDidAppear(animated)
        
    }
    
    @IBOutlet weak var scroller: UIScrollView!
    
    override func viewDidLayoutSubviews() {
        scroller.isScrollEnabled = true
        // Do any additional setup after loading the view
    }
    
    func photoLink() -> Bool {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        _ = Auth.auth().currentUser?.uid
        let userId2 = Auth.auth().currentUser?.uid
        
      //  let ref2 = db.collection("users").document("\(String(userId2!))")
        
        
         let testEmail = Auth.auth().currentUser!.email
         
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId2!)").collection("profile").document("\(email)")
        
        
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let link = document.get("photolink_1") as! String?
                
                if link != nil {
                    GlobalVariables.visited = true
                } else {
                    GlobalVariables.visited = false
                }
                
            } else {
                print("Document does not exist in cache")
            }
        }
        return GlobalVariables.visited
    }
    
    //let QuestionTextView = UITextView(frame: CGRect(x: 0.0, y: 590.0, width: 320.0, height: 50.0))
    /*
    func questionTextBox(){
        
        //scroller.contentInsetAdjustmentBehavior = .automatic
        QuestionTextView.center = self.view.center
        QuestionTextView.textAlignment = NSTextAlignment.left
        QuestionTextView.textColor = UIColor.black
        //QuestionTextView.clearsContextBeforeDrawing = true
        QuestionTextView.backgroundColor = UIColor.white
        QuestionTextView.clipsToBounds = true
        //QuestionTextView.contentInset = UIEdgeInsets.zero
        QuestionTextView.frame.origin.y = AboutMeTextView.frame.height + 480

        QuestionTextView.frame.size = CGSize.init(width: 320.0, height: 50.0)
        
        self.view.addSubview(QuestionTextView)
        
    }
    */
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 750, height: 21))
    
    func saveData(){
        let userID = Auth.auth().currentUser?.uid
       // let ref = db.collection("users").document("\(userID!)").collection("Questions").document("Fields")
        
         let testEmail = Auth.auth().currentUser!.email
         
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userID!)").collection("profile").document("\(email)").collection("List").document("Q&A")
 
        ref
            .addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                  //  GlobalVariables.tagsString = ""
                    return
                }
                let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                print("\(source) data: \(document.data() ?? [:])")
                guard document.data() != nil else {
                    print("Document data was empty.")
                   // GlobalVariables.tagsString = ""
                    return
                }
                //let latMax2 = document.get("aboutMe") as! String?
                for d in 0..<GlobalVariables.questionsList.count{
                    let text3 = "Question_\(d)"
                    guard let text4 = document.get("\(text3)") as! String? else {
                        return
                    }
                    if text4 == "1" {
                        GlobalVariables.AnswerArray[d] = 1
                    } else if text4 == "0"{
                        GlobalVariables.AnswerArray[d] = 0
                    }
                }
                var z : [String] = []
                
                for e in 0..<GlobalVariables.questionsList.count{
                    if GlobalVariables.AnswerArray[e] == 1 {
                        z.append("\(GlobalVariables.questionsList[e])")
                    } else if GlobalVariables.AnswerArray[e] == 0{
                        self.makeLabel(number: e, item: "\(GlobalVariables.questionsList[e])", count: z.count, value: 0, place: 0)
                    }
                    self.refresh()
                    for a in 0..<z.count{
                        self.makeLabel(number: e, item: z[a], count: z.count, value: 1, place: a)
                    }
                    self.saveZ(z: z.count)
                }
        }
    }
    
    func saveZ(z:Int){
        GlobalVariables.zcount = z
    }
    
    func makeLabel(number:Int,item:String,count:Int,value:Int,place:Int){
        

        if value == 1{
        UIView.performWithoutAnimation {
                let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 750, height: 21))
                label2.tag = 1000 + number
                let screenBounds = UIScreen.main.bounds
                let width = screenBounds.width
                label2.center = CGPoint(x: Int(width/2), y: (512+(place*80)))
                print(label2.centerXAnchor)
                label2.textAlignment = NSTextAlignment.center
                //label2.sizeToFit()
                label2.numberOfLines = 2
                label2.text = "\(item)"
                label2.alpha = 1
            
                self.Question1.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
                self.likesLabel.frame.origin.y = self.AboutMeTextView.frame.height + CGFloat(530+(place*80))
                self.button.frame.origin.y = self.AboutMeTextView.frame.height + CGFloat(560+(place*80))
                self.lookingForTag.frame.origin.y = self.AboutMeTextView.frame.height + CGFloat(590+(place*80))
                self.LookingButton.frame.origin.y = self.AboutMeTextView.frame.height + CGFloat(620+(place*80))
                label2.frame.origin.y = AboutMeTextView.frame.height + CGFloat(455+(place*80))
            
                label2.tag = 1000 + number
                self.view.addSubview(label2)
            
                makeButton(number: number, value: value, place: place)
        }
        }
        if value == 0 {
            for subview in self.view.subviews {
                if (subview.tag == 1000 + number) {
                    subview.removeFromSuperview()
                }
                makeButton(number: number, value: value, place: place)
        }
        }
          if count == 0 {
            self.Question1.backgroundColor = .white
            self.likesLabel.frame.origin.y = self.AboutMeTextView.frame.height + 480
            self.button.frame.origin.y = self.AboutMeTextView.frame.height + 510
            self.lookingForTag.frame.origin.y = self.AboutMeTextView.frame.height + 540
            self.LookingButton.frame.origin.y = self.AboutMeTextView.frame.height + 570
        }
 
    }
    
    
    func makeButton(number: Int,value:Int,place: Int){
        if value == 1{
            let QuestionTextView2 = UITextView(frame: CGRect(x: 0.0, y: 590.0, width: 320.0, height: 50.0))
            QuestionTextView2.tag = 2000 + number
            
         
        downloadbutton(testtextview: QuestionTextView2)
            
            
        QuestionTextView2.center = self.view.center
        QuestionTextView2.textAlignment = NSTextAlignment.left
        QuestionTextView2.textColor = UIColor.black
        //QuestionTextView.clearsContextBeforeDrawing = true
        QuestionTextView2.backgroundColor = UIColor.white
        QuestionTextView2.clipsToBounds = true
        //QuestionTextView.contentInset = UIEdgeInsets.zero
        QuestionTextView2.frame.origin.y = AboutMeTextView.frame.height + CGFloat(480+(place*80))
        QuestionTextView2.frame.size = CGSize.init(width: 320.0, height: 50.0)
        self.view.addSubview(QuestionTextView2)
            //saveButton()
        //    downloadbutton(testtextview: QuestionTextView2)
           // saveButton(button: QuestionTextView2)
        }
        if value == 0 {
            for subview in self.view.subviews {
                if (subview.tag == 2000 + number) {
                    subview.removeFromSuperview()
                }
        }
        }
    }
    
    func saveButton(){
        let userId = Auth.auth().currentUser?.uid
        //let ref = db.collection("users").document("\(userId!)")
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Q&A")
        for a in 0..<GlobalVariables.questionsList.count{
            if GlobalVariables.AnswerArray[a]==1{
                for subview in self.view.subviews {
                    if (subview.tag == 2000 + a) {
                        if let textView = subview as? UITextView {
                            print("SAVE ---\(textView.text!)")
                        ref.setData([
                            "\(GlobalVariables.questionsList[a])":"\(textView.text!)"
                        ], merge: true) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Document added with ID: \(ref.documentID)")
                            }
                        }
                        }
                    }
                }
            }
        }
    }
    
    func downloadbutton(testtextview: UITextView){
        
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Q&A")
        
        //  let ref = db.collection("users").document("\(userId!)")
        for a in 0..<GlobalVariables.questionsList.count{
            if GlobalVariables.AnswerArray[a]==1{
              
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                
                guard let latMax = document.get("\(GlobalVariables.questionsList[a])") as! String?, latMax != "" else {
                    print("LaxMax is Empty")
                    return
                }
                
                GlobalVariables.AnswerString = "\(latMax)"
                print(latMax)
                
                if latMax.isEmpty == false {
                testtextview.text = "\(latMax)"
                }
              //  self.view.addSubview(testtextview)
                
            } else {
                print("Document does not exist in cache")
            }
        }
                
            }
        }
    }
    
    let likesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 183, height: 25))
    
    let button = UIButton(frame: CGRect(x: 0, y: 570, width: 315, height: 50))
    
    func likesDislikes(){
        self.likesLabel.center = CGPoint(x: 95, y: 560)
        //self.likesLabel.frame.origin.y = self.AboutMeTextView.frame.height + 540
        self.likesLabel.textAlignment = .center
        self.likesLabel.text = "Likes and Dislikes"
        self.likesLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: 21.0)
        
        //self.button.frame.origin.y = self.AboutMeTextView.frame.height + 540
        
        button.frame.size = CGSize.init(width: 315, height: 26)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Helvetica", size: 12.0)
        //LookingButton.sizeToFit()
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .left
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        self.view.addSubview(likesLabel)
    }
    
    let lookingForTag = UILabel(frame: CGRect(x: 0, y:600, width:183, height:25))
    let LookingButton = UIButton(frame: CGRect(x:0,y:620, width:320, height:50))
    
    func lookingFor(){
      //  refButton()
        self.lookingForTag.center = CGPoint(x: 65, y: 600)
        //self.likesLabel.frame.origin.y = self.AboutMeTextView.frame.height + 540
        self.lookingForTag.textAlignment = .center
        self.lookingForTag.text = "Looking For"
        self.lookingForTag.font = UIFont.init(name: "HelveticaNeue-Bold", size: 21.0)
        
        //self.button.frame.origin.y = self.AboutMeTextView.frame.height + 540
        
        LookingButton.frame.size = CGSize.init(width: 375, height: 26)
        LookingButton.backgroundColor = .white
        LookingButton.setTitleColor(.black, for: .normal)
        LookingButton.titleLabel?.font =  UIFont(name: "Helvetica", size: 12.0)
        //LookingButton.sizeToFit()
        LookingButton.contentMode = .scaleAspectFit
        LookingButton.contentHorizontalAlignment = .left
        LookingButton.setTitle("", for: .normal)
        LookingButton.addTarget(self, action: #selector(LookingAction), for: .touchUpInside)
       // print(GlobalVariables.next2String)
        self.view.addSubview(lookingForTag)
        self.view.addSubview(LookingButton)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        download4()
        download5()
        self.view.addSubview(button)
        self.performSegue(withIdentifier: "MainToLikesSegue", sender: self)
        print("Button tapped")
    }
    
    @objc func LookingAction(sender: UIButton!){
   
        //lookingFor()
        download3()
        self.view.addSubview(LookingButton)
        self.performSegue(withIdentifier: "MainToLookingSegue", sender: self)
    }
    /*
    func refButton(){
        let userId = Auth.auth().currentUser?.uid
        //let ref = db.collection("users").document("\(userId!)")
        let testEmail = Auth.auth().currentUser!.email
        
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Looking")
        ref
            .addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in
                guard let document = documentSnapshot else {
                  //  print("Error fetching document: \(error!)")
                   // GlobalVariables.next2String = ""
                    GlobalVariables.tags2String = ""
                    return
                }
                let data = document.metadata.hasPendingWrites ? "Local" : "Server"
             //   print("\(source) data: \(document.data() ?? [:])")
                guard document.data() != nil else {
                  //  print("Document data was empty.")
                //    GlobalVariables.next2String = ""
                   GlobalVariables.tags2String = ""
                    return
                }
               // GlobalVariables.next2String = ""
              //  GlobalVariables.tags2String = ""
                for b in 0..<GlobalVariables.list.count{
                    let text2 = GlobalVariables.list[b]
                    guard let latMax = document.get("\(text2)") as? String else {
                        return
                    }
                    
                    if latMax.isEmpty != true {
                        GlobalVariables.textValue2 = latMax
                        
                        if GlobalVariables.textValue2 == "1" {
                            GlobalVariables.tags2String = GlobalVariables.tags2String + "\(text2), "
                            GlobalVariables.globalArray2[b] = 1
                            
                        } else {
                            GlobalVariables.globalArray2[b] = 0
                        }
                    }
                    GlobalVariables.next2String = String(GlobalVariables.tags2String.dropLast(2))
                    GlobalVariables.next2String = "  \(GlobalVariables.next2String)"
                    GlobalVariables.tags2String = ""
                 //   print("Current data: \(data)")
                    UIView.performWithoutAnimation {
                        if GlobalVariables.next2String.isEmpty != true {
                            self.LookingButton.setTitle(GlobalVariables.next2String, for: [])
                        }
                    }
                }
                GlobalVariables.next2String = String(GlobalVariables.tags2String.dropLast(2))
                GlobalVariables.next2String = "  \(GlobalVariables.next2String)"
                GlobalVariables.tags2String = ""
                UIView.performWithoutAnimation {
                    if GlobalVariables.next2String.isEmpty != true {
                        self.LookingButton.setTitle(GlobalVariables.next2String, for: [])
                    }
                }
                
        }
        UIView.performWithoutAnimation {
            self.LookingButton.setTitle(GlobalVariables.next2String, for: [])
        }
        print("AHHHHHH@HHHHHHHHHHH   \(GlobalVariables.next2String)")
    }
    */
    func test(){
        for a in 0..<GlobalVariables.globalArray2.count{
            if GlobalVariables.globalArray2[a] == 1{
                print(GlobalVariables.list[a])
            }
        }
    }
    
    func iteration() /*-> String*/ {
        
        
            let userId = Auth.auth().currentUser?.uid
            //let ref = db.collection("users").document("\(userId!)")
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Tag")
        
            //If it doesnt exist return empty
        
            ref
                .addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        GlobalVariables.tagsString = ""
                        return
                    }
                    let source = document.metadata.hasPendingWrites ? "Local" : "Server"
               //     print("\(source) data: \(document.data() ?? [:])")
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        GlobalVariables.tagsString = ""
                        return
                    }
                    
                    let latMax2 = document.get("aboutMe") as! String?
                    
                    if latMax2 != nil {
                        GlobalVariables.aboutMeValue = latMax2!
                    }
                    
                    
                    
                    for b in 0..<GlobalVariables.list.count{
                        let text2 = GlobalVariables.list[b]
                        guard let latMax = document.get("\(text2)") as? String else {
                            return
                        }
                        
                        if latMax.isEmpty != true {
                        GlobalVariables.textValue = latMax
                        
                        if GlobalVariables.textValue == "1" {
                            GlobalVariables.tagsString = GlobalVariables.tagsString + "\(text2), "
                            GlobalVariables.globalArray[b] = 1
                            
                        } else {
                            GlobalVariables.globalArray[b] = 0
                        }
                        }
                    }
                    
                    GlobalVariables.nextString = String(GlobalVariables.tagsString.dropLast(2))
                    GlobalVariables.nextString = "  \(GlobalVariables.nextString)"
                    GlobalVariables.tagsString = ""
                //    print("Current data: \(data)")
                    UIView.performWithoutAnimation {
                        if GlobalVariables.nextString.isEmpty != true {
                        self.TagsB.setTitle(GlobalVariables.nextString, for: [])
                        }
                        if GlobalVariables.aboutMeValue.isEmpty != true {
                        self.AboutMeTextView.text = GlobalVariables.aboutMeValue
                        }
                    }
                    
            }
        
        UIView.performWithoutAnimation {
        self.TagsB.setTitle(GlobalVariables.nextString, for: [])
        }
        
    }
    
    
    func testUpload2(typeData: UIImage?, number: Int){
       // let typeData = self.Profile2.image
        if typeData != nil {
        let userId = Auth.auth().currentUser?.uid
        let imageRef = Storage.storage().reference().child("gs:/profiles/\(userId!)_\(number).jpg")
        guard let imageData = UIImageJPEGRepresentation(typeData!, 0.1) else {
            return
        }
        // 2
        imageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // 3
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            // 4
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
                let someValue: String? = "\(url!)"
                let testEmail = Auth.auth().currentUser!.email
                var studentId = testEmail?.components(separatedBy: "@")
                var studentId2 = studentId![1].components(separatedBy: ".edu")
                let email = studentId2[0]
                
                let ref = self.db.collection("users").document("\(userId!)")
                ref.setData([
                    "photolink_\(number)": someValue!
                ], merge: true) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
               //         print("Document added with ID: \(ref.documentID)")
                    }
                }
           //     print(url as Any)
            })
        })
        }
    }
    
     var handle: AuthStateDidChangeListenerHandle?
    
    
    @IBAction func Done(_ sender: UIButton) {
        print(self.AboutMeTextView.text!)
        
        let typeData1 = self.ProfilePhoto.image
        let typeData2 = self.Profile2.image
        let typeData3 = self.Profile3.image
        let typeData4 = self.Profile4.image
        let typeData5 = self.Profile5.image
        let typeData6 = self.Profile6.image
        testUpload2(typeData: typeData1,number: 1)
        testUpload2(typeData: typeData2,number: 2)
        testUpload2(typeData: typeData3,number: 3)
        testUpload2(typeData: typeData4, number: 4)
        testUpload2(typeData: typeData5, number: 5)
        testUpload2(typeData: typeData6, number: 6)
        saveButton()

    
        print(self.AboutMeTextView.text!)
        guard let aboutMeText = AboutMeTextView.text, !aboutMeText.isEmpty else { return }
        let _: [String: Any] = ["aboutMe": aboutMeText]
        print(aboutMeText)
       
        _ = Auth.auth().currentUser?.uid
        let userId = Auth.auth().currentUser?.uid
        
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)")
        
        //let ref = self.db.collection("users").document("\(studentId!)").collection("Gender").document("\(userID)")
        
        //let ref = db.collection("users").document("\(userId!)").collection("profile").document("\(studentId!)")
        
            ref.setData([
            "aboutMe": aboutMeText
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
        
        

        
        
        print(self.AboutMeTextView.text!)
        print("DONE")
        
        
        ///
        ///
        ///
        
        self.performSegue(withIdentifier: "MainToUploadSegue", sender: self)
        
        
    }
    
}


