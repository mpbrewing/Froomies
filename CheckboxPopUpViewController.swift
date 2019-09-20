//
//  CheckboxPopUpViewController.swift
//  FR3
//
//  Created by Michael Brewington on 11/26/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class CheckboxPopUpViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource
{
    
    let db = Firestore.firestore()
    
    var list = ["Affectionate","Aloof","Ambitious","Amusing","Analytical","Anxious","Artistic","Charismatic","Creative","Curious","Dependable","Emotional","Extroverted","Introverted","Generous","Hard-Working","Diligent","Humorous","Impatient","Impulsive","Inconsistent","Independent","Intelligent","Joyful","Cheerful","Kind","Compassionate","Laid-Back","Lazy","Loyal","Organized","Original","Passionate","Proactive","Quiet","Shy","Sociable","Straight-forward","Stubborn","Sympathetic","Talkative","Temperamental","Moody","Upbeat","Warm-Hearted","Resident","Out of State","International"]
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
   // let textCellIdentifier = "TextCell"

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath as IndexPath) as! TableViewCell
        //let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        let row = indexPath.row
        //cell.textLabel?.text = list[row]
        cell.label.text = list[indexPath.row]
        cell.button.image(for: .normal)
        
        let text = list[indexPath.row]
        
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Tag")
        
        let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
        
        func download(){
            let userId = Auth.auth().currentUser?.uid
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Tag")
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
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Tag")
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
    
    func returnGlobal() -> String {
        return GlobalVariables.nextString
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        


        if table.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            
            
            let text = list[indexPath.row]
            let index = indexPath.row
            
            GlobalVariables.globalArray[indexPath.row] = 0
            
            let userId = Auth.auth().currentUser?.uid
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Tag")
            let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
            
            func upload(){
                let text = list[indexPath.row]
                let userId = Auth.auth().currentUser?.uid
                let testEmail = Auth.auth().currentUser!.email
                
                var studentId = testEmail?.components(separatedBy: "@")
                var studentId2 = studentId![1].components(separatedBy: ".edu")
                let email = studentId2[0]
                
                let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Tag")
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
            table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            let text = list[indexPath.row]
            let index = indexPath.row
            
            GlobalVariables.globalArray[indexPath.row] = 1
            
            
            func upload(){
                let text = list[indexPath.row]
                let userId = Auth.auth().currentUser?.uid
                let testEmail = Auth.auth().currentUser!.email
                
                var studentId = testEmail?.components(separatedBy: "@")
                var studentId2 = studentId![1].components(separatedBy: ".edu")
                let email = studentId2[0]
                
                let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Tag")
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
    
    /*
        func iteration() -> String {
           
            for i in 0..<GlobalVariables.list.count{
                
                let text = GlobalVariables.list[i]
           
                let userId = Auth.auth().currentUser?.uid
                let ref = db.collection("users").document("\(userId!)")
                
                ref.getDocument(source: .cache) { (document, error) in
                    if let document = document {
                        _ = document.get("\(text)")
                        //   print("\(property!) and \(indexPath.row)")
                        let latMax = document.get("\(text)") as! String
                          //print(latMax)
                        
                      let text = GlobalVariables.list[i]
                        if latMax == "1" {
                            GlobalVariables.tagsString = GlobalVariables.tagsString + "\(text), "
                            GlobalVariables.globalArray[i] = 1
                            
                        } else {
                            GlobalVariables.globalArray[i] = 0
                        }
                    } else {
                        print("Document does not exist in cache")
                    }
                }
                
            }
            GlobalVariables.nextString = String(GlobalVariables.tagsString.dropLast(2))
            GlobalVariables.tagsString = ""
            
            return GlobalVariables.nextString
            
    }
    */
    
    
    
    func returnBoolean() -> Bool {
        
        if GlobalVariables.booleanTest == true {
            GlobalVariables.booleanTest = false
            GlobalVariables.counter = GlobalVariables.counter + 1
        } else {
            GlobalVariables.booleanTest = true
            GlobalVariables.counter = GlobalVariables.counter + 1
        }
        print("\(GlobalVariables.booleanTest)--- Return Boolean (1)")
        print("\(GlobalVariables.counter)--- Return Boolean (2)")
        return GlobalVariables.booleanTest
    }
    
    //var myCustomViewController: MainViewController = MainViewController()
    
    @IBAction func donebutton(_ sender: UIButton) {
        GlobalVariables.booleanTest = true
        dismiss(animated: true)
       print("Checkbox")
        
        
    }

    
    /*
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //doSomethingWithItem(indexPath.row)
    }
    */
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var done: UIButton!
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        scroller.isScrollEnabled = true
        // Do any additional setup after loading the view
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


