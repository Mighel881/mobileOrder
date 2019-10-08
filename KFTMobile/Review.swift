//
//  Review.swift
//  KFTMobile
//
//  Created by Raffer Li on 8/1/19.
//  Copyright © 2019 Raffer Li. All rights reserved.
//
import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var orderTitle: UILabel!
}

class reviewTable: UIViewController {
    
    var detailedDrink: String = ""
    
    @IBOutlet weak var tableView: UITableView!

    
    var orders: [String] = []
    var orderCountInt: String = ""

    override func viewDidLoad() {
    
    super.viewDidLoad()
    tableView.tableFooterView = UIView(frame: CGRect.zero)

    ref.child(userID).child("count").observe(.value, with: { (snapshot) in
    
            let orderCountData = snapshot.value as? String
        
            if let actualCountData = orderCountData {
                
                self.orderCountInt = actualCountData
        }
        
        self.orders.removeAll()
        
        
        var i:Int = (Int(self.orderCountInt)!)
        
        while i > 0 {
                //while i < (Int(orderCount)!)-1{
                i = i - 1
            
                ref.child(userID).child("order" + String(i)).child("TIME").observe(.value, with: { (snapshot) in
                    
                    let orderTimeStamp = snapshot.value as? String
                
                    
                    if let actualTimeStamp = orderTimeStamp
                    {
                        self.orders.append("Order on " + actualTimeStamp)
                        
                    }
                    self.tableView.reloadData()
                })
        }
        
        
        
    })


   }
    
}

extension reviewTable: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let orderTitle = orders[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "order") as! OrderCell
        cell.orderTitle.text = orderTitle
        
        ref.child(userID).child("order" + String(orders.count - indexPath.row)).child("5status").observe(.value, with: { (snapshot) in
            
        
            
            
            let openorClose = snapshot.value as? String ?? ""
            

            
       
        
        if (openorClose == "Open") {
            cell.backgroundColor = UIColor(red: 252/255, green: 232/255, blue:173/255, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 190/255, green: 255/255, blue:210/255, alpha: 1)
        }
        
             })
        return cell
        
    }
    

    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        detailedDrink = "order" + String(orders.count - indexPath.row)
                self.performSegue(withIdentifier: "detailSeg", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailSeg"){
            let displayVC = segue.destination as! detailViewController
            displayVC.orderID = detailedDrink
        }
    }
    
    
}

class detailViewController: UIViewController {
    
    
    var orderID: String = ""
    
    @IBOutlet weak var progressName: UILabel!
    
    @IBOutlet weak var drinkName: UILabel!
    
    @IBOutlet weak var sizeName: UILabel!
    
    @IBOutlet weak var toppingName: UITextView!
    
    @IBOutlet weak var iceName: UILabel!
    
    @IBOutlet weak var sugarName: UILabel!
    
    @IBOutlet weak var topLAB: UILabel!
    
    @IBOutlet weak var callName: UILabel!
    
    
    override func viewDidLoad() {
        
        ref.child(userID).child(orderID).child("CALL").observe(.value, with: { (snapshot) in
            
            
            let stringName = snapshot.value as? String ?? ""
            
            self.callName.text = stringName
        })
        ref.child(userID).child(orderID).child("0drinktype").observe(.value, with: { (snapshot) in
            
            
            let stringName = snapshot.value as? String ?? ""
            
            self.drinkName.text = stringName
        })
        ref.child(userID).child(orderID).child("1size").observe(.value, with: { (snapshot) in
            
            
            let stringName = snapshot.value as? String ?? ""
            
            self.sizeName.text = stringName
        })
        ref.child(userID).child(orderID).child("2topping").observe(.value, with: { (snapshot) in
            
            
            let stringName = snapshot.value as? String ?? ""
            
            self.toppingName.text = stringName
            
            if (stringName == ""){
                self.topLAB.text = ""
            }
        })
        ref.child(userID).child(orderID).child("3sugarLevel").observe(.value, with: { (snapshot) in
            
            
            let stringName = snapshot.value as? String ?? ""
            
            self.sugarName.text = stringName
        })
        ref.child(userID).child(orderID).child("4iceLevel").observe(.value, with: { (snapshot) in
            
            
            let stringName = snapshot.value as? String ?? ""
            
            self.iceName.text = stringName
        })
        ref.child(userID).child(orderID).child("5status").observe(.value, with: { (snapshot) in
            
            
            let stringName = snapshot.value as? String ?? ""
            
            if(stringName == "Open"){
            self.progressName.text = "Order in progress"
            } else {
                self.progressName.text = "Order complete!"
            }
            
        })
        
    }
    
    
}
