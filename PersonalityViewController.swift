//
//  PersonalityViewController.swift
//  FR3
//
//  Created by Michael Brewington on 2/23/19.
//  Copyright © 2019 Michael Brewington. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class PersonalityViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var testQuestion: UILabel!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    @IBOutlet weak var Return: UIButton!
    @IBAction func ReturnAction(_ sender: UIButton) {
         self.performSegue(withIdentifier: "PersonalityToViewSegue", sender: self)
    }
    
    
    let userID = Auth.auth().currentUser!.uid
    
    var tapcount : Double = 0;
    
    var count : Double = 0.01960784;
    
    var tapcounter : Int = 0;
    
    @IBAction func ButtonSegue(_ sender: UIButton) {

        loadData()
        ButtonText()
     //   print(testQuestion.text!)
        
        if let name = sender.titleLabel?.text {
        //    print("\(name)")
            GlobalVariables.buttonString = name
                  SaveData()
                  QuestionLabel()
                  Algorithm1()
        }
        gender()
        finalScore()
        
    }
    
    func loadData(){
      //  var counter2 = (GlobalVariables.counter2) as Int
        
        self.tapcounter = self.tapcounter + 1
        self.tapcount = self.tapcount + count
        
        UIView.animate(withDuration: 0.2){
            
            if self.ProgressBar.progress != 1 {
                 self.ProgressBar.setProgress(Float(self.tapcount), animated: true)
            } else {
                self.ProgressBar.setProgress(Float(1), animated: true)
            }
        }
        
        
      //  print(self.ProgressBar.progress);
        
          if (self.tapcounter<59){
       // print("hi \(tapcount) and \(tapcounter)");
        }
        
    }
    
    func gender(){
        if self.tapcounter == 52{
            uploadData(value: "Boolean",b:"Gender",d:"\(GlobalVariables.buttonString)")
            uploadImp(value: "Gender", item: "\(GlobalVariables.buttonString)")
        }
    }
    
    func QuestionLabel(){
        self.testQuestion.lineBreakMode = .byWordWrapping
        self.testQuestion.numberOfLines = 3
        
        if (self.tapcounter<59){
         self.testQuestion.text = "\(GlobalVariables.list[self.tapcounter])"
            GlobalVariables.globalText = "\(GlobalVariables.list[self.tapcounter])"
        } else {
           self.testQuestion.text = " "
        }
    }
    
    func ButtonText(){
        
        if (self.tapcounter>51){
            uploadImp(value: "QuizFinished", item: "1")
            self.performSegue(withIdentifier: "PersonalityToViewSegue", sender: self)
            
        }
    
        
        if (self.tapcounter>22&&self.tapcounter<53){
            //self.testQuestion.text = "Answer the following:"
            self.Button5.isHidden = false
            self.Button5.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][4])", for: .normal)
            self.Button4.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][3])", for: .normal)
            self.Button3.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][2])", for: .normal)
            self.Button2.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][1])", for: .normal)
            self.Button1.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][0])", for: .normal)
        } else if (self.tapcounter>53&&self.tapcounter<59) {
            
             self.Button1.isHidden = true
             self.Button2.isHidden = true
             self.Button3.isHidden = true
             self.Button4.isHidden = true
             self.Button5.isHidden = false
             self.Button5.setTitle("Next", for: .normal)
      //       self.Button5.isHidden = true
        //     self.Button5.isEnabled = false
          
            
        } else if (self.tapcounter < 59){
            self.Button1.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][0])", for: .normal)
            self.Button2.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][1])", for: .normal)
            self.Button3.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][2])", for: .normal)
            self.Button4.setTitle("\(GlobalVariables.Buttonlist[self.tapcounter][3])", for: .normal)
            
            if (self.tapcounter<22){
            self.Button5.isHidden = true
            }
        } else {
            self.Button1.setTitle("1", for: .normal)
            self.Button2.setTitle("2", for: .normal)
            self.Button3.setTitle("3", for: .normal)
            self.Button4.setTitle("4", for: .normal)
        }
        
    
    }
    
    
    //Save
    func SaveData(){
        
        //print(testQuestion.text!)
        /*
        if let name = sender.titleLabel?.text {
            print("\(name)")
        }
        */
        let name = GlobalVariables.buttonString
        //print(name)
        let question = GlobalVariables.globalText
        
        guard let questionAnswered = testQuestion.text, !questionAnswered.isEmpty else { return }
        let _: [String: Any] = ["\(question)": "\(name)"]
       // print(question)
        
       // _ = Auth.auth().currentUser?.uid
        let userId = Auth.auth().currentUser?.uid
        //print("\(userId!)")
       // let ref = db.collection("users").document("\(userID)").collection("Questions").document("Buttons")
        
        let testEmail = Auth.auth().currentUser!.email
        
        var studentId = testEmail?.components(separatedBy: "@")
        var studentId2 = studentId![1].components(separatedBy: ".edu")
        let email = studentId2[0]
        
        let ref = self.db.collection("users").document("\(userId!)").collection("profile").document("\(email)").collection("List").document("Quiz")
        
        ref.setData([
            "\(question)": "\(name)"
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref.documentID)")
            }
        }
 
    }
    
    func PageStyle(){
        
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
    
    func uploadImp(value:String,item:String){
        let userId = Auth.auth().currentUser?.uid
        let ref2 = self.db.collection("users").document("\(userId!)")
        ref2.setData([
            "\(value)": "\(item)"
        ], merge: true) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                // print("Document added with ID: \(self.ref!.documentID)")
            }
        }
    }
    
    @IBOutlet weak var hiddenLabel: UILabel!
    
    func finalScore(){
        var FinalString = ""
        if self.tapcounter<51{
            self.hiddenLabel.alpha = 1.0
            self.hiddenLabel.text = "\(self.tapcounter)"
        }
        if self.tapcounter>51 {
            
            if EIRawScore > 12 {
                FinalString = "E"
            } else if EIRawScore < 12 {
               FinalString = "I"
            }
            if SNRawScore > 12 {
               FinalString.append("S")
            } else if SNRawScore < 12 {
               FinalString.append("N")
            }
            if TFRawScore > 12 {
                FinalString.append("T")
            } else if TFRawScore < 12 {
                FinalString.append("F")
            }
            if JPRawScore > 12 {
                 FinalString.append("J")
            } else if JPRawScore < 12 {
                 FinalString.append("P")
            }
            if EQRawScore > 8 {
                 FinalString.append("+")
            } else if EQRawScore < 8 {
                 FinalString.append("-")
            }
            self.hiddenLabel.alpha = 1.0
            
            self.hiddenLabel.text = "\(FinalString) and \(self.tapcounter)"
            print(self.hiddenLabel.text!)
            uploadData(value: "Boolean",b:"QuizFinished",d:"1")
            uploadData(value: "Score",b:"Total",d:"\(FinalString)")
            uploadData(value: "Score",b:"EI",d:"\(EIRawScore)")
            uploadData(value: "Score",b:"SN",d:"\(SNRawScore)")
            uploadData(value: "Score",b:"TF",d:"\(TFRawScore)")
            uploadData(value: "Score",b:"JP",d:"\(JPRawScore)")
            uploadData(value: "Score",b:"EQ",d:"\(EQRawScore)")
        }
    }
    
    var EIRawScore = 12
    var SNRawScore = 12
    var TFRawScore = 12
    var JPRawScore = 12
    var EQRawScore = 8
    
    func Algorithm1(){
        //Extroverted(24,34,43) vs. Introverted(29,35,44)
            if (self.tapcounter==24||self.tapcounter==34||self.tapcounter==43){
                if GlobalVariables.buttonString == "Strongly Agree"{
                    EIRawScore = EIRawScore + 2
                } else if GlobalVariables.buttonString == "Agree" {
                    EIRawScore = EIRawScore + 1
                } else if GlobalVariables.buttonString == "Neutral"{
                    EIRawScore = EIRawScore + 0
                } else if GlobalVariables.buttonString == "Disagree"{
                    EIRawScore = EIRawScore - 1
                } else if GlobalVariables.buttonString == "Strongly Disagree"{
                    EIRawScore = EIRawScore - 2
                }
            }
            if (self.tapcounter==29||self.tapcounter==35||self.tapcounter==44){
                if GlobalVariables.buttonString == "Strongly Agree"{
                    EIRawScore = EIRawScore - 2
                } else if GlobalVariables.buttonString == "Agree" {
                    EIRawScore = EIRawScore - 1
                } else if GlobalVariables.buttonString == "Neutral"{
                    EIRawScore = EIRawScore + 0
                } else if GlobalVariables.buttonString == "Disagree"{
                    EIRawScore = EIRawScore + 1
                } else if GlobalVariables.buttonString == "Strongly Disagree"{
                    EIRawScore = EIRawScore + 2
                }
            }
    //    print(EIRawScore)
        if EIRawScore > 12 {
            print("The Raw Score is \(EIRawScore) and the individual is E")
        } else if EIRawScore < 12 {
            print("The Raw Score is \(EIRawScore) and the individual is I")
        }
        //Sensing(36,43,45) vs. Intuition(25,30,38)
        if (self.tapcounter==36||self.tapcounter==43||self.tapcounter==45){
            if GlobalVariables.buttonString == "Strongly Agree"{
                SNRawScore = SNRawScore + 2
            } else if GlobalVariables.buttonString == "Agree" {
                SNRawScore = SNRawScore + 1
            } else if GlobalVariables.buttonString == "Neutral"{
                SNRawScore = SNRawScore + 0
            } else if GlobalVariables.buttonString == "Disagree"{
                SNRawScore = SNRawScore - 1
            } else if GlobalVariables.buttonString == "Strongly Disagree"{
                SNRawScore = SNRawScore - 2
            }
        }
        if (self.tapcounter==25||self.tapcounter==30||self.tapcounter==38){
            if GlobalVariables.buttonString == "Strongly Agree"{
                SNRawScore = SNRawScore - 2
            } else if GlobalVariables.buttonString == "Agree" {
                SNRawScore = SNRawScore - 1
            } else if GlobalVariables.buttonString == "Neutral"{
                SNRawScore = SNRawScore + 0
            } else if GlobalVariables.buttonString == "Disagree"{
                SNRawScore = SNRawScore + 1
            } else if GlobalVariables.buttonString == "Strongly Disagree"{
                SNRawScore = SNRawScore + 2
            }
        }
      //  print(SNRawScore)
        if SNRawScore > 12 {
            print("The Raw Score is \(SNRawScore) and the individual is S")
        } else if SNRawScore < 12 {
            print("The Raw Score is \(SNRawScore) and the individual is N")
        }
        //Thinking(26,39,47) vs. Feeling(31,37,46)
        if (self.tapcounter==26||self.tapcounter==39||self.tapcounter==47){
            if GlobalVariables.buttonString == "Strongly Agree"{
                TFRawScore = TFRawScore + 2
            } else if GlobalVariables.buttonString == "Agree" {
                TFRawScore = TFRawScore + 1
            } else if GlobalVariables.buttonString == "Neutral"{
                TFRawScore = TFRawScore + 0
            } else if GlobalVariables.buttonString == "Disagree"{
                TFRawScore = TFRawScore - 1
            } else if GlobalVariables.buttonString == "Strongly Disagree"{
                TFRawScore = TFRawScore - 2
            }
        }
        if (self.tapcounter==31||self.tapcounter==37||self.tapcounter==46){
            if GlobalVariables.buttonString == "Strongly Agree"{
                TFRawScore = TFRawScore - 2
            } else if GlobalVariables.buttonString == "Agree" {
                TFRawScore = TFRawScore - 1
            } else if GlobalVariables.buttonString == "Neutral"{
                TFRawScore = TFRawScore + 0
            } else if GlobalVariables.buttonString == "Disagree"{
                TFRawScore = TFRawScore + 1
            } else if GlobalVariables.buttonString == "Strongly Disagree"{
                TFRawScore = TFRawScore + 2
            }
        }
     //   print(TFRawScore)
        if TFRawScore > 12 {
            print("The Raw Score is \(TFRawScore) and the individual is T")
        } else if TFRawScore < 12 {
            print("The Raw Score is \(TFRawScore) and the individual is F")
        }
        //Judging(27,32,48) vs. Perceiving(40,41,51)
        if (self.tapcounter==27||self.tapcounter==32||self.tapcounter==48){
            if GlobalVariables.buttonString == "Strongly Agree"{
                JPRawScore = JPRawScore + 2
            } else if GlobalVariables.buttonString == "Agree" {
                JPRawScore = JPRawScore + 1
            } else if GlobalVariables.buttonString == "Neutral"{
                JPRawScore = JPRawScore + 0
            } else if GlobalVariables.buttonString == "Disagree"{
                JPRawScore = JPRawScore - 1
            } else if GlobalVariables.buttonString == "Strongly Disagree"{
                JPRawScore = JPRawScore - 2
            }
        }
        if (self.tapcounter==40||self.tapcounter==41||self.tapcounter==51){
            if GlobalVariables.buttonString == "Strongly Agree"{
                JPRawScore = JPRawScore - 2
            } else if GlobalVariables.buttonString == "Agree" {
                JPRawScore = JPRawScore - 1
            } else if GlobalVariables.buttonString == "Neutral"{
                JPRawScore = JPRawScore + 0
            } else if GlobalVariables.buttonString == "Disagree"{
                JPRawScore = JPRawScore + 1
            } else if GlobalVariables.buttonString == "Strongly Disagree"{
                JPRawScore = JPRawScore + 2
            }
        }
   //     print(JPRawScore)
        if JPRawScore > 12 {
            print("The Raw Score is \(JPRawScore) and the individual is J")
        } else if JPRawScore < 12 {
            print("The Raw Score is \(JPRawScore) and the individual is P")
        }
        //High EQ(33,49) vs. Low EQ(28,50)
        if (self.tapcounter==33||self.tapcounter==49){
            if GlobalVariables.buttonString == "Strongly Agree"{
                EQRawScore = EQRawScore + 2
            } else if GlobalVariables.buttonString == "Agree" {
                EQRawScore = EQRawScore + 1
            } else if GlobalVariables.buttonString == "Neutral"{
                EQRawScore = EQRawScore + 0
            } else if GlobalVariables.buttonString == "Disagree"{
                EQRawScore = EQRawScore - 1
            } else if GlobalVariables.buttonString == "Strongly Disagree"{
                EQRawScore = EQRawScore - 2
            }
        }
        if (self.tapcounter==28||self.tapcounter==50){
            if GlobalVariables.buttonString == "Strongly Agree"{
                EQRawScore = EQRawScore - 2
            } else if GlobalVariables.buttonString == "Agree" {
                EQRawScore = EQRawScore - 1
            } else if GlobalVariables.buttonString == "Neutral"{
                EQRawScore = EQRawScore + 0
            } else if GlobalVariables.buttonString == "Disagree"{
                EQRawScore = EQRawScore + 1
            } else if GlobalVariables.buttonString == "Strongly Disagree"{
                EQRawScore = EQRawScore + 2
            }
        }
        if (self.tapcounter==52){
            self.Button3.isEnabled = false
            self.Button4.isEnabled = false
            self.Button5.isEnabled = false
            self.Button3.isHidden = true
            self.Button4.isHidden = true
            self.Button5.isHidden = true
        }
    //    print(EQRawScore)
        if EQRawScore > 8 {
            print("The Raw Score is \(EQRawScore) and the individual is High EQ")
        } else if EQRawScore < 8 {
            print("The Raw Score is \(EQRawScore) and the individual is Low EQ")
        }
    }
    //Current String = to array position, call line,
    
    var TestQuestions = [""]
    
    struct GlobalVariables {
        static var list = ["I usually study in the", "The bulk of my studying occurs in the", "I would describe my study habits as", "I am not able to study in an environment with", "I usually keep my room", "I usually use my room to", "I am usually this type of sleeper", "How do you feel about borrowing and sharing", "How often do you have friends over", "How do you feel about overnight guests", "How do you feel about alcohol and other substances","Do you prefer to shop/eat together", "I'd prefer our door to be","I would describe my visitor frequency as","I would describe my visitors as","On the weekends","I usually go to bed","I usually wake up","How would you resolve an issue wherein a mess is made","When conflict arises this is how I deal with it","When I am annoyed","I would describe parties as","What type of relationship do you expect to have","You are bored by time alone","You want the big picture compared to the details","You often follow your head rather than your heart","You like to get your work done right away rather than procrastinate","You are easily stressed","You don't like to draw attention to yourself","You would ask why before who, what, when, where","You are rarely sceptical of others","You are generally organized","You are seldom blue","You like to talk rather than listen","You find it difficult to yell loudly","You would prefer a multiple choice test compared to essay questions","You often base morality on compassion rather than justice","You are often focused on the future","You would like to be good at fixing things rather than being good at fixing people","You like to keep your options open","You rely on your memory rather than making list","You are often described as energetic","You often accept things as they are","You rarely go out with your friends rather than stay home","You would rather fit in than stand out","You would prefer other's love rather than their respect","You have thick skin","You would prefer to prepare rather than improvise","You are generally relaxed rather than irritated","You often change your mood","You would like to play hard rather than work hard","I am","","52","53","54","55","56","57","58","59"]
        static var PersonalityList = [""]
        static var Buttonlist = [["Room","Library","Coffee Shop","Other"],["Morning","Afternoon","Evening","Night"],
            ["All Day and Night","Here and There","Last Minute","What's Studying?"]
           ,["Music","TVs","Talking","Silence"],
            ["Spotless","Occasionally Messy","Occasionally Neat","Messy"],
            ["Study","Socialize","Relax","Sleep"],
            ["Light","In the Middle","Heavy","I Don't Know"],
            ["Share Everything","Most Things","Some Things","Nothing"],
            ["All the Time","Sometimes","Occasionally","Never"],
            ["Anytime","Depends","Awkward","Never"],
            ["Yes","Occasionally","If It's Legal","Never"],
            ["Yes","Sometimes","Never","I Don't Know"],
            ["Open","Open Often","Rarely Open","Never"],
            ["Everyday","On the Weekend","Couple of Days","Rarely"],
            ["Very Outgoing","Quiet","Social","Studious"],
            ["Active","Mostly Active","Rarely Active","Home"],
            ["Evening","Late Evening","Night","Late Night"],
            ["Early Morning","Morning","Afternoon","Late Afternoon"],
            ["Instruct Them to Clean","Ask Politely","Clean It Yourself","What Mess"],
            ["Avoid the Issue","Create Chaos","Makes Me Quesy","Confident and Calm"],
            ["Leave Me Alone","Apologize to Me","Make It Up","Never Annoyed"],
            ["My Type of Scene","Occasionally","Rarely","Never"],
            ["Best Friends","Friends","Cordial","Eh"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Strongly Agree","Agree","Neutral","Disagree","Strongly Disagree"],
            ["Woman","Man","","",""],
            ["","","","",""],
            ["1","2","3","4","Next"],
            ["1","2","3","4","Next"],
            ["1","2","3","4","Next"],
            ["1","2","3","4","Next"],
            ["1","2","3","4","Next"],
            ["1","2","3","4","Next"],
            ["1","2","3","4","Next"]
        ]
        static var globalArray = [Int](repeating: 0, count: list.count)
        static var tagsString = ""
        static var counter = 0
        static var counter2 = 0
        static var globalText = ""
        static var nextString = ""
        static var buttonString = ""
        mutating func removeAll() {
            self = GlobalVariables()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let store = Storage.storage()
        _ = store.reference()
        _ = Firestore.firestore()
        let settings = self.db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.db.settings = settings
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.white
        QuestionLabel()
        ButtonText()
        finalScore()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
      
        // Do any additional setup after loading the view
    }
    
}
