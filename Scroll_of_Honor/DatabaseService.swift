//
//  DatabaseService.swift
//  Scroll_of_Honor
//
//  Created by Daniel Hernandez on 11/30/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import Foundation
import Parse

struct Honoree{
   var firstName = ""
   var lastName = ""
   var rank = ""
   var serv = ""
   var war = ""
   var classYear = ""
   var hometown = ""
   var quad = ""
   var beaconMajor = ""
   var photo = UIImage(named: "")
}

//var dataServ: DatabaseService = DatabaseService()
//var honorees = [Honoree]()
private let _sharedManager = DatabaseService()

class DatabaseService: NSObject {
   class var sharedManager: DatabaseService {
      return _sharedManager
   }
   
   var honorees = [Honoree]()
   
   func loadHonorees() {
      print("Start loading Honorees")
      let query = PFQuery(className: "Honorees")

      query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
         if error == nil {
            //honorees += [hon1, hon2, hon3, hon4]
            let photo = UIImage(named: "honoree1")
            for obj in objects!{

               var hon = Honoree(firstName: "\(obj.valueForKey("firstName") as! String)", lastName: "\(obj.valueForKey("lastName") as! String)", rank: "\(obj.valueForKey("Rank") as! String)", serv: "\(obj.valueForKey("Service")!)",war: "\(obj.valueForKey("War")!)", classYear: "\(obj.valueForKey("Class_Year")!)",hometown: "\(obj.valueForKey("Hometown") as! String)", quad: "\(obj.valueForKey("Quadrant") as! String)", beaconMajor: "\(obj.valueForKey("Major")!)",photo: photo)
               
               if(obj.valueForKey("Image") as! String == "yes"){
                  hon.photo = UIImage(named: "\(hon.firstName) \(hon.lastName)")
               }
               
//               let query2 = PFQuery(className: "Wars")
//               query2.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
//                  if error == nil{
//                     for obj in objects!{
//                        if hon.war == obj.valueForKey("War_Id")! as! String{
//                           hon.war = obj.valueForKey("War_Name") as! String
//                        }
//                     }
////                     self.honorees += [hon]
//                  }
//               }
               
               let query2 = PFQuery(className: "Wars")
               query2.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
                  if error == nil{
                     for (var i = 0; i < self.honorees.count; i++) {
                        for obj in objects!{
                           if self.honorees[i].war == obj.valueForKey("War_Id")! as! String{
                              self.honorees[i].war = obj.valueForKey("War_Name") as! String
                           }
                        }
                     }
                     //                     self.honorees += [hon]
                  }
               }
               
//               let query3 = PFQuery(className: "Services")
//               query3.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
//                  if error == nil{
//                     for obj in objects!{
//                        if hon.serv == obj.valueForKey("Service_Id")! as! String{
//                           hon.serv = obj.valueForKey("Service_Name") as! String
//                        }
//                     }
//                     //self.honorees += [hon]
//                  }
//               }
               let query3 = PFQuery(className: "Services")
               query3.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
                  if error == nil{
                     for (var i = 0; i < self.honorees.count; i++) {
                        for obj in objects!{
                           if self.honorees[i].serv == obj.valueForKey("Service_Id")! as! String{
                              self.honorees[i].serv = obj.valueForKey("Service_Name") as! String
                           }
                        }
                     }
                     //                     self.honorees += [hon]
                  }
               }
               
               self.honorees.append(hon)
            }
            // self.table.reloadData()
            //print("Successfully retrieved: \(objects)")
            print("Final: \(self.honorees.count) Honorees")
         } else {
            print("Error: \(error) \(error!.userInfo)")
         }
      }
      


      
   }
   
   func getArray() -> [Honoree] {
      return honorees
   }
   
   func loadPeepsForBeacs(beacon: Int) -> [Honoree] {
      var peeps = [Honoree]()
      
      for i in honorees {
         if (i.beaconMajor == String(beacon)) {
            peeps.append(i)
         }
      }
      
      return peeps
   }
   
   func loadPeepsForDirection(direction: String) -> [Honoree] {
      var peeps = [Honoree]()
      for i in honorees {
         if (i.quad == direction) {
            peeps.append(i)
         }
      }
      return peeps
   }
   
   func printCount() {
      print("Really there are \(honorees.count)")
   }
}