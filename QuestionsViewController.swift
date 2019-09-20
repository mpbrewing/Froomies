//
//  QuestionsViewController.swift
//  FR3
//
//  Created by Michael Brewington on 1/11/19.
//  Copyright © 2019 Michael Brewington. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class QuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    var counter:Int = 0
    
    var QuestionsList = ["What are your favorite movies?","What are your favorite books?","Favorite activity?","What are you passionate about?","Favorite meme?","List 5 things you want to do this year","Favorite quote?"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath as IndexPath) as! TableViewCell
        //let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        let row = indexPath.row
        //cell.textLabel?.text = list[row]
        cell.label.text = QuestionsList[indexPath.row]
        cell.button.image(for: .normal)
        
        let text = "Question_\(indexPath.row)"
        
        let userId = Auth.auth().currentUser?.uid
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Q&A")
        
        let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
        
        func download(){
            let userId = Auth.auth().currentUser?.uid
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Q&A")
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
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Q&A")
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
                   // if self.counter <= -2 {
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                 //   self.counter = self.counter + 1
                    print(self.counter)
                  //  }
                } else if latMax == "0" {
                    cell.accessoryType = UITableViewCellAccessoryType.none
                    //self.counter = self.counter - 1
                    print(self.counter)
                }
                
            } else {
                print("Document does not exist in cache")
            }
        }
        
        
        
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let text = "Question_\(indexPath.row)"
        
        let userId = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document("\(userId!)").collection("Questions").document("Fields")
        
        
        ref.getDocument(source: .cache) { (document, error) in
            if let document = document {
                
                guard document.get("\(text)") != nil else {
                    return
                }
                //   print("\(property!) and \(indexPath.row)")
                
               // let latMax = document.get("\(text)") as! String
                //  print(latMax)
               // self.counter = 0
                for a in 0..<self.QuestionsList.count{
                    let text2 = document.get("Question_\(a)") as! String
                    if text2 == "1" {
                     //   self.counter = self.counter + 1
                    } else {
                        
                    }
                }
            
                
            } else {
                print("Document does not exist in cache")
            }
        }
        
        if let selectedRows = tableView.indexPathsForSelectedRows?.filter({ $0.section == indexPath.section }) {
            print(selectedRows)
            print(counter)
            /*
            if selectedRows.count == 1 {
                return nil
            }
*/
        }
        return indexPath
    }
*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        if table.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            //self.counter = self.counter - 1
            print(self.counter)
            
            let text = "Question_\(indexPath.row)"
            let index = indexPath.row
            
            GlobalVariables.globalArray[indexPath.row] = 0
            
            let userId = Auth.auth().currentUser?.uid
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Q&A")
            let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
            
            func upload(){
                let text = "Question_\(indexPath.row)"
                let userId = Auth.auth().currentUser?.uid
                let testEmail = Auth.auth().currentUser!.email
                
                var studentId = testEmail?.components(separatedBy: "@")
                var studentId2 = studentId![1].components(separatedBy: ".edu")
                let email = studentId2[0]
                
                let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Q&A")
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
            
         //   if self.counter <= -2 {
            table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
          //  self.counter = self.counter + 1
            print(self.counter)
            let text = "Question_\(indexPath.row)"
            let index = indexPath.row
                
            GlobalVariables.globalArray[indexPath.row] = 1
          //  } else {
                
         //   }
            
           
            
            
            func upload(){
                let text = "Question_\(indexPath.row)"
                let userId = Auth.auth().currentUser?.uid
                let testEmail = Auth.auth().currentUser!.email
                
                var studentId = testEmail?.components(separatedBy: "@")
                var studentId2 = studentId![1].components(separatedBy: ".edu")
                let email = studentId2[0]
                
                let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Q&A")
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
    
    @IBOutlet weak var Done: UIButton!
    
    @IBAction func DoneButton(_ sender: UIButton) {
        GlobalVariables.booleanTest = true
        counter = 0
        dismiss(animated: true)
        print("Questions View")
    }
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet var table: UITableView!
    
    struct GlobalVariables {
        
        static var list = ["What are your favorite movies?","What are your favorite books?","Favorite activity?","What are you passionate about?","Favorite meme?","List 5 things you want to do this year","Favorite quote?"]
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
