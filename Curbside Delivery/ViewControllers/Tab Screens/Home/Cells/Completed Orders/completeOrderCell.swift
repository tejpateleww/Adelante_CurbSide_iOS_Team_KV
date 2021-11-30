//
//  completeOrderCell.swift
//  Curbside Delivery
//
//  Created by Tej P on 15/11/21.
//

import UIKit

class completeOrderCell: UITableViewCell {
    
    //MARK: - Variables
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblTitleOrderAmount: UILabel!
    @IBOutlet weak var lblTitleCarNumber: UILabel!
    @IBOutlet weak var lblTitleParkingNumber: UILabel!
    @IBOutlet weak var lblOrderAmount: UILabel!
    @IBOutlet weak var lblCarNumber: UILabel!
    @IBOutlet weak var lblParkingNumber: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vWOrderStatus: UIView!
    

    //MARK: - awakeFromNib
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
        self.lblName.font = FontBook.bold.font(ofSize: 21)
        self.lblOrderId.font = FontBook.bold.font(ofSize: 12)
        self.lblTitleOrderAmount.font = FontBook.bold.font(ofSize: 12)
        self.lblTitleCarNumber.font = FontBook.bold.font(ofSize: 12)
        self.lblTitleParkingNumber.font = FontBook.bold.font(ofSize: 12)
        self.lblOrderAmount.font = FontBook.bold.font(ofSize: 14)
        self.lblCarNumber.font = FontBook.bold.font(ofSize: 14)
        self.lblParkingNumber.font = FontBook.bold.font(ofSize: 14)
        self.lblOrderStatus.font = FontBook.regular.font(ofSize: 12)
        
        self.vwContainer.clipsToBounds = true
        self.vwContainer.layer.cornerRadius = 5
        
        self.vWOrderStatus.clipsToBounds = true
        self.vWOrderStatus.layer.cornerRadius = 5
        self.vWOrderStatus.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
