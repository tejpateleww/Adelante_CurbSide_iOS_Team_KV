//
//  DeliverSuccessPopUpVC.swift
//  Curbside Delivery
//
//  Created by Tej P on 17/11/21.
//

import UIKit

class DeliverSuccessPopUpVC: BaseViewController {
   
    //MARK: - Variables
    @IBOutlet weak var imgCorrect: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblMessage2: UILabel!
    @IBOutlet weak var btnOg: submitButton!
    
    @IBOutlet private weak var viewPopupUI:UIView!
    @IBOutlet private weak var viewMain:UIView!
    
    var customTabBarController: CustomTabBarVC?
    
    //MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }

    //MARK: - Custom Method
    func prepareView(){
        self.setupUI()
        self.setupData()
    }
    
    func setupUI(){
        self.viewPopupUI.clipsToBounds = true
        self.viewPopupUI.layer.cornerRadius = 10
        self.lblMessage.font = FontBook.bold.font(ofSize: 25)
        self.lblMessage2.font = FontBook.bold.font(ofSize: 25)
        self.showViewWithAnimation()
    }
    
    func setupData(){
        
    }
    
    //MARK: - UIButton Action Method
    @IBAction func btnOkAction(_ sender: Any) {
        self.hideViewWithAnimation()
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)
    }
    
    //MARK: - Animation Method
    func showViewWithAnimation() {
        
        self.view.alpha = 0
        self.viewPopupUI.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.3) {
            self.viewPopupUI.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1
        }
    }
    
    func hideViewWithAnimation() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.viewPopupUI.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.view.alpha = 0
            
        }, completion: {
            (value: Bool) in
            
            self.removeFromParent()
            self.view.removeFromSuperview()
        })
    }
    
}
