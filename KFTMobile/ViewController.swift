//
//  ViewController.swift
//  KFTMobile
//
//  Created by Raffer Li on 7/13/19.
//  Copyright © 2019 Raffer Li. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

let ref = Database.database().reference()
let userID = Auth.auth().currentUser!.uid


class ViewController: UITableViewController {

    // ORDER PLACEMENT, REVIEW HAS BEEN MOVED TO SEPARATE FILE (8.3)
    
    var callNumber: Int = 0
    var drinkType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
        
            if (tableView.tag == 1)
            {
                if indexPath.row == 0
                {
                    drinkType = "Black Tea"
                }else if indexPath.row == 1
                {
                    drinkType = "Green Tea"
                }else if indexPath.row == 2
                {
                    drinkType = "Oolong Tea"
                }else if indexPath.row == 3
                {
                    drinkType = "Winter Melon Tea"
                }else if indexPath.row == 4
                {
                    drinkType = "Honey Tea"
                }else if indexPath.row == 5
                {
                    drinkType = "Honey Black Tea"
                }else if indexPath.row == 6
                {
                    drinkType = "Honey Green Tea"
                }else if indexPath.row == 7
                {
                    drinkType = "Honey Oolong Tea"
                }
                self.performSegue(withIdentifier: "ClassicSeg", sender: self)
                
            }
            
           if (tableView.tag == 2)
           {
                if indexPath.row == 0
                {
                    drinkType = "Mango Green Tea"
                }else if indexPath.row == 1
                {
                    drinkType = "Peach Oolong Tea"
                }else if indexPath.row == 2
                {
                    drinkType = "Strawberry Lemon Green Tea"
                }else if indexPath.row == 3
                {
                    drinkType = "Orange Green Tea"
                }else if indexPath.row == 4
                {
                    drinkType = "Sunshine Pineapple Tea"
                }else if indexPath.row == 5
                {
                    drinkType = "Very Berry Green Tea"
                }else if indexPath.row == 6
                {
                    drinkType = "Lychee Punch"
                }else if indexPath.row == 7
                {
                    drinkType = "Grapefruit Green Tea"
                }
                self.performSegue(withIdentifier: "PunchSeg", sender: self)

                
           }
            
           if (tableView.tag == 3)
            {
                if indexPath.row == 0
                {
                    drinkType = "Black Milk Tea"
                }else if indexPath.row == 1
                {
                    drinkType = "Green Milk Tea"
                }else if indexPath.row == 2
                {
                    drinkType = "Oolong Milk Tea"
                }else if indexPath.row == 3
                {
                    drinkType = "Winter Melon Milk Tea"
                }else if indexPath.row == 4
                {
                    drinkType = "Honey Milk Tea"
                }else if indexPath.row == 5
                {
                    drinkType = "Honey Green Milk Tea"
                }else if indexPath.row == 6
                {
                    drinkType = "Honey Oolong Milk Tea"
                }else if indexPath.row == 7
                {
                    drinkType = "Taro Milk Tea"
                }
                self.performSegue(withIdentifier: "MilkTeaSeg", sender: self)

                
            }
            
           if (tableView.tag == 4)
            {
                if indexPath.row == 0
                {
                    drinkType = "Strawberry Milk Slush"
                }else if indexPath.row == 1
                {
                    drinkType = "Oreo Slush"
                }else if indexPath.row == 2
                {
                    drinkType = "Mango Snow"
                }else if indexPath.row == 3
                {
                    drinkType = "Mango Slush"
                }else if indexPath.row == 4
                {
                    drinkType = "Mango Slush"
                }else if indexPath.row == 5
                {
                    drinkType = "Passion Fruit Slush"
                }else if indexPath.row == 6
                {
                    drinkType = "Taro Slush"
                }else if indexPath.row == 7
                {
                    drinkType = "Pineapple Slush"
                }else if indexPath.row == 8
                {
                    drinkType = "Matcha Red Bean Slush"
                }
                self.performSegue(withIdentifier: "SlushSeg", sender: self)

            }
            
            if (tableView.tag == 5)
            {
                if indexPath.row == 0
                {
                    drinkType = "Chai Milk"
                }else if indexPath.row == 1
                {
                    drinkType = "Matcha Milk"
                }else if indexPath.row == 2
                {
                    drinkType = "Oreo Wow"
                }else if indexPath.row == 3
                {
                    drinkType = "Cocoa Cream Wow"
                }else if indexPath.row == 4
                {
                    drinkType = "Red Bean Wow"
                }else if indexPath.row == 5
                {
                    drinkType = "Herbal Jelly Wow"
                }else if indexPath.row == 6
                {
                    drinkType = "Sesame Matcha"
                }else if indexPath.row == 7
                {
                    drinkType = "Ginger Milk"
                }
                self.performSegue(withIdentifier: "MilkSeg", sender: self)
                
            }
 
            if (tableView.tag == 6)
            {
                if indexPath.row == 0
                {
                    drinkType = "Yogurt Green Tea"
                }else if indexPath.row == 1
                {
                    drinkType = "Yogurt Grapefruit"
                }else if indexPath.row == 2
                {
                    drinkType = "Yogurt Orange"
                }
                self.performSegue(withIdentifier: "YogurtSeg", sender: self)
                
            }
            ref.child(userID).child("count").observeSingleEvent(of: .value, with: { (snapshot) in

                let drinkCount = snapshot.value as? String ?? ""
    
                
                ref.child(userID + "/order" + drinkCount + "/0drinktype").setValue(self.drinkType)
                
            })
            
        }


    
    // TOPPINGS CONTROL
    
    var drinkCount: Int = 0
 
    var topList: String = ""
    var finaltopList: String = ""
    
    var addBoba: String = "0"
    var addHJelly: String = "0"
    var addMJelly: String = "0"
    var addNJelly: String = "0"
    var addPudding: String = "0"
    var addAJelly: String = "0"
    var addMPop: String = "0"
    var addGPop: String = "0"
    var addCPop: String = "0"
    var addMilk: String = "0"
    
    
    @IBOutlet weak var bobaLabel: UILabel!
    @IBOutlet weak var hJellyLabel: UILabel!
    @IBOutlet weak var mJellyLabel: UILabel!
    @IBOutlet weak var nJellyLabel: UILabel!
    @IBOutlet weak var PuddingLabel: UILabel!
    @IBOutlet weak var aJellyLabel: UILabel!
    @IBOutlet weak var mBobaLabel: UILabel!
    @IBOutlet weak var gBobaLabel: UILabel!
    @IBOutlet weak var cBobaLabel: UILabel!
    @IBOutlet weak var MilkCapLabel: UILabel!
    

    
    func writeToBase() {
        
        topList = ""
        
        if (addBoba != "0" && addBoba != "1"){
            topList = topList + "Boba " + addBoba + ", "
        }else if (addBoba == "1"){
            topList = topList + "Boba, "
        }
        
        if (addHJelly != "0" && addHJelly != "1"){
            topList = topList + "Herbal Jelly " + addHJelly + ", "
        }else if (addHJelly == "1"){
            topList = topList + "Herbal Jelly, "
        }
        
        if (addMJelly != "0" && addMJelly != "1"){
            topList = topList + "Mango Jelly " + addMJelly + ", "
        }else if (addMJelly == "1"){
            topList = topList + "Mango Jelly, "
        }
        
        if (addNJelly != "0" && addNJelly != "1"){
            topList = topList + "Nata Jelly " + addNJelly + ", "
        }else if (addNJelly == "1"){
            topList = topList + "Nata Jelly, "
        }
        
        if (addPudding != "0" && addPudding != "1"){
            topList = topList + "Pudding " + addPudding + ", "
        }else if (addPudding == "1"){
            topList = topList + "Pudding, "
        }
        
        if (addAJelly != "0" && addAJelly != "1"){
            topList = topList + "Aloe Jelly " + addAJelly + ", "
        }else if (addAJelly == "1"){
            topList = topList + "Aloe Jelly, "
        }
        
        if (addMPop != "0" && addMPop != "1"){
            topList = topList + "Mango Popping Boba " + addMPop + ", "
        }else if (addMPop == "1"){
            topList = topList + "Mango Popping Boba, "
        }
            
        if (addGPop != "0" && addGPop != "1"){
            topList = topList + "Grape Popping Boba " + addGPop + ", "
        }else if (addGPop == "1"){
            topList = topList + "Grape Popping Boba, "
        }
        
        if (addCPop != "0" && addCPop != "1"){
            topList = topList + "Coffee Popping Boba " + addCPop + ", "
        }else if (addCPop == "1"){
            topList = topList + "Coffee Popping Boba, "
        }
        
        if (addMilk != "0" && addMilk != "1"){
            topList = topList + "Milk Cap " + addMilk + ", "
        }else if (addMilk == "1"){
            topList = topList + "Milk Cap, "
        }
        
        if (topList != ""){
            topList.remove(at: topList.index(before: topList.endIndex))
        }

        finaltopList = String(topList.dropLast())
        
        ref.child(userID).child("count").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let drinkCount = snapshot.value as? String ?? ""
            
            
            ref.child(userID + "/order" + drinkCount + "/2topping").setValue(self.finaltopList)
            
        })
        
    }
    
    @IBAction func bobaStepper(_ sender: UIStepper) {
        
        bobaLabel.text = Int(sender.value).description
        
        addBoba = bobaLabel.text!
        
        writeToBase()
        
        
    }
    
    @IBAction func hJellyStepper(_ sender: UIStepper) {
        
        hJellyLabel.text = Int(sender.value).description
        
        
        addHJelly = hJellyLabel.text!
        writeToBase()
    }

    @IBAction func mJellyStepper(_ sender: UIStepper) {
        
        mJellyLabel.text = Int(sender.value).description
        
        
        addMJelly = mJellyLabel.text!
        writeToBase()
    }
    
    @IBAction func nJellyStepper(_ sender: UIStepper) {
        
        nJellyLabel.text = Int(sender.value).description
        
        
        addNJelly = nJellyLabel.text!
        writeToBase()
    }

    @IBAction func PuddingStepper(_ sender: UIStepper) {
        
        PuddingLabel.text = Int(sender.value).description
        
        
        addPudding = PuddingLabel.text!
        writeToBase()
    }

    @IBAction func aJellyStepper(_ sender: UIStepper) {
        
        aJellyLabel.text = Int(sender.value).description
        
        
        addAJelly = aJellyLabel.text!
        writeToBase()
    }
    
    @IBAction func mBobaStepper(_ sender: UIStepper) {
        
        mBobaLabel.text = Int(sender.value).description
        
        
        addMPop = mBobaLabel.text!
        writeToBase()
    }
    
    @IBAction func gBobaStepper(_ sender: UIStepper) {
        
        gBobaLabel.text = Int(sender.value).description
        
        
        addGPop = gBobaLabel.text!
        writeToBase()
    }
    
    @IBAction func cBobaStepper(_ sender: UIStepper) {
        
        cBobaLabel.text = Int(sender.value).description
        
        
        addCPop = cBobaLabel.text!
        writeToBase()
    }
    
    @IBAction func MilkFoamStepper(_ sender: UIStepper) {
        
        MilkCapLabel.text = Int(sender.value).description
        
        addMilk = MilkCapLabel.text!
        writeToBase()
    }



    
 
    
}

