//
//  OfflineVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 18/11/21.
//

import UIKit

class OfflineVC: BaseViewController {
    
    @IBOutlet weak var imgOffline: UIImageView!
    @IBOutlet weak var lblOffline: UILabel!
    @IBOutlet weak var btnRetry: submitButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareView()
    }
    
    func prepareView(){
        self.setupUI()
        self.setupData()
    }
    
    func setupUI(){
        self.lblOffline.font = FontBook.regular.font(ofSize: 15)
    }
    
    func setupData(){
        
    }

    @IBAction func btnRetryAction(_ sender: Any) {
        AppDelegate.current.checkConnction()
    }
    
    
}
