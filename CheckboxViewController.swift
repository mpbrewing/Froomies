//
//  CheckboxViewController.swift
//  FR3
//
//  Created by Michael Brewington on 11/26/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CheckboxViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    
let list = ["Affectionate","Aloof","Ambitious","Amusing"]

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return(list.count)
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    cell.textLabel?.text = list[indexPath.row]
    return(cell)
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        scroller.contentSize = CGSize(width: scroller.contentSize.width, height: scroller.contentSize.height)
        //
        //
        
    }
    @IBAction func button(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        scroller.isScrollEnabled = true
        // Do any additional setup after loading the view
    }
    
}
