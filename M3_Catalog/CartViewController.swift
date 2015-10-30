//
//  CartViewController.swift
//  M3_Catalog
//
//  Created by sdt5 on 2015. 10. 26..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, CartCellDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    //노티피케이션센터를 이용한 모델 변화 수신용
    let modelChangeNotification = "ModelChangeNotification"
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CART_CELL") as! CartCell
        let cartManager = CartManager.sharedManager
        
        
        cell.productName.text =  cartManager.userCart[indexPath.row].0
        cell.productEach.text = "\(cartManager.userCart[indexPath.row].1)"
        cell.delegate = self
        return cell
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cart"
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.sharedManager.count()
    }
    
    //CartCell Delegate구현
    func addItem(productName: String) {
        CartManager.sharedManager.addItem(itemName: productName)
        tableView.reloadData()
        
    }
    
    func removeItem(productName: String) {
        CartManager.sharedManager.removeItem(itemName: productName)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleModelChange:", name: modelChangeNotification, object: nil)
        
        
        // Do any additional setup after loading the view.
    }

    func handleModelChange(noti : NSNotification)
    {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
