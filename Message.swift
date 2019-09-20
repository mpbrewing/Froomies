 //
//  Message.swift
//  FR3
//
//  Created by Michael Brewington on 4/1/19.
//  Copyright © 2019 Michael Brewington. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    var Message: String?
    var Recipient: String?
    var Sender: String?
    var Time: String?
    
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        Message = dictionary["Message"] as? String
        Recipient = dictionary["Recipient"] as? String
        Sender = dictionary["Sender"] as? String
        Time = dictionary["Time"] as? String
    }
  
  //  @objc var Time: Int!
}
