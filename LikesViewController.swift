//
//  LikesViewController.swift
//  FR3
//
//  Created by Michael Brewington on 1/16/19.
//  Copyright © 2019 Michael Brewington. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class LikesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var done: UIButton!
    @IBAction func doneButton(_ sender: UIButton) {
        dismiss(animated:true )
    }
    
    
    var db = Firestore.firestore()
    
    var QuestionsList = ["Animals and Pets","Babysitting","Beauty and Hair Care","Being a Leader of a Group","Going to Church, Synagogue, or Temple","Listening to Music","Making and Enjoying Art","Playing Sports","Playing an Instrument","Taking Care of Others","The Great Outdoors","Watching TV or Movies","Writing Songs, Stories, and Poems","Visiting Friends","Eating","Playing Video Games","Cooking","Reading","Exercising","Traveling","Learning","Politics","Meeting New People","Fraternities and Sororities","Volunteering","Business and Finance","Drama and Theatre","Journalism","Science and Technology"]
    var QuestionsList2 = ["Animals and Pets","Babysitting","Beauty and Hair Care","Being a Leader of a Group","Going to Church, Synagogue, or Temple","Listening to Music","Making and Enjoying Art","Playing Sports","Playing an Instrument","Taking Care of Others","The Great Outdoors","Watching TV or Movies","Writing Songs, Stories, and Poems","Visiting Friends","Eating","Playing Video Games","Cooking","Reading","Exercising","Traveling","Learning","Politics","Meeting New People","Fraternities and Sororities","Volunteering","Business and Finance","Drama and Theatre","Journalism","Science and Technology"]

    
    struct GlobalVariables {
        static var list = ["Animals and Pets","Babysitting","Beauty and Hair Care","Being a Leader of a Group","Going to Church, Synagogue, or Temple","Listening to Music","Making and Enjoying Art","Playing Sports","Playing an Instrument","Taking Care of Others","The Great Outdoors","Watching TV or Movies","Writing Songs, Stories, and Poems","Visiting Friends","Eating","Playing Video Games","Cooking","Reading","Exercising","Traveling","Learning","Politics","Meeting New People","Fraternities and Sororities","Volunteering","Business and Finance","Drama and Theatre","Journalism","Science and Technology"]
        static var list2 = ["Animals and Pets","Babysitting","Beauty and Hair Care","Being a Leader of a Group","Going to Church, Synagogue, or Temple","Listening to Music","Making and Enjoying Art","Playing Sports","Playing an Instrument","Taking Care of Others","The Great Outdoors","Watching TV or Movies","Writing Songs, Stories, and Poems","Visiting Friends","Eating","Playing Video Games","Cooking","Reading","Exercising","Traveling","Learning","Politics","Meeting New People","Fraternities and Sororities","Volunteering","Business and Finance","Drama and Theatre","Journalism","Science and Technology"]
        static var globalArray = [Int](repeating: 0, count: list.count)
        static var globalArray2 = [Int](repeating: 0, count: list2.count)
        static var tagsString = ""
        static var booleanTest : Bool!
        static var counter = 0
        static var nextString = ""
        
        let name : String
        var items : [[String]]
        
        /*
        mutating func removeAll() {
            self = GlobalVariables()
        }
        */
        
    }
    
    //var sections = [GlobalVariables]()
    
    var sections = [GlobalVariables(name:"Likes", items: [GlobalVariables.list]),
    GlobalVariables(name:"Dislikes", items: [GlobalVariables.list2])]
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // return 2
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].name
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return QuestionsList.count
        } else {
            return QuestionsList2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath as IndexPath) as! TableViewCell
        //let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        
        //
        if (indexPath.section==0) {
            
            cell.label.text = QuestionsList[indexPath.row]
            
            cell.button.image(for: .normal)
            
            let text = "\(QuestionsList[indexPath.row])"
            
            let userId = Auth.auth().currentUser?.uid
            
            download(text: text, indexPath: indexPath as NSIndexPath, section: "Likes", arrayDownload: GlobalVariables.globalArray)
            
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Likes")
            
          //  let ref = db.collection("users").document("\(userId!)").collection("Questions").document("Likes")
            
            let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
            
            
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
        } else {
            cell.label.text = QuestionsList2[indexPath.row]
            
            cell.button.image(for: .normal)
            
            let text = "\(QuestionsList2[indexPath.row])"
            
            let userId = Auth.auth().currentUser?.uid
            
            let testEmail = Auth.auth().currentUser!.email
            
            var studentId = testEmail?.components(separatedBy: "@")
            var studentId2 = studentId![1].components(separatedBy: ".edu")
            let email = studentId2[0]
            
            let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Dislikes")
            
            let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray2[indexPath.row])"]
            
            
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
            
        }
        
    
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if table.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            
            if (indexPath.section==0) {
                table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                
                let text = "\(QuestionsList[indexPath.row])"
                
                GlobalVariables.globalArray[indexPath.row] = 0
                
                let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray[indexPath.row])"]
                
                upload(text: text, indexPath: indexPath as NSIndexPath, section: "Likes", arrayDownload: GlobalVariables.globalArray)
            } else {
                table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                
                let text = "\(QuestionsList2[indexPath.row])"
                
                GlobalVariables.globalArray2[indexPath.row] = 0
                
                let _: [String: Any] = ["\(text)":  "\(GlobalVariables.globalArray2[indexPath.row])"]
                
                upload(text: text, indexPath: indexPath as NSIndexPath, section: "Dislikes", arrayDownload: GlobalVariables.globalArray2)
            }
            

            
            //    print("\(GlobalVariables.globalArray[indexPath.row]) and \(index) and \(text)")
            
            
            
        } else {
            table.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            if (indexPath.section==0) {
                let text = "\(QuestionsList[indexPath.row])"
                
                GlobalVariables.globalArray[indexPath.row] = 1
                
                upload(text: text, indexPath: indexPath as NSIndexPath, section: "Likes", arrayDownload: GlobalVariables.globalArray)
                
                //    print("\(GlobalVariables.globalArray[indexPath.row]) and \(index) and \(text)")
            } else {
                let text = "\(QuestionsList2[indexPath.row])"
                
                GlobalVariables.globalArray2[indexPath.row] = 1
                
                upload(text: text, indexPath: indexPath as NSIndexPath, section: "Dislikes", arrayDownload: GlobalVariables.globalArray2)
                
                //    print("\(GlobalVariables.globalArray[indexPath.row]) and \(index) and \(text)")
            }
            
            
            
        }
    }
    
    func download(text: String, indexPath: NSIndexPath, section: String, arrayDownload: Array<Any>){
        let userId = Auth.auth().currentUser?.uid
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document(section)
       // let ref = db.collection("users").document("\(userId!)").collection("Questions").document(section)
        let _: [String: Any] = ["\(text)":  "\(arrayDownload[indexPath.row])"]
        
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func upload(text: String, indexPath: NSIndexPath, section: String, arrayDownload: Array<Any>){
        let userId = Auth.auth().currentUser?.uid
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document(section)
        let _: [String: Any] = ["\(text)":  "\(arrayDownload[indexPath.row])"]
        
        ref.setData([
            "\(text)":  "\(arrayDownload[indexPath.row])"
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.db = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        
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

