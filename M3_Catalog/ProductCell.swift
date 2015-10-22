//
//  ProductCell.swift
//  M3_Catalog
//
//  Created by sdt5 on 2015. 10. 22..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//

import UIKit

protocol ProductCellDelegate : class {
    func addCart(productCode : String)
}


class ProductCell: UITableViewCell {

    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buttonAddCart: UIButton!
    
    //델리게이트
    weak var delegate : ProductCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
