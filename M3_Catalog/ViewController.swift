//
//  ViewController.swift
//  M3_Catalog
//
//  Created by sdt5 on 2015. 10. 22..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ProductCellDelegate, CartCellDelegate {

    var data : [String]!
    var dataPrice : [Int]!
    
    
    //사용자의 카트 안 요소
    //안타깝게 요소 갯수가 처리가 안된다. 이건 자료형을 변경해야 한다.
    var userCart : [(String, Int)] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    //ProductCellDelegate
    //카트 아이콘을 누르면 userCart에 추가하고, 이하의 카트 섹션에도 추가할 수 있게 데이터를 준비한다.
    func addCart(productName: String) {
    
        //같은 이름의 아이템이 있는지 검사해 있으면 수량만 늘려준다.
    for var item in userCart
    {
        if item.0 == productName
        {
            item.1++
            tableView.reloadData()
            return
            }
    
    }
    
    
    //만약 같은 이름의 아이템이 없으면 새로 추가해 준다.
    //배열의 맨 앞에 추가하게 Index를 0으로
    userCart.insert((productName, 1), atIndex: 0)
    
         tableView.reloadData()
    }
    
    
    func addItem(productName : String) {
        for var item in userCart
        {
            if item.0 == productName
            {
                item.1++
                 tableView.reloadData()
                return
            }
        }
         tableView.reloadData()
    }
    
    //-버튼 누를 시 작동. userCart내에서 해당하는 이름의 Product의 개수(ea)를 1씩 빼고, 개수가 0이 되면 아예 userCart내에서 지운다.
    func removeItem(productName : String)
    {
        var index : Int = 0
        
        for var item in userCart
        {
            if item.0 == productName
            {
                item.1--
                
                if item.1 <= 0
                {
                    userCart.removeAtIndex(index)
                }
            }
            
            index++
        }
        
         tableView.reloadData()
        
    }
    

    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Catalog"
        }
        else
        {
            return "Cart"
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
        let cell = tableView.dequeueReusableCellWithIdentifier("PRODUCT_CELL")
            as! ProductCell
        cell.productImage.image = UIImage(named: "\(data[indexPath.row]).png")
        cell.productName.text = data[indexPath.row]
        cell.productPrice.text = "\(dataPrice[indexPath.row])"
        cell.delegate = self
            return cell
        }
        else
        {
        let cell = tableView.dequeueReusableCellWithIdentifier("CART_CELL") as! CartCell
        
        cell.productName.text = userCart[indexPath.row].0
        cell.productEach.text = "\(userCart[indexPath.row].1)"
        cell.delegate = self
            return cell
        }
    
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
        return data.count
        }
        else
        {
        return userCart.count
        }
        
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

