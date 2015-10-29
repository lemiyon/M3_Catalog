//
//  ViewController.swift
//  M3_Catalog
//  http://stackoverflow.com/questions/23755974/cocoapods-pod-install-takes-forever/31309780#31309780
//  pod install이 백만년은 걸릴 거 같을 때 참조
//  Created by sdt5 on 2015. 10. 22..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ProductCellDelegate {
    
    var data : [String]!
    var dataPrice : [Int]!
    
    @IBOutlet weak var tableView: UITableView!
    
    //ProductCellDelegate
    //카트 아이콘을 누르면 userCart에 추가하고, 이하의 카트 섹션에도 추가할 수 있게 데이터를 준비한다.
    
    //Part2. 이제 카트 아이콘을 누르면 CartViewController에 있는 테이블 뷰의 데이터로 보내줘야 한다.
    //즉, 데이터를 그때 그때 넘겨주던가 아니면 모델을 만들어 저장을 하고 거기서 참조를 하는 방식으로 가야 할 것 같다.
    //그렇다면 CatalogDataManager에 이 자료를 넘겨줘야 한다. 이제 부터 모든 카트 관련 처리는 카트 매니져에서 한다.
    func addCart(productName: String) {
        CartManager.sharedManager.addItem(itemName: productName)
    }
    
    
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

            return "Catalog"
        
    }
    
    @IBAction func pressClearDB(sender: AnyObject) {
        CartManager.sharedManager.clearDB()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)!
        let selected  = data[indexPath.row]
        
        print("사용자가 선택한 데이터 : \(selected)")
        
        let detailVC = segue.destinationViewController as! DetailViewController
        detailVC.itemName = selected
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

