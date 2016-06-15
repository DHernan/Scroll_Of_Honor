//
//  IndividualViewController.swift
//  Scroll_of_Honor
//
//  Created by Matthew Lollis on 11/25/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import Foundation
import UIKit
import Parse


class IndividualViewController: UIViewController {
    var firstName = ""
    var lastName = ""
    var rank = ""
    var war = ""
    var classYear = ""
    var photo = UIImage(named: "")
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var imgBack: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = photo
        imgBack.image = photo
        self.title = "\(firstName) \(lastName)"
        textBox.text = "War: \(war) \n Class: \(classYear) \n Rank: \(rank)"
        
        let query = PFQuery(className: "Honorees")
        // 2
        query.whereKey("firstName", equalTo: firstName)
        query.whereKey("lastName", equalTo: lastName)
        // 3
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for obj in objects!{
                    self.textBox.text = "War: \(self.war)\n\n\(obj.valueForKey("Description") as! String)"
                }
            } else {
                print("Error: \(error) \(error!.userInfo)")
            }
        }
        
    }
    
}
