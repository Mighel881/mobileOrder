//
//  Modifiers.swift
//  KFTMobile
//
//  Created by Raffer Li on 7/13/19.
//  Copyright © 2019 Raffer Li. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class Modify: UIViewController {
    
    
    
    var drinkCount: Int = 0
    
    var userName: String = ""
    
    var drinkSize: String = "Medium"
    var toppingList: String = ""
    

    
    @IBOutlet weak var sizeChose: UISegmentedControl!
    @IBOutlet weak var toppingLabel: UILabel!

    
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        ref.child(userID).child("count").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let drinkCount = snapshot.value as? String ?? ""
            
            ref.child(userID + "/order" + (drinkCount) + "/1size").setValue(self.drinkSize)

            }
        )
    }
    
    //Size segment control
    
    @IBAction func SIZEChoose(_ sender: Any) {
        switch sizeChose.selectedSegmentIndex
        {
        case 0:
            drinkSize = "Medium"
        case 1:
            drinkSize = "Large"
        default:
            drinkSize = "SIZE Error"
            
        }
        
        
    }
    
 
    var sugarPercent: String = "100%"
    var iceAmount: String = "Regular ice"
    
    
    @IBOutlet weak var sugarSeg: UISegmentedControl!
    
    @IBOutlet weak var iceSeg: UISegmentedControl!
    
    
    @IBAction func sugarAction(_ sender: Any) {
        switch sugarSeg.selectedSegmentIndex
        {
        case 0:
            sugarPercent = "0%"
        case 1:
            sugarPercent = "30%"
        case 2:
            sugarPercent = "50%"
        case 3:
            sugarPercent = "70%"
        case 4:
            sugarPercent = "100%"
        case 5:
            sugarPercent = "120%"
        default:
            sugarPercent = "SUGAR Error"
            
        }
    }
    
    @IBAction func iceAction(_ sender: Any) {
        switch iceSeg.selectedSegmentIndex
        {
        case 0:
            iceAmount = "No ice"
        case 1:
            iceAmount = "Less ice"
        case 2:
            iceAmount = "Regular ice"
        case 3:
            iceAmount = "More ice"
        default:
            iceAmount = "ICE Error"
            
        }
    }
    
    @IBOutlet weak var speReq: UITextField!
    
    @IBAction func FinishButton(_ sender: Any) {
        let speRequest = speReq.text ?? ""
        

        var drinkCountString: String = ""
        var drinkCountInt: Int = 0
        
        ref.child(userID).child("count").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let drinkCount = snapshot.value as? String ?? ""
        
            
            //var now = Date()
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "EEE MMM-dd hh:mm a"
            
            let dateString = dateFormatter.string(from: currentDate)
            
            
            ref.child(userID + "/order" + (drinkCount) + "/TIME").setValue(dateString)
            ref.child(userID + "/order" + (drinkCount) + "/4iceLevel").setValue(self.iceAmount)
            ref.child(userID + "/order" + (drinkCount) + "/3sugarLevel").setValue(self.sugarPercent)
            ref.child(userID + "/order" + (drinkCount) + "/5special").setValue(speRequest)
            ref.child(userID + "/order" + (drinkCount) + "/5status").setValue("Open")
            
            drinkCountString = drinkCount
            drinkCountInt = Int(drinkCountString)!
            drinkCountInt = drinkCountInt + 1
            ref.child(userID + "/count").setValue(String(drinkCountInt))
            
            
            
            ref.child("1globalCall").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let globalCall = snapshot.value as? String ?? ""
                ref.child(userID + "/order" + (drinkCount) + "/CALL").setValue(globalCall)
                
                var globalCallUpdate: Int = Int(globalCall)!
                globalCallUpdate = globalCallUpdate + 1
                ref.child("1globalCall").setValue(String(globalCallUpdate))
                
            })
            
            
        })

        self.view.endEditing(true)

    
    }
}

