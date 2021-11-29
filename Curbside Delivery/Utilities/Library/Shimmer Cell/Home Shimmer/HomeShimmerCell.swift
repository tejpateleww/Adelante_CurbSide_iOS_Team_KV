//
//  HomeShimmerCell.swift
//  Curbside Delivery
//
//  Created by Tej P on 29/11/21.
//

import UIKit
import UIView_Shimmer

class HomeShimmerCell: UITableViewCell, ShimmeringViewProtocol {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblTitleOrderAmount: UILabel!
    @IBOutlet weak var lblTitleCarNumber: UILabel!
    @IBOutlet weak var lblTitleParkingNumber: UILabel!
    @IBOutlet weak var lblOrderAmount: UILabel!
    @IBOutlet weak var lblCarNumber: UILabel!
    @IBOutlet weak var lblParkingNumber: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.lblName,
            self.lblOrderId,
            self.lblTitleOrderAmount,
            self.lblTitleCarNumber,
            self.lblTitleParkingNumber,
            self.lblOrderAmount,
            self.lblCarNumber,
            self.lblParkingNumber
        ]
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwContainer.layer.masksToBounds = true
        vwContainer.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.200366896)
        vwContainer.layer.borderWidth = 1.0
        vwContainer.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
