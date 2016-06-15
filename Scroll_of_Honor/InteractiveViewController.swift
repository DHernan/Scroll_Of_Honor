//
//  InteractiveViewController.swift
//  Scroll_of_Honor
//
//  Created by John Lucas Garofalo on 11/22/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import UIKit

var currDir: String = "NW"

class InteractiveViewController: UIViewController {

    enum Way {
        case left
        case right
    }
    
    //Member variables
    let hsample = HonoreeSample()
    var currHonorees = [Honoree]()

    
    private var embedViewController: HonorCollectionViewController!
    @IBOutlet weak var container: UIView!
    
    //Outlets
    @IBOutlet weak var monumentView: UIImageView!

    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.collectView.reloadData()
        updateHonorees(currDir)
    }

    func HonoreeForIndexPath(indexPath: NSIndexPath)->Honoree{
        return currHonorees[indexPath.row]
    }
    
    func updateHonorees(direction: String){
        currHonorees = hsample.getMyHonorees(direction)
        embedViewController.currHonorees = hsample.getMyHonorees(direction)
    }
    
    @IBAction func rotateLeft(sender: AnyObject) {
        UIView.animateWithDuration(1.0, animations: {
            self.monumentView.transform = CGAffineTransformConcat(self.monumentView.transform,CGAffineTransformMakeRotation(CGFloat(-M_PI_2)))
        })
        changeDirection(.left)
        updateHonorees(currDir)
    }
    
    @IBAction func rotateRight(sender: AnyObject) {
        UIView.animateWithDuration(1.0, animations: {
                        self.monumentView.transform = CGAffineTransformConcat(self.monumentView.transform,CGAffineTransformMakeRotation(CGFloat(M_PI_2)))
        })
        changeDirection(.right)
        updateHonorees(currDir)
    }
    
    private func changeDirection(w: Way){
        switch(w){
        case .left:
            switch(currDir){
            case "NE":
                currDir = "NW"
            case "NW":
                currDir = "SW"
            case "SW":
                currDir = "SE"
            case "SE":
                currDir = "NE"
            default:
               currDir = "NW"
            }
        case .right:
            switch(currDir){
            case "NE":
                currDir = "SE"
            case "NW":
                currDir = "NE"
            case "SW":
                currDir = "NW"
            case "SE":
                currDir = "SW"
            default:
               currDir = "NW"
            }
        }
        
        updateHonorees(currDir)
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let evc = segue.destinationViewController as? HonorCollectionViewController where segue.identifier == "embedd" {
            self.embedViewController = evc
        }
    }
}
