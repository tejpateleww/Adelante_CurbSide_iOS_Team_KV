//
//  OrderItemCell.swift
//  Curbside Delivery
//
//  Created by Tej P on 16/11/21.
//

import UIKit

class OrderItemCell: UITableViewCell {
    
    //MARK: - Variables
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemQty: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    //MARK: - Life-Cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Custom methods
    func setupUI(){
        self.lblItemName.font = FontBook.bold.font(ofSize: 14)
        self.lblItemQty.font = FontBook.bold.font(ofSize: 14)
        self.lblItemPrice.font = FontBook.bold.font(ofSize: 14)
        self.lblDate.font = FontBook.regular.font(ofSize: 12)
    }
    
}
