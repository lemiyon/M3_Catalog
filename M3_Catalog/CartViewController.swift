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
        
        
        //이렇게 뷰를 바꾸는 것은 시스템이 자동으로 화면(뷰)를 업데이트하도록 기다리는 것.
        /* 뷰를 바꾸는 것은 두가지가 있다.
        1. 내가 강제(데이터 소스 필요한 녀석들). 리로드를 메인 스레드에서 하지 않으면 리프레시가 되질 않는다. 리로드는 꼭 메인 스레드에서 하세요!
        2. 시스템이 할 때 까지 기다린다. 아래의 예는 시스템이 할 때 까지 기다리는 것
*/
        cell.productName.text =  cartManager.userCart[indexPath.row].name
        cell.productEach.text = "\(cartManager.userCart[indexPath.row].count)"
        cell.delegate = self
        return cell
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cart"
    }
    
    //view가 화면에 안 보이게 되는 순간 호출
    override func viewDidDisappear(animated: Bool) {
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
        //object는 이걸 받을 사람을 하는 것!! 굳이 하진 않는게 좋다 =. 굳이 하나만 커뮤니케이션을 하겠다면!
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
