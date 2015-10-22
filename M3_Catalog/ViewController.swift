//
//  ViewController.swift
//  M3_Catalog
//
//  Created by sdt5 on 2015. 10. 22..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ProductCellDelegate {

    var data : [String]!
    var dataPrice : [Int]!
    
    func addCart(productCode : String) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PRODUCT_CELL")
            as! ProductCell
        cell.productImage.image = UIImage(named: "\(data[indexPath.row]).png")
        cell.productName.text = data[indexPath.row]
        cell.productPrice.text = "\(dataPrice[indexPath.row])"
        cell.delegate = self
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        data = ["baseball","basketball","football", "golf", "rugby", "shuttlecock", "tennis", "volleyball", "icehockey","billiard"]
        
        
        dataPrice = [1000,700,800,900,5000,400,150,600,800,500]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

