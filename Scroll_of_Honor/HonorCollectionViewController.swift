//
//  HonorCollectionViewController.swift
//  Scroll_of_Honor
//
//  Created by John Lucas Garofalo on 11/23/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import UIKit


private let reuseIdentifier = "honorcell"
private let sectionInsets = UIEdgeInsets(top: 1.50, left: 1.0, bottom: 1.5, right: 1.0)

class HonorCollectionViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate {

    var highlighted: Honoree!
    
    var currHonorees = [Honoree]() {
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
//    let hsample = HonoreeSample()
    
    func updateUI(){
        //currHonorees = hsample.getMyHonorees(currDir)
         currHonorees = DatabaseService.sharedManager.loadPeepsForDirection(currDir)
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        updateUI()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }



    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return currHonorees.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HonoreeCollectionViewCell
    
        // Configure the cell
        let hon = currHonorees[indexPath.row]
        
        if (hon.photo != nil){
            if let imageData = UIImage(named: "\(hon.firstName) \(hon.lastName)"){
                cell.imageView!.image = imageData //UIImage(named: "\(hon.firstName) \(hon.lastName)")
            }
        }
        cell.nameLabel.text = "\(hon.firstName) \(hon.lastName)"
        
        //cell.backgroundColor = UIColor.orangeColor()
      cell.layer.borderColor = UIColor.whiteColor().CGColor
      cell.layer.borderWidth = 1
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("row: \(indexPath.row)")
        NSLog("section: \(indexPath.section)")
        NSLog("\(currHonorees[indexPath.row].firstName) \(currHonorees[indexPath.row].lastName)")
        highlighted = currHonorees[indexPath.row]
        
        if let honor = highlighted{
            let profileAlert = UIAlertController(title: "\(honor.firstName) \(honor.lastName)", message: "\(honor.hometown)\nClass Year: \(honor.classYear)\n\n\(honor.rank)\n\(honor.serv)\n\(honor.war)", preferredStyle: UIAlertControllerStyle.Alert)
 //           profileAlert.addAction(UIAlertAction(title: "Profile", style: UIAlertActionStyle.Default, handler: nil))
            profileAlert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(profileAlert, animated: true, completion: nil)
        }
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
           return sectionInsets
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 120, height: 120)
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
