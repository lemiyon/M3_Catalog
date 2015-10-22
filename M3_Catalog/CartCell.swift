//
//  CartCell.swift
//  M3_Catalog
//
//  Created by sdt5 on 2015. 10. 22..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//

import UIKit

protocol CartCellDelegate : class{
    func addItem(productName : String)
    func removeItem(productName : String)
}

class CartCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productEach: UILabel!
    @IBOutlet weak var buttonAddProduct: UIButton!
    @IBOutlet weak var buttonRemoveProduct: UIButton!

    weak var delegate : CartCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //자신이 몇번에 있는지 모르려나?
    @IBAction func removeItem(sender: AnyObject) {
        self.delegate.removeItem(productName.text!)
    }

    @IBAction func addItem(sender: AnyObject) {
        self.delegate.addItem(productName.text!)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
