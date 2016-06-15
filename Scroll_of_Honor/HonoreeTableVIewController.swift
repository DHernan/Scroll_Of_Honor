//
//  HonoreeTableVIewController.swift
//  Scroll_of_Honor
//
//  Created by Daniel Hernandez on 11/22/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import Foundation
import UIKit
import Parse

//struct Honoree{
//   var firstName = ""
//    var lastName = ""
//   var rank = ""
//   var war = ""
//   var classYear = ""
//   var photo = UIImage(named: "")
//}

class HonoreeTableViewController: UITableViewController, ESTBeaconManagerDelegate {
   let beaconManager = ESTBeaconManager()
   let beaconConnection = ESTBeaconConnection()
   var lastBeaconMajor = 0
   let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "ranged region")
   var honorees = [Honoree]()
   var searchingBeacons = false
   @IBOutlet weak var floatingView: UIView!
   @IBOutlet weak var useBeaconsButtonText: UIButton!
   
   @IBAction func useBeaconsButton(sender: UIButton) {
      if searchingBeacons {
         self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
         honorees = DatabaseService.sharedManager.getArray()
         table.reloadData()
         searchingBeacons = false
         lastBeaconMajor = 0
         useBeaconsButtonText.setTitle("Use Location At Scroll", forState: .Normal)
      } else {
         self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
         searchingBeacons = true
         useBeaconsButtonText.setTitle("Stop Using Location", forState: .Normal)
      }
   }
   
    @IBOutlet var table: UITableView!

   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.beaconManager.delegate = self
      self.beaconManager.requestAlwaysAuthorization()
      
      // Load the sample data.
      loadHonorees()
      
   }
   
   func loadHonorees() {
      honorees = DatabaseService.sharedManager.getArray()
//      print("Loaded \(honorees.count) Honorees for table")
//      DatabaseService.sharedManager.printCount()
      table.reloadData()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
    
   
    var index = 0
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        index = indexPath.row
        performSegueWithIdentifier("HonSegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "HonSegue"{
            let secVC = segue.destinationViewController as! IndividualViewController
            
           
            let send = honorees[index]
            
            secVC.firstName =  send.firstName
            secVC.lastName = send.lastName
            secVC.rank = send.rank
            secVC.war = send.war
            secVC.classYear = send.classYear
            secVC.photo = send.photo
            
        }
    }
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return honorees.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      // Table view cells are reused and should be dequeued using a cell identifier.
      let cellIdentifier = "HonoreeTableViewCell"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HonoreeTableViewCell
      
      let honoree = honorees[indexPath.row]
      
      cell.nameLabel.text = "\(honoree.firstName) \(honoree.lastName)"
      cell.yearLabel.text = honoree.classYear
      cell.rankWarLabel.text = honoree.serv + " " + honoree.rank + " in " + honoree.war
      cell.photoImageView.image = honoree.photo
      
      return cell
   }
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
//      self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
   }
   
   override func viewDidDisappear(animated: Bool) {
      super.viewDidDisappear(animated)
//      self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
   }
   
   func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
      print("Looking for beacons")
//      var counterThing = 0
      if let nearestBeacon = beacons.first as CLBeacon? {
         if ((nearestBeacon.major as Int) != lastBeaconMajor) /* && lastBeaconMajor != 0*/ {
            print("Time to refresh")
            self.honorees.removeAll()
            self.table.reloadData()

            honorees = DatabaseService.sharedManager.loadPeepsForBeacs(Int(nearestBeacon.major))
            self.table.reloadData()
//            print("\(counterThing) results")
//         } else if lastBeaconMajor == 0 {
//            print("Beacon is 0")
         } else {
            print("Same beacon")
         }
         print("Last Beacon was \(lastBeaconMajor). New Beacon is \(nearestBeacon.major)")
         lastBeaconMajor = (nearestBeacon.major as Int)
      }

   }
   
//   override func scrollViewDidScroll(scrollView: UIScrollView) {
//      var frame: CGRect = self.floatingView.frame
//      frame.origin.y = scrollView.contentOffset.y
//      floatingView.frame = frame
//      
//      view.bringSubviewToFront(floatingView)
//      
//   }
}