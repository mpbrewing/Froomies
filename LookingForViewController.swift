//
//  LookingForViewController.swift
//  FR3
//
//  Created by Michael Brewington on 3/4/19.
//  Copyright © 2019 Michael Brewington. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class LookingForViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    
    var LookingForList = ["Affectionate","Aloof","Ambitious","Amusing","Analytical","Anxious","Artistic","Charismatic","Creative","Curious","Dependable","Emotional","Extroverted","Introverted","Generous","Hard-Working","Diligent","Humorous","Impatient","Impulsive","Inconsistent","Independent","Intelligent","Joyful","Cheerful","Kind","Compassionate","Laid-Back","Lazy","Loyal","Organized","Original","Passionate","Proactive","Quiet","Shy","Sociable","Straight-forward","Stubborn","Sympathetic","Talkative","Temperamental","Moody","Upbeat","Warm-Hearted","Resident","Out of State","International"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LookingForList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath as IndexPath) as! TableViewCell
        //let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        let row = indexPath.row
        //cell.textLabel?.text = list[row]
        cell.label.text = LookingForList[indexPath.row]
        cell.button.image(for: .normal)
        
        let text = "\(LookingForList[indexPath.row])"
        
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Looking")
        
        let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
        
        func download(){
            let userId = Auth.auth().currentUser?.uid
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Looking")
            let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
            
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
        }
        
        func upload(){
            let userId = Auth.auth().currentUser?.uid
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Looking")
            let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
            
            ref.setData([
                "\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"
            ], merge: true) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref.documentID)")
                }
            }
        }
        
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                
                guard document.get("\(text)") != nil else {
                    return
                }
                //   print("\(property!) and \(indexPath.row)")
                
                let latMax = document.get("\(text)") as! String
                //  print(latMax)
                
                if latMax == "1" {
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.none
                }
                
            } else {
                print("Document does not exist in cache")
            }
        }
        
        
        
        return cell
    }
     var counter:Int = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        if table.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            self.counter = self.counter - 1
            print(self.counter)
            
            let text = "\(LookingForList[indexPath.row])"
            let index = indexPath.row
            
            GlobalVariables.globalArray[indexPath.row] = 0
            
            let userId = Auth.auth().currentUser?.uid
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Looking")
            let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
            
            func upload(){
                let text = "\(LookingForList[indexPath.row])"
                let userId = Auth.auth().currentUser?.uid
                let testEmail = Auth.auth().currentUser!.email
                
                var studentId = testEmail?.components(separatedBy: "@")
                var studentId2 = studentId![1].components(separatedBy: ".edu")
                let email = studentId2[0]
                
                let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Looking")
                let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
                
                ref.setData([
                    "\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"
                ], merge: true) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref.documentID)")
                    }
                }
            }
            upload()
            
            //    print("\(GlobalVariables.globalArray[indexPath.row]) and \(index) and \(text)")
            
            
            
        } else {
            /*
            if self.counter <= -2 {
             
                self.counter = self.counter + 1
                print(self.counter)
 */
             table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
               let text = "\(LookingForList[indexPath.row])"
                let index = indexPath.row
                
                GlobalVariables.globalArray[indexPath.row] = 1
        
            
            func upload(){
               let text = "\(LookingForList[indexPath.row])"
                let userId = Auth.auth().currentUser?.uid
                let testEmail = Auth.auth().currentUser!.email
                
                var studentId = testEmail?.components(separatedBy: "@")
                var studentId2 = studentId![1].components(separatedBy: ".edu")
                let email = studentId2[0]
                
                let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Looking")
                let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
                
                ref.setData([
                    "\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"
                ], merge: true) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref.documentID)")
                    }
                }
            }
            upload()
            
            
            //    print("\(GlobalVariables.globalArray[indexPath.row]) and \(index) and \(text)")
            
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var Done: UIButton!
    
    @IBAction func DoneButton(_ sender: UIButton){
         dismiss(animated: true)
    }
    
    @IBOutlet weak var scroller: UIScrollView!
    
    struct GlobalVariables {
        
        static var list = ["Affectionate","Aloof","Ambitious","Amusing","Analytical","Anxious","Artistic","Charismatic","Creative","Curious","Dependable","Emotional","Extroverted","Introverted","Generous","Hard-Working","Diligent","Humorous","Impatient","Impulsive","Inconsistent","Independent","Intelligent","Joyful","Cheerful","Kind","Compassionate","Laid-Back","Lazy","Loyal","Organized","Original","Passionate","Proactive","Quiet","Shy","Sociable","Straight-forward","Stubborn","Sympathetic","Talkative","Temperamental","Moody","Upbeat","Warm-Hearted","Resident","Out of State","International"]
        static var globalArray = [Int](repeating: 0, count: list.count)
        static var tagsString = ""
        static var booleanTest : Bool!
        static var counter = 0
        static var nextString = ""
        
        mutating func removeAll() {
            self = GlobalVariables()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        scroller.contentSize = CGSize(width: scroller.contentSize.width, height: scroller.contentSize.height)
        //
        //
        table.delegate = self
        table.dataSource = self
        
        
        
        table.register(UINib(nibName: "TableViewCell",bundle: nil),forCellReuseIdentifier: "TableViewCell")
        //Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        //
        // iteration()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        scroller.isScrollEnabled = true
        // Do any additional setup after loading the view
    }
    
    


}
