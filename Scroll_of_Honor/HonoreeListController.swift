//
//  HonoreeListController.swift
//  Scroll_of_Honor
//
//  Created by Matthew Lollis on 11/22/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//
/*
import Foundation
import UIKit

struct honoree{
    var name = ""
    var rank = ""
    var war = ""
    var classYear = ""
    var photo = UIImage(named: "")
}

class HonoreeListController: UIViewController{
    
    var honorees = [honoree]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadHonorees()
        
        
        self.table.reloadData()
    }
    
    func loadHonorees() {
        let photo1 = UIImage(named: "photo3221.jpeg")!
        let hon = honoree(name: "John W. Hollowell", rank: "Sergeant", war: "WWI", classYear: "1917", photo: photo1)
        
        honorees += [hon]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return honorees.count
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        print("------------------ham-------------")
        let cellIdentifier = "honoreeCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HonoreeCell
        
        // Fetches the appropriate meal for the data source layout.
        let hon = honorees[indexPath.row]
        
        cell.label.text = hon.name + hon.rank + hon.war + hon.classYear
        cell.img.image = hon.photo
        
        return cell
    }
} */